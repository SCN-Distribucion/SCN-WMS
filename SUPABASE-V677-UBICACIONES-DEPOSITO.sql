-- SCN-WMS V6.7.7 - Ubicaciones fisicas de Deposito
-- Ejecutar una sola vez en Supabase SQL Editor antes de usar el nuevo modulo.
begin;
create table if not exists public.warehouse_locations(
 id uuid primary key default gen_random_uuid(), code text not null unique, name text not null,
 location_type text not null check(location_type in ('RACK','RECEPCION','CONTROL','PREDESPACHO','ZONA_ABIERTA')),
 capacity int not null default 1 check(capacity > 0), active boolean not null default true,
 created_by uuid references public.profiles(id), created_at timestamptz not null default now(), updated_at timestamptz not null default now());
create table if not exists public.freezer_location_assignments(
 id uuid primary key default gen_random_uuid(), freezer_plate text not null, location_id uuid not null references public.warehouse_locations(id),
 location_code text not null, location_name text not null, active boolean not null default true, notes text,
 assigned_by uuid not null references public.profiles(id), assigned_by_name text not null,
 assigned_at timestamptz not null default now(), released_at timestamptz, released_by uuid references public.profiles(id));
create unique index if not exists freezer_one_active_location on public.freezer_location_assignments(freezer_plate) where active=true;
create index if not exists freezer_location_active_idx on public.freezer_location_assignments(location_id) where active=true;
alter table public.warehouse_locations enable row level security;
alter table public.freezer_location_assignments enable row level security;
drop policy if exists warehouse_locations_read on public.warehouse_locations;
create policy warehouse_locations_read on public.warehouse_locations for select to authenticated using(true);
drop policy if exists warehouse_locations_admin_write on public.warehouse_locations;
create policy warehouse_locations_admin_write on public.warehouse_locations for all to authenticated using(public.current_profile_role()='ADMIN') with check(public.current_profile_role()='ADMIN');
drop policy if exists freezer_locations_read on public.freezer_location_assignments;
create policy freezer_locations_read on public.freezer_location_assignments for select to authenticated using(true);
create or replace function public.assign_freezer_location_v677(p_freezer_plate text,p_location_code text,p_notes text default null)
returns public.freezer_location_assignments language plpgsql security definer set search_path=public as $$
declare v_role text; v_location public.warehouse_locations; v_count int; v_result public.freezer_location_assignments; v_name text;
begin
 v_role:=public.current_profile_role();
 if v_role in ('SUPERVISOR','TRANSPORTE') or v_role is null then raise exception 'El rol % no puede modificar ubicaciones',coalesce(v_role,'SIN PERFIL'); end if;
 if coalesce(trim(p_freezer_plate),'')='' then raise exception 'La chapa es obligatoria'; end if;
 select * into v_location from public.warehouse_locations where upper(code)=upper(trim(p_location_code)) and active=true;
 if v_location.id is null then raise exception 'Ubicacion inexistente o inactiva'; end if;
 select count(*) into v_count from public.freezer_location_assignments where location_id=v_location.id and active=true and freezer_plate<>trim(p_freezer_plate);
 if v_count>=v_location.capacity then raise exception 'La ubicacion % alcanzo su capacidad %',v_location.code,v_location.capacity; end if;
 select full_name into v_name from public.profiles where id=auth.uid();
 update public.freezer_location_assignments set active=false,released_at=now(),released_by=auth.uid() where freezer_plate=trim(p_freezer_plate) and active=true;
 insert into public.freezer_location_assignments(freezer_plate,location_id,location_code,location_name,notes,assigned_by,assigned_by_name)
 values(trim(p_freezer_plate),v_location.id,v_location.code,v_location.name,nullif(trim(p_notes),''),auth.uid(),coalesce(v_name,auth.uid()::text)) returning * into v_result;
 return v_result;
end$$;
revoke all on function public.assign_freezer_location_v677(text,text,text) from public;
grant execute on function public.assign_freezer_location_v677(text,text,text) to authenticated;
insert into public.warehouse_locations(code,name,location_type,capacity)
values ('REC-INGRESO','Recepcion de equipos recien llegados','RECEPCION',100),('REC-CONTROL','Recepcion pendiente de control','CONTROL',100),('PRE-DESPACHO','Equipos preparados para salida','PREDESPACHO',100)
on conflict(code) do nothing;
commit;

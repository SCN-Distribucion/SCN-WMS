-- SCN-WMS V6.7.6 - Asignacion por PDV, CAMBIO e incidencias
-- Ejecutar una sola vez en Supabase SQL Editor. Es idempotente y no elimina viajes existentes.
begin;

alter table public.transport_trips add column if not exists pdv text;
alter table public.transport_trips add column if not exists business_name text;
alter table public.transport_trips add column if not exists address text;
alter table public.transport_trips add column if not exists seller text;
alter table public.transport_trips add column if not exists pickup_plate text;
alter table public.transport_trips add column if not exists delivery_plate text;
alter table public.transport_trips add column if not exists operation_version int not null default 1;

alter table public.transport_trips drop constraint if exists transport_trips_trip_type_check;
alter table public.transport_trips add constraint transport_trips_trip_type_check check (trip_type in ('ENTREGA','RETIRO','CAMBIO')) not valid;
alter table public.transport_trips validate constraint transport_trips_trip_type_check;

update public.transport_trips set delivery_plate=freezer_plate where trip_type='ENTREGA' and delivery_plate is null;
update public.transport_trips set pickup_plate=freezer_plate where trip_type='RETIRO' and pickup_plate is null;

create table if not exists public.wms_incidents(
 id uuid primary key default gen_random_uuid(), incident_type text not null,
 status text not null default 'PENDIENTE' check(status in ('PENDIENTE','RESUELTA','RECHAZADA')),
 responsible_role text not null check(responsible_role in ('DEPOSITO','ADMINISTRACION')),
 pdv text, freezer_plate text, detail text not null,
 created_by uuid references public.profiles(id), created_by_name text,
 resolved_by uuid references public.profiles(id), resolution text,
 created_at timestamptz not null default now(), resolved_at timestamptz, updated_at timestamptz not null default now());
alter table public.wms_incidents enable row level security;
drop policy if exists incidents_select_roles on public.wms_incidents;
create policy incidents_select_roles on public.wms_incidents for select to authenticated using(
 public.current_profile_role() in ('ADMIN','LOGISTICA','SUPERVISOR','DEPOSITO'));
drop policy if exists incidents_insert_assigners on public.wms_incidents;
create policy incidents_insert_assigners on public.wms_incidents for insert to authenticated with check(
 created_by=auth.uid() and public.current_profile_role() in ('ADMIN','LOGISTICA'));
drop policy if exists incidents_update_responsible on public.wms_incidents;
create policy incidents_update_responsible on public.wms_incidents for update to authenticated using(
 public.current_profile_role()='ADMIN' or (responsible_role='DEPOSITO' and public.current_profile_role()='DEPOSITO'));

create or replace function public.assign_transport_trip_v676(
 p_trip_type text,p_pdv text,p_business_name text,p_address text,p_seller text,
 p_pickup_plate text,p_delivery_plate text,p_driver_id uuid)
returns public.transport_trips language plpgsql security definer set search_path=public as $$
declare v_role text; v_driver public.profiles; v_trip public.transport_trips;
begin
 v_role:=public.current_profile_role(); if v_role not in ('ADMIN','LOGISTICA') then raise exception 'Solo ADMIN o LOGISTICA pueden asignar viajes'; end if;
 if p_trip_type not in ('ENTREGA','RETIRO','CAMBIO') then raise exception 'Tipo de viaje inválido'; end if;
 if coalesce(trim(p_pdv),'')='' or coalesce(trim(p_business_name),'')='' or coalesce(trim(p_address),'')='' then raise exception 'PDV, razón social y dirección son obligatorios'; end if;
 if p_trip_type in ('RETIRO','CAMBIO') and coalesce(trim(p_pickup_plate),'')='' then raise exception 'La chapa a retirar es obligatoria'; end if;
 if p_trip_type in ('ENTREGA','CAMBIO') and coalesce(trim(p_delivery_plate),'')='' then raise exception 'La chapa a entregar es obligatoria'; end if;
 if p_trip_type='CAMBIO' and p_pickup_plate=p_delivery_plate then raise exception 'Las chapas de CAMBIO deben ser diferentes'; end if;
 select * into v_driver from public.profiles where id=p_driver_id and role::text='TRANSPORTE' and active=true;
 if v_driver.id is null or coalesce(v_driver.vehicle,'')='' or coalesce(v_driver.plate,'')='' then raise exception 'Fletero inválido o sin vehículo/patente'; end if;
 if exists(select 1 from public.transport_trips where status in ('ASIGNADO','ACEPTADO','EN CURSO') and (pickup_plate in (p_pickup_plate,p_delivery_plate) or delivery_plate in (p_pickup_plate,p_delivery_plate) or freezer_plate in (p_pickup_plate,p_delivery_plate))) then raise exception 'Una de las chapas ya tiene un viaje activo'; end if;
 insert into public.transport_trips(freezer_plate,trip_type,pdv,business_name,address,seller,pickup_plate,delivery_plate,operation_version,assigned_driver_id,driver_name,driver_email,transport_id,vehicle,vehicle_plate,status,assigned_by,assigned_by_name,notification_status)
 values(coalesce(p_delivery_plate,p_pickup_plate),p_trip_type,trim(p_pdv),p_business_name,p_address,p_seller,p_pickup_plate,p_delivery_plate,676,v_driver.id,v_driver.full_name,v_driver.email,v_driver.transport_id,v_driver.vehicle,v_driver.plate,'ASIGNADO',auth.uid(),(select full_name from public.profiles where id=auth.uid()),'PENDIENTE') returning * into v_trip;
 return v_trip;
end$$;
revoke all on function public.assign_transport_trip_v676(text,text,text,text,text,text,text,uuid) from public;
grant execute on function public.assign_transport_trip_v676(text,text,text,text,text,text,text,uuid) to authenticated;

create or replace function public.complete_transport_trip_v676(p_trip_id uuid,p_confirmation jsonb)
returns public.transport_trips language plpgsql security definer set search_path=public as $$
declare v_trip public.transport_trips;
begin
 update public.transport_trips set status='COMPLETADO',confirmation=coalesce(p_confirmation,'{}'::jsonb),completed_at=now(),updated_at=now()
 where id=p_trip_id and assigned_driver_id=auth.uid() and status='EN CURSO' returning * into v_trip;
 if v_trip.id is null then raise exception 'No se encontró un viaje EN CURSO asignado al usuario autenticado'; end if;
 return v_trip;
end$$;
revoke all on function public.complete_transport_trip_v676(uuid,jsonb) from public;
grant execute on function public.complete_transport_trip_v676(uuid,jsonb) to authenticated;

commit;

-- Verificacion opcional
select column_name,data_type from information_schema.columns where table_schema='public' and table_name='transport_trips' and column_name in ('pdv','business_name','address','seller','pickup_plate','delivery_plate','operation_version') order by column_name;

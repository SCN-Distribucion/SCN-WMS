-- SCN-WMS V6.7.8 - Identificador QR unico por freezer
-- Guarda un identificador estable por chapa para futuras migraciones de la base maestra a Supabase.
begin;
create table if not exists public.freezer_qr_registry(
 freezer_plate text primary key,
 qr_value text not null unique,
 active boolean not null default true,
 created_at timestamptz not null default now(),
 created_by uuid references public.profiles(id)
);
alter table public.freezer_qr_registry enable row level security;
drop policy if exists freezer_qr_read on public.freezer_qr_registry;
create policy freezer_qr_read on public.freezer_qr_registry for select to authenticated using(true);
drop policy if exists freezer_qr_admin_write on public.freezer_qr_registry;
create policy freezer_qr_admin_write on public.freezer_qr_registry for all to authenticated
using(public.current_profile_role()='ADMIN') with check(public.current_profile_role()='ADMIN');
create or replace function public.register_freezer_qr_v678(p_freezer_plate text)
returns public.freezer_qr_registry language plpgsql security definer set search_path=public as $$
declare r public.freezer_qr_registry;
begin
 if coalesce(trim(p_freezer_plate),'')='' then raise exception 'La chapa es obligatoria'; end if;
 insert into public.freezer_qr_registry(freezer_plate,qr_value,created_by)
 values(trim(p_freezer_plate),'SCN-WMS:FREEZER:'||trim(p_freezer_plate),auth.uid())
 on conflict(freezer_plate) do update set active=true returning * into r;
 return r;
end$$;
grant execute on function public.register_freezer_qr_v678(text) to authenticated;
commit;

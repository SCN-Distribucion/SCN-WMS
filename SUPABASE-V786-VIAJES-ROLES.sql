-- SCN-WMS V7.8.6 - REFUERZO DE VIAJES POR ROL
-- Ejecutar una vez en Supabase SQL Editor. Idempotente.
alter table public.transport_trips enable row level security;
drop policy if exists "trips_select_roles" on public.transport_trips;
create policy "trips_select_roles" on public.transport_trips for select to authenticated using (
 assigned_driver_id=auth.uid() or public.current_profile_role() in ('ADMIN','LOGISTICA','SUPERVISOR')
);
drop policy if exists "trips_insert_logistics" on public.transport_trips;
create policy "trips_insert_logistics" on public.transport_trips for insert to authenticated with check (
 public.current_profile_role() in ('ADMIN','LOGISTICA')
);
drop policy if exists "trips_update_driver" on public.transport_trips;
create policy "trips_update_driver" on public.transport_trips for update to authenticated
using (assigned_driver_id=auth.uid() or public.current_profile_role() in ('ADMIN','LOGISTICA'))
with check (assigned_driver_id=auth.uid() or public.current_profile_role() in ('ADMIN','LOGISTICA'));

-- SCN-WMS V6.7.5
-- Ejecutar una vez en Supabase SQL Editor antes de probar la finalización.

create or replace function public.complete_own_transport_trip(
  p_trip_id uuid,
  p_confirmation jsonb
)
returns public.transport_trips
language plpgsql
security definer
set search_path = public
as $$
declare
  v_trip public.transport_trips;
begin
  update public.transport_trips
     set status = 'COMPLETADO',
         confirmation = coalesce(p_confirmation, '{}'::jsonb),
         completed_at = now(),
         updated_at = now()
   where id = p_trip_id
     and assigned_driver_id = auth.uid()
     and status = 'EN CURSO'
  returning * into v_trip;

  if v_trip.id is null then
    raise exception 'No se encontró un viaje EN CURSO asignado al usuario autenticado';
  end if;
  return v_trip;
end;
$$;

revoke all on function public.complete_own_transport_trip(uuid,jsonb) from public;
grant execute on function public.complete_own_transport_trip(uuid,jsonb) to authenticated;

-- Refuerzo de la política para actualizaciones normales del viaje propio.
drop policy if exists "trips_update_driver" on public.transport_trips;
create policy "trips_update_driver"
on public.transport_trips
for update
to authenticated
using (
  assigned_driver_id = auth.uid()
  or public.current_profile_role() in ('ADMIN','LOGISTICA')
)
with check (
  assigned_driver_id = auth.uid()
  or public.current_profile_role() in ('ADMIN','LOGISTICA')
);

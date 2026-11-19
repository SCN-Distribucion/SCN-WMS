-- SCN-WMS V6.7.2 - ejecutar una sola vez
alter table public.transport_trips add column if not exists return_freezer_plate text;

-- Reemplaza el control anterior para admitir ENTREGA, RETIRO y CAMBIO.
alter table public.transport_trips drop constraint if exists transport_trips_trip_type_check;
alter table public.transport_trips add constraint transport_trips_trip_type_check
check (trip_type in ('ENTREGA','RETIRO','CAMBIO'));

-- En CAMBIO la segunda chapa es obligatoria y debe ser diferente.
alter table public.transport_trips drop constraint if exists transport_trips_change_plate_check;
alter table public.transport_trips add constraint transport_trips_change_plate_check
check (
  (trip_type <> 'CAMBIO' and return_freezer_plate is null)
  or
  (trip_type = 'CAMBIO' and return_freezer_plate is not null and return_freezer_plate <> freezer_plate)
);

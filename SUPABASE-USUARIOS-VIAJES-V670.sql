-- SCN-WMS V6.7.0 PRUEBA - ejecutar una vez
alter table public.profiles add column if not exists transport_id text;
alter table public.profiles add column if not exists vehicle text;
alter table public.profiles add column if not exists plate text;
create table if not exists public.transport_trips (
 id uuid primary key default gen_random_uuid(), freezer_plate text not null, trip_type text not null check (trip_type in ('ENTREGA','RETIRO')),
 assigned_driver_id uuid not null references public.profiles(id), driver_name text not null, driver_email text not null,
 transport_id text, vehicle text not null, vehicle_plate text not null, status text not null default 'ASIGNADO',
 assigned_by uuid references public.profiles(id), assigned_by_name text, notification_status text default 'PENDIENTE',
 confirmation jsonb not null default '{}'::jsonb, created_at timestamptz not null default now(), accepted_at timestamptz,
 started_at timestamptz, completed_at timestamptz, updated_at timestamptz not null default now());
create table if not exists public.notification_queue (
 id uuid primary key default gen_random_uuid(), event_type text not null, recipient text not null, subject text not null,
 payload jsonb not null default '{}'::jsonb, status text not null default 'PENDIENTE', attempts int not null default 0,
 created_at timestamptz not null default now(), sent_at timestamptz, error text);
alter table public.transport_trips enable row level security;alter table public.notification_queue enable row level security;
drop policy if exists "trips_select_roles" on public.transport_trips;
create policy "trips_select_roles" on public.transport_trips for select to authenticated using (assigned_driver_id=auth.uid() or exists(select 1 from public.profiles p where p.id=auth.uid() and p.role in ('ADMIN','LOGISTICA','SUPERVISOR')));
drop policy if exists "trips_insert_logistics" on public.transport_trips;
create policy "trips_insert_logistics" on public.transport_trips for insert to authenticated with check (exists(select 1 from public.profiles p where p.id=auth.uid() and p.role in ('ADMIN','LOGISTICA')));
drop policy if exists "trips_update_driver" on public.transport_trips;
create policy "trips_update_driver" on public.transport_trips for update to authenticated using (assigned_driver_id=auth.uid() or exists(select 1 from public.profiles p where p.id=auth.uid() and p.role in ('ADMIN','LOGISTICA')));
drop policy if exists "queue_insert_logistics" on public.notification_queue;
create policy "queue_insert_logistics" on public.notification_queue for insert to authenticated with check (exists(select 1 from public.profiles p where p.id=auth.uid() and p.role in ('ADMIN','LOGISTICA')));
-- Power Automate debe usar una conexión segura para leer PENDIENTE y marcar ENVIADO/ERROR.

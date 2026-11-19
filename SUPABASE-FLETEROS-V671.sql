-- SCN-WMS V6.7.1 PRUEBA
-- Corrige la visibilidad de fleteros activos para ADMIN y LOGISTICA.
-- Ejecutar una sola vez en Supabase SQL Editor.

create or replace function public.current_profile_role()
returns text
language sql
stable
security definer
set search_path = public
as $$
  select role::text from public.profiles where id = auth.uid();
$$;

revoke all on function public.current_profile_role() from public;
grant execute on function public.current_profile_role() to authenticated;

drop policy if exists "profiles_staff_read_transport" on public.profiles;
create policy "profiles_staff_read_transport"
on public.profiles
for select
to authenticated
using (
  id = auth.uid()
  or public.current_profile_role() = 'ADMIN'
  or (
    public.current_profile_role() in ('LOGISTICA','SUPERVISOR')
    and role::text = 'TRANSPORTE'
    and active = true
  )
);

-- Verificación: debe devolver los fleteros activos cuando se ejecuta desde SQL Editor.
select id, full_name, email, role, active, transport_id, vehicle, plate
from public.profiles
where role::text = 'TRANSPORTE'
order by full_name;

-- Ejecutar una sola vez en Supabase SQL Editor
insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types)
values ('technical-claim-evidence','technical-claim-evidence',false,10485760,array['image/jpeg','image/png','image/webp','image/heic','image/heif'])
on conflict (id) do update set public=false,file_size_limit=10485760;

drop policy if exists "evidence_insert_authenticated" on storage.objects;
create policy "evidence_insert_authenticated" on storage.objects for insert to authenticated
with check (bucket_id='technical-claim-evidence' and (storage.foldername(name))[1]=auth.uid()::text);

drop policy if exists "evidence_select_authenticated" on storage.objects;
create policy "evidence_select_authenticated" on storage.objects for select to authenticated
using (bucket_id='technical-claim-evidence');

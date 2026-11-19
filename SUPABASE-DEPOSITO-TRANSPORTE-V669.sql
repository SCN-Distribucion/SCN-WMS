-- SCN-WMS V6.6.9 - ejecutar una sola vez en Supabase SQL Editor
insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types) values ('freezer-evidence','freezer-evidence',false,10485760,array['image/jpeg','image/png','image/webp','image/heic','image/heif']) on conflict (id) do update set public=false,file_size_limit=10485760;
drop policy if exists "freezer_evidence_insert" on storage.objects;
create policy "freezer_evidence_insert" on storage.objects for insert to authenticated with check (bucket_id='freezer-evidence' and (storage.foldername(name))[1]=auth.uid()::text);
drop policy if exists "freezer_evidence_select" on storage.objects;
create policy "freezer_evidence_select" on storage.objects for select to authenticated using (bucket_id='freezer-evidence');

-- ============================================================
-- Prompt Library — Supabase setup script
-- Run this once in Supabase SQL Editor, after changing the password.
-- ============================================================

-- 1. Prompts table
create table if not exists prompts (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  content text not null,
  thumbnail text,
  emoji text default '✦',
  llms jsonb default '[]'::jsonb,
  submitter text,
  created_at timestamptz default now()
);

-- 2. Allow public read & insert, no public update/delete
alter table prompts enable row level security;

drop policy if exists "public_read"   on prompts;
drop policy if exists "public_insert" on prompts;
create policy "public_read"   on prompts for select using (true);
create policy "public_insert" on prompts for insert with check (true);

-- 3. Owner-only delete & update via password-protected functions.
--    !! CHANGE THIS PASSWORD before running !!
--    Use a long random string. The same password goes in the owner login dialog.

create or replace function delete_prompt(prompt_id uuid, admin_password text)
returns void language plpgsql security definer as $$
begin
  if admin_password = 'CHANGE_THIS_TO_A_LONG_RANDOM_STRING' then
    delete from prompts where id = prompt_id;
  else
    raise exception 'invalid password';
  end if;
end; $$;

create or replace function update_prompt(
  prompt_id uuid, admin_password text,
  new_title text, new_content text, new_thumbnail text,
  new_emoji text, new_llms jsonb
) returns void language plpgsql security definer as $$
begin
  if admin_password = 'CHANGE_THIS_TO_A_LONG_RANDOM_STRING' then
    update prompts set
      title = new_title, content = new_content, thumbnail = new_thumbnail,
      emoji = new_emoji, llms = new_llms
    where id = prompt_id;
  else
    raise exception 'invalid password';
  end if;
end; $$;

grant execute on function delete_prompt(uuid, text) to anon, authenticated;
grant execute on function update_prompt(uuid, text, text, text, text, text, jsonb) to anon, authenticated;

-- 4. Storage bucket for uploaded thumbnails
insert into storage.buckets (id, name, public)
values ('thumbnails', 'thumbnails', true)
on conflict (id) do nothing;

drop policy if exists "thumb_read"   on storage.objects;
drop policy if exists "thumb_insert" on storage.objects;
create policy "thumb_read"   on storage.objects for select using (bucket_id = 'thumbnails');
create policy "thumb_insert" on storage.objects for insert with check (bucket_id = 'thumbnails');

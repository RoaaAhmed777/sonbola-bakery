-- Contact form messages for the landing page.
-- Run once in the Supabase SQL Editor.

create table if not exists public.messages (
  id bigint generated always as identity primary key,
  name text not null check (char_length(name) between 1 and 100),
  phone text not null check (char_length(phone) between 8 and 20),
  message text not null check (char_length(message) between 1 and 2000),
  created_at timestamptz not null default now()
);

-- Visitors may add rows and nothing else.
alter table public.messages enable row level security;

revoke all on table public.messages from anon, authenticated;
grant insert (name, phone, message) on table public.messages to anon, authenticated;

drop policy if exists "Visitors can send messages" on public.messages;
create policy "Visitors can send messages"
  on public.messages
  for insert
  to anon, authenticated
  with check (true);

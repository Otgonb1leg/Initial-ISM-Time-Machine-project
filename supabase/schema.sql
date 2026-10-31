-- ISM Time Machine database schema
-- Run in Supabase SQL Editor. Public profile data is readable by everyone;
-- only authenticated users with an admin role can modify content.

create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  role text not null default 'viewer' check (role in ('viewer','admin')),
  created_at timestamptz not null default now()
);

create table if not exists public.teachers (
  id uuid primary key default gen_random_uuid(),
  full_name text not null,
  position text,
  degree text,
  department text default 'Мэдээллийн Системийн Менежментийн тэнхим',
  bio text,
  photo_url text,
  email text,
  courses text[] not null default '{}',
  research text[] not null default '{}',
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.education (
  id uuid primary key default gen_random_uuid(),
  teacher_id uuid not null references public.teachers(id) on delete cascade,
  institution text not null,
  qualification text,
  field_of_study text,
  start_year integer,
  end_year integer,
  sort_order integer not null default 0
);

create table if not exists public.experience (
  id uuid primary key default gen_random_uuid(),
  teacher_id uuid not null references public.teachers(id) on delete cascade,
  organization text not null,
  position text,
  description text,
  start_date date,
  end_date date,
  is_current boolean not null default false,
  sort_order integer not null default 0
);

create table if not exists public.publications (
  id uuid primary key default gen_random_uuid(),
  teacher_id uuid not null references public.teachers(id) on delete cascade,
  title text not null,
  publication_type text,
  publisher text,
  publication_year integer,
  url text,
  description text
);

create table if not exists public.timeline_events (
  id uuid primary key default gen_random_uuid(),
  event_year integer not null,
  title text not null,
  description text,
  image_url text,
  category text,
  created_at timestamptz not null default now()
);

create or replace function public.is_admin()
returns boolean language sql stable security definer set search_path = public
as $$ select exists (select 1 from public.profiles where id = auth.uid() and role = 'admin'); $$;

alter table public.profiles enable row level security;
alter table public.teachers enable row level security;
alter table public.education enable row level security;
alter table public.experience enable row level security;
alter table public.publications enable row level security;
alter table public.timeline_events enable row level security;

-- Profiles: users can read their own profile; admins can read all and manage roles.
drop policy if exists "profiles read own or admin" on public.profiles;
create policy "profiles read own or admin" on public.profiles for select to authenticated using (id = auth.uid() or public.is_admin());
drop policy if exists "profiles admin manage" on public.profiles;
create policy "profiles admin manage" on public.profiles for all to authenticated using (public.is_admin()) with check (public.is_admin());

-- Public read access for archive content.
drop policy if exists "teachers public read" on public.teachers;
create policy "teachers public read" on public.teachers for select to anon, authenticated using (true);
drop policy if exists "teachers admin write" on public.teachers;
create policy "teachers admin write" on public.teachers for all to authenticated using (public.is_admin()) with check (public.is_admin());

drop policy if exists "education public read" on public.education;
create policy "education public read" on public.education for select to anon, authenticated using (true);
drop policy if exists "education admin write" on public.education;
create policy "education admin write" on public.education for all to authenticated using (public.is_admin()) with check (public.is_admin());

drop policy if exists "experience public read" on public.experience;
create policy "experience public read" on public.experience for select to anon, authenticated using (true);
drop policy if exists "experience admin write" on public.experience;
create policy "experience admin write" on public.experience for all to authenticated using (public.is_admin()) with check (public.is_admin());

drop policy if exists "publications public read" on public.publications;
create policy "publications public read" on public.publications for select to anon, authenticated using (true);
drop policy if exists "publications admin write" on public.publications;
create policy "publications admin write" on public.publications for all to authenticated using (public.is_admin()) with check (public.is_admin());

drop policy if exists "timeline public read" on public.timeline_events;
create policy "timeline public read" on public.timeline_events for select to anon, authenticated using (true);
drop policy if exists "timeline admin write" on public.timeline_events;
create policy "timeline admin write" on public.timeline_events for all to authenticated using (public.is_admin()) with check (public.is_admin());

-- Create a storage bucket for faculty portraits. Keep images public, writes admin-only.
insert into storage.buckets (id, name, public) values ('faculty-portraits','faculty-portraits',true)
on conflict (id) do nothing;
drop policy if exists "faculty portraits public read" on storage.objects;
create policy "faculty portraits public read" on storage.objects for select to anon, authenticated using (bucket_id = 'faculty-portraits');
drop policy if exists "faculty portraits admin upload" on storage.objects;
create policy "faculty portraits admin upload" on storage.objects for insert to authenticated with check (bucket_id = 'faculty-portraits' and public.is_admin());
drop policy if exists "faculty portraits admin update" on storage.objects;
create policy "faculty portraits admin update" on storage.objects for update to authenticated using (bucket_id = 'faculty-portraits' and public.is_admin()) with check (bucket_id = 'faculty-portraits' and public.is_admin());
drop policy if exists "faculty portraits admin delete" on storage.objects;
create policy "faculty portraits admin delete" on storage.objects for delete to authenticated using (bucket_id = 'faculty-portraits' and public.is_admin());

-- After creating your own user in Supabase Authentication, grant admin role:
-- insert into public.profiles (id, display_name, role)
-- select id, 'ISM Administrator', 'admin' from auth.users where email = 'YOUR_ADMIN_EMAIL'
-- on conflict (id) do update set role = 'admin';

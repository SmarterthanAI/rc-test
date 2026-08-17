-- ========================================================
-- RC-99 Test Platform - Supabase Postgres Database Schema
-- Run this in your Supabase Project -> SQL Editor
-- ========================================================

-- 1. Profiles Table (stores user display name and role)
create table if not exists public.profiles (
  id uuid references auth.users on delete cascade primary key,
  name text,
  email text,
  role text default 'student',
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 2. In-Progress Test Saves (auto-save during test)
create table if not exists public.user_progress (
  id text primary key, -- Composite key: userId_testId
  user_id uuid references auth.users on delete cascade not null,
  test_id text not null,
  current_index integer default 0,
  mode text default 'timed',
  time_elapsed integer default 0,
  time_remaining integer default 480,
  user_answers jsonb default '{}'::jsonb,
  marked_for_review jsonb default '{}'::jsonb,
  last_updated timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 3. Completed Test Attempts / Scorecards
create table if not exists public.test_attempts (
  id text primary key,
  user_id uuid references auth.users on delete cascade not null,
  user_name text,
  test_id text not null,
  test_title text,
  test_code text,
  mode text default 'timed',
  total_questions integer default 0,
  attempted_count integer default 0,
  correct_count integer default 0,
  incorrect_count integer default 0,
  unattempted_count integer default 0,
  score integer default 0,
  score_percent numeric default 0,
  accuracy_percent numeric default 0,
  time_elapsed_seconds integer default 0,
  submitted_at timestamp with time zone default timezone('utc'::text, now()) not null,
  answers jsonb default '{}'::jsonb
);

-- ========================================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- Ensures users can only access their own private data
-- ========================================================

alter table public.profiles enable row level security;
alter table public.user_progress enable row level security;
alter table public.test_attempts enable row level security;

-- Profiles Policies
create policy "Users can view own profile" on public.profiles
  for select using (auth.uid() = id);

create policy "Users can insert own profile" on public.profiles
  for insert with check (auth.uid() = id);

create policy "Users can update own profile" on public.profiles
  for update using (auth.uid() = id);

-- User Progress Policies
create policy "Users can view own progress" on public.user_progress
  for select using (auth.uid() = user_id);

create policy "Users can insert own progress" on public.user_progress
  for insert with check (auth.uid() = user_id);

create policy "Users can update own progress" on public.user_progress
  for update using (auth.uid() = user_id);

create policy "Users can delete own progress" on public.user_progress
  for delete using (auth.uid() = user_id);

-- Test Attempts Policies
create policy "Users can view own attempts" on public.test_attempts
  for select using (auth.uid() = user_id);

create policy "Users can insert own attempts" on public.test_attempts
  for insert with check (auth.uid() = user_id);

-- ========================================================
-- AUTOMATIC PROFILE CREATION TRIGGER
-- Auto-creates a profile row whenever a user signs up
-- ========================================================

create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, name, email, role)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'name', split_part(new.email, '@', 1)),
    new.email,
    'student'
  )
  on conflict (id) do nothing;
  return new;
end;
$$ language plpgsql security definer;

-- Trigger definition
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

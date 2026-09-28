-- Supabase schema base del proyecto María Hortencia 80 años
create extension if not exists pgcrypto;
create table if not exists events(id uuid primary key default gen_random_uuid(),name text not null,event_date date not null,event_time text not null,location text,address text,maps_url text,confirmation_deadline timestamptz,created_at timestamptz default now());
create table if not exists guests(id uuid primary key default gen_random_uuid(),event_id uuid references events(id) on delete cascade not null,invitation_code text unique not null,first_name text not null,last_name text not null,phone text,max_companions integer not null default 0 check(max_companions between 0 and 20),status text not null default 'ACTIVE');
create table if not exists confirmations(id uuid primary key default gen_random_uuid(),guest_id uuid unique references guests(id) on delete cascade not null,attendance_status text not null default 'PENDING',confirmed_at timestamptz,updated_at timestamptz default now());
create table if not exists companions(id uuid primary key default gen_random_uuid(),guest_id uuid references guests(id) on delete cascade not null,first_name text not null,last_name text not null,relationship text not null,age integer);
create table if not exists invitation_visits(id uuid primary key default gen_random_uuid(),guest_id uuid references guests(id) on delete cascade not null,opened_at timestamptz default now(),last_opened_at timestamptz default now(),open_count integer default 1,user_agent text,device_type text);
alter table events enable row level security;
alter table guests enable row level security;
alter table confirmations enable row level security;
alter table companions enable row level security;
alter table invitation_visits enable row level security;
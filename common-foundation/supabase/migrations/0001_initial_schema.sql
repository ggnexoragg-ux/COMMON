-- COMMON initial schema.
-- Review and apply only to a new, intended Supabase project.
-- This migration intentionally does not create auth users or configure OAuth providers.

create extension if not exists pgcrypto;

create type public.community_role as enum ('member', 'moderator', 'owner');
create type public.report_status as enum ('open', 'reviewing', 'resolved', 'dismissed');
create type public.report_target_type as enum ('post', 'comment', 'profile');

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text not null unique,
  display_name text not null default '',
  bio text not null default '',
  avatar_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint profiles_username_format check (username ~ '^[a-z0-9_]{3,24}$'),
  constraint profiles_display_name_length check (char_length(display_name) <= 60),
  constraint profiles_bio_length check (char_length(bio) <= 240)
);

create table public.communities (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text not null unique,
  description text not null default '',
  created_by uuid not null references public.profiles(id) on delete restrict,
  is_public boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint communities_name_length check (char_length(name) between 2 and 60),
  constraint communities_slug_format check (slug ~ '^[a-z0-9-]{3,40}$'),
  constraint communities_description_length check (char_length(description) <= 500)
);

create table public.community_members (
  community_id uuid not null references public.communities(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  role public.community_role not null default 'member',
  joined_at timestamptz not null default now(),
  primary key (community_id, user_id)
);

create table public.posts (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles(id) on delete restrict,
  community_id uuid references public.communities(id) on delete set null,
  body text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz,
  constraint posts_body_length check (char_length(body) between 1 and 5000)
);

create table public.comments (
  id uuid primary key default gen_random_uuid(),
  post_id uuid not null references public.posts(id) on delete cascade,
  author_id uuid not null references public.profiles(id) on delete restrict,
  body text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz,
  constraint comments_body_length check (char_length(body) between 1 and 3000)
);

create table public.reactions (
  id uuid primary key default gen_random_uuid(),
  post_id uuid not null references public.posts(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  kind text not null default 'like' check (kind in ('like')),
  created_at timestamptz not null default now(),
  unique (post_id, user_id)
);

create table public.follows (
  follower_id uuid not null references public.profiles(id) on delete cascade,
  followed_id uuid not null references public.profiles(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (follower_id, followed_id),
  constraint follows_no_self check (follower_id <> followed_id)
);

create table public.user_blocks (
  blocker_id uuid not null references public.profiles(id) on delete cascade,
  blocked_id uuid not null references public.profiles(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (blocker_id, blocked_id),
  constraint blocks_no_self check (blocker_id <> blocked_id)
);

create table public.reports (
  id uuid primary key default gen_random_uuid(),
  reporter_id uuid not null references public.profiles(id) on delete restrict,
  target_type public.report_target_type not null,
  post_id uuid references public.posts(id) on delete set null,
  comment_id uuid references public.comments(id) on delete set null,
  target_profile_id uuid references public.profiles(id) on delete set null,
  reason text not null,
  details text not null default '',
  status public.report_status not null default 'open',
  reviewed_by uuid references public.profiles(id) on delete set null,
  reviewed_at timestamptz,
  created_at timestamptz not null default now(),
  constraint reports_reason_length check (char_length(reason) between 2 and 100),
  constraint reports_details_length check (char_length(details) <= 2000),
  constraint reports_exactly_one_target check (
    (case when post_id is not null then 1 else 0 end) +
    (case when comment_id is not null then 1 else 0 end) +
    (case when target_profile_id is not null then 1 else 0 end) = 1
  )
);

create table public.moderation_actions (
  id uuid primary key default gen_random_uuid(),
  moderator_id uuid not null references public.profiles(id) on delete restrict,
  target_profile_id uuid references public.profiles(id) on delete set null,
  post_id uuid references public.posts(id) on delete set null,
  comment_id uuid references public.comments(id) on delete set null,
  action text not null check (action in ('content_removed', 'warning', 'suspension', 'unsuspension', 'report_dismissed')),
  reason text not null,
  created_at timestamptz not null default now(),
  constraint moderation_reason_length check (char_length(reason) between 2 and 2000)
);

create index posts_created_at_idx on public.posts (created_at desc) where deleted_at is null;
create index posts_author_created_idx on public.posts (author_id, created_at desc) where deleted_at is null;
create index posts_community_created_idx on public.posts (community_id, created_at desc) where deleted_at is null;
create index comments_post_created_idx on public.comments (post_id, created_at asc) where deleted_at is null;
create index reactions_post_idx on public.reactions (post_id);
create index follows_followed_idx on public.follows (followed_id);
create index reports_status_created_idx on public.reports (status, created_at asc);
create index community_members_user_idx on public.community_members (user_id, joined_at desc);

-- Enable RLS everywhere in the exposed public schema.
alter table public.profiles enable row level security;
alter table public.communities enable row level security;
alter table public.community_members enable row level security;
alter table public.posts enable row level security;
alter table public.comments enable row level security;
alter table public.reactions enable row level security;
alter table public.follows enable row level security;
alter table public.user_blocks enable row level security;
alter table public.reports enable row level security;
alter table public.moderation_actions enable row level security;

-- Profiles are publicly readable; only the owner can modify their own row.
create policy "Profiles are publicly readable"
on public.profiles for select to anon, authenticated
using (true);

create policy "Users can create their own profile"
on public.profiles for insert to authenticated
with check ((select auth.uid()) = id);

create policy "Users can update their own profile"
on public.profiles for update to authenticated
using ((select auth.uid()) = id)
with check ((select auth.uid()) = id);

-- Public communities can be listed. Community creation is initially restricted
-- to an authenticated owner through application-side moderation workflow; no
-- client insert policy is granted in this foundation migration.
create policy "Public communities are readable"
on public.communities for select to anon, authenticated
using (is_public = true);

create policy "Community memberships are visible to members"
on public.community_members for select to authenticated
using (
  user_id = (select auth.uid())
  or exists (
    select 1 from public.communities c
    where c.id = community_id and c.is_public = true
  )
);

create policy "Users can join public communities"
on public.community_members for insert to authenticated
with check (
  user_id = (select auth.uid())
  and exists (
    select 1 from public.communities c
    where c.id = community_id and c.is_public = true
  )
  and role = 'member'
);

create policy "Users can leave communities"
on public.community_members for delete to authenticated
using (user_id = (select auth.uid()) and role = 'member');

create policy "Visible posts are readable"
on public.posts for select to anon, authenticated
using (
  deleted_at is null
  and (community_id is null or exists (
    select 1 from public.communities c
    where c.id = community_id and c.is_public = true
  ))
);

create policy "Authenticated users can create posts as themselves"
on public.posts for insert to authenticated
with check ((select auth.uid()) = author_id);

create policy "Authors can update their own posts"
on public.posts for update to authenticated
using ((select auth.uid()) = author_id)
with check ((select auth.uid()) = author_id);

create policy "Authors can soft-delete their own posts"
on public.posts for update to authenticated
using ((select auth.uid()) = author_id)
with check ((select auth.uid()) = author_id);

create policy "Visible comments are readable"
on public.comments for select to anon, authenticated
using (
  deleted_at is null and exists (
    select 1 from public.posts p
    where p.id = post_id and p.deleted_at is null
  )
);

create policy "Authenticated users can comment as themselves"
on public.comments for insert to authenticated
with check ((select auth.uid()) = author_id);

create policy "Authors can update their own comments"
on public.comments for update to authenticated
using ((select auth.uid()) = author_id)
with check ((select auth.uid()) = author_id);

create policy "Reactions are readable"
on public.reactions for select to anon, authenticated
using (true);

create policy "Users can react as themselves"
on public.reactions for insert to authenticated
with check ((select auth.uid()) = user_id);

create policy "Users can remove their own reactions"
on public.reactions for delete to authenticated
using ((select auth.uid()) = user_id);

create policy "Follow relationships are readable"
on public.follows for select to authenticated
using (follower_id = (select auth.uid()) or followed_id = (select auth.uid()));

create policy "Users can follow as themselves"
on public.follows for insert to authenticated
with check (follower_id = (select auth.uid()) and follower_id <> followed_id);

create policy "Users can unfollow as themselves"
on public.follows for delete to authenticated
using (follower_id = (select auth.uid()));

create policy "Users can see blocks they created"
on public.user_blocks for select to authenticated
using (blocker_id = (select auth.uid()));

create policy "Users can block others"
on public.user_blocks for insert to authenticated
with check (blocker_id = (select auth.uid()) and blocker_id <> blocked_id);

create policy "Users can unblock others"
on public.user_blocks for delete to authenticated
using (blocker_id = (select auth.uid()));

-- Reports and moderation records are intentionally not readable or writable
-- through direct client table access. Submit/review through validated server
-- actions or narrowly scoped, audited RPCs added in a later security phase.

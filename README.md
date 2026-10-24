# COMMON

**Find your people.** A thoughtful, general-interest social platform built with Next.js, TypeScript and Supabase.

## Setup
1. Use Node.js 20.9+ and run `npm install`.
2. Copy `.env.example` to `.env.local` and set `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` for a dedicated COMMON Supabase project.
3. Apply `supabase/migrations/0001_common.sql` to that project.
4. In Supabase Auth, enable email and Discord. Set `/auth/callback` as an allowed redirect URL and configure the Discord OAuth credentials in Supabase (never in client env vars).
5. Set the same public Supabase variables in Vercel Preview and Production.
6. Run `npm run dev`; verify `npm run typecheck`, `npm run lint`, and `npm run build`.

Do not reuse the MUSE or PALERMO databases. Never expose a service-role key in browser code.

## Current scope
Responsive social feed, search, Explore/Communities navigation, email signup/signin, Discord OAuth callback, and database-backed post/like/join flows when Supabase is configured. Without environment variables the app shows demo content and clearly reports that auth is not configured. Account moderation, full block enforcement, image uploads and account deletion remain follow-up hardening tasks.

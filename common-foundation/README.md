# COMMON

A minimalist, general-interest social platform. This repository is the foundation scaffold only; it has not been deployed and is not connected to any existing project.

## Stack
- Next.js App Router + TypeScript
- Tailwind CSS
- Supabase Auth/Postgres (Discord OAuth planned)
- Vitest + Playwright planned

## Local setup
1. Install Node.js LTS and npm.
2. Run `npm install`.
3. Copy `.env.example` to `.env.local` and fill in Supabase project values.
4. Run `npm run dev`.

The app currently provides the visual foundation and placeholder routes. Authentication and database integration are not yet implemented.

## Supabase
Apply `supabase/migrations/0001_initial_schema.sql` to a **new, intended Supabase project** after reviewing it. Do not run it against an existing database without explicit approval and a backup.

## Discord OAuth
Configure Discord as a Supabase Auth provider only after creating an OAuth application in Discord Developer Portal. Never commit the Discord client secret or Supabase secret/service-role keys. Add only the public Supabase URL and publishable/anon key to client-visible environment variables.

## Deployment
No deployment is configured or performed by this scaffold. Before linking to Vercel, confirm the intended GitHub repository, Vercel project, and environment variables.

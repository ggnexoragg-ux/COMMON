# COMMON foundation checklist

## Phase 0 — Repository and environment
- [ ] Create a new repository named `common` only after owner confirms destination.
- [ ] Commit the scaffold and lockfile.
- [ ] Create a new Supabase project only after explicit approval.
- [ ] Configure environment variables locally; do not commit `.env.local`.
- [ ] Confirm the Vercel project and deployment target before linking anything.

## Phase 1 — Design foundation
- [ ] Validate landing page layout at mobile, tablet, desktop widths.
- [ ] Add accessible focus states, skip link, and reduced-motion behavior.
- [ ] Define typography and spacing scale.
- [ ] Review contrast and keyboard navigation.

## Phase 2 — Auth
- [ ] Implement Supabase SSR client/server helpers.
- [ ] Configure email verification and password reset.
- [ ] Configure Discord OAuth identify scope; request email only if required.
- [ ] Implement callback state validation and safe redirect allowlist.
- [ ] Link identities safely; never trust client-supplied Discord user IDs.
- [ ] Create profiles from trusted auth identity data.
- [ ] Add session refresh middleware/proxy following current Supabase SSR docs.

## Phase 3 — Database/security
- [ ] Review SQL with a fresh test database before production use.
- [ ] Test every RLS policy as anon, user A, user B, and moderator.
- [ ] Add database-backed role assignment in a protected table/claim strategy.
- [ ] Implement server-validated reports and moderation actions.
- [ ] Add rate limits and anti-spam protections.
- [ ] Test blocking behavior across feeds, profiles, and comments.
- [ ] Define deletion and retention behavior.

## Phase 4 — Product
- [ ] Build paginated feeds and post creation/edit/delete.
- [ ] Build comments and reactions.
- [ ] Build community discovery and memberships.
- [ ] Add empty, loading, error, and retry states.
- [ ] Add search with safe query handling.

## Phase 5 — Verification
- [ ] `npm run typecheck`
- [ ] `npm run lint`
- [ ] `npm run build`
- [ ] Add unit tests for validation and permissions.
- [ ] Add Playwright smoke tests for auth and core flows.
- [ ] Test on a real mobile browser.
- [ ] Review dependency advisories and secret scanning.

## Phase 6 — Release readiness (not authorized yet)
- [ ] Confirm exact GitHub repository and branch.
- [ ] Confirm exact Vercel project and environment.
- [ ] Configure preview environment separately from production.
- [ ] Verify database backups and rollback plan.
- [ ] Obtain explicit owner approval before any deployment.

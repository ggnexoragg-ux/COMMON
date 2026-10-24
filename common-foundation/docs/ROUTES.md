# Route map

| Route | Access | Purpose |
|---|---|---|
| `/` | Public | Landing page |
| `/login` | Public | Login entry point |
| `/signup` | Public | Registration entry point |
| `/auth/callback` | OAuth callback | Exchanges trusted auth code; implementation pending |
| `/home` | Signed in (planned) | Home feed |
| `/explore` | Public/signed in | Discover content |
| `/communities` | Public/signed in | Community index |
| `/c/[slug]` | Public/signed in | Community detail |
| `/post/[id]` | Public/signed in | Post and comments |
| `/u/[username]` | Public | Public profile |
| `/settings` | Signed in | Account settings |
| `/api/health` | Public | Non-sensitive service health |
| `/moderation` | Moderator only (planned) | Report queue and moderation actions |

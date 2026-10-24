import { NextResponse } from "next/server";

// OAuth callback will be implemented with Supabase SSR in the authentication phase.
export async function GET(request: Request) {
  const url = new URL(request.url);
  return NextResponse.redirect(new URL("/login?error=auth_not_configured", url.origin));
}

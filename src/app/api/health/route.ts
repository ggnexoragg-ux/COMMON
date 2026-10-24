import { NextResponse } from "next/server";
export async function GET(){ return NextResponse.json({status:"ok",app:"COMMON",authConfigured:Boolean(process.env.NEXT_PUBLIC_SUPABASE_URL && process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY)}); }

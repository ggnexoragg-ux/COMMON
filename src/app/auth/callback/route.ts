import { createServerClient } from "@supabase/ssr";
import { NextRequest, NextResponse } from "next/server";
export async function GET(request:NextRequest){
 const {searchParams,origin}=new URL(request.url); const code=searchParams.get("code"); const next=searchParams.get("next"); const destination=next && next.startsWith("/") && !next.startsWith("//") ? next : "/";
 const url=process.env.NEXT_PUBLIC_SUPABASE_URL; const key=process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY;
 if(!url || !key || !code) return NextResponse.redirect(new URL("/?auth=not-configured",origin));
 const response=NextResponse.redirect(new URL(destination,origin));
 const supabase=createServerClient(url,key,{cookies:{getAll:()=>request.cookies.getAll(),setAll:(items)=>items.forEach(({name,value,options})=>{request.cookies.set(name,value);response.cookies.set(name,value,options);})}});
 const {error}=await supabase.auth.exchangeCodeForSession(code);
 if(error) return NextResponse.redirect(new URL("/?auth=error",origin));
 return response;
}

import Link from "next/link";
import { SiteHeader } from "@/components/site-header";
import { SiteFooter } from "@/components/site-footer";

export default function SocialLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return (
    <div className="shell">
      <SiteHeader />
      <main className="page-main">{children}</main>
      <SiteFooter />
      <div className="sr-only"><Link href="/settings">Settings</Link></div>
    </div>
  );
}

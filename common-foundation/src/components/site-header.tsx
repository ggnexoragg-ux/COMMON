import Link from "next/link";
import { Brand } from "@/components/brand";

export function SiteHeader() {
  return (
    <header className="site-header">
      <Brand />
      <nav className="nav-links" aria-label="Main navigation">
        <Link href="/explore">Explore</Link>
        <Link href="/communities">Communities</Link>
        <Link href="/login">Log in</Link>
        <Link className="button button-primary" href="/signup">Join COMMON</Link>
      </nav>
    </header>
  );
}

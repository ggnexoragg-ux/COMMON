import Link from "next/link";

export default function NotFound() {
  return (
    <main className="shell page-main">
      <p className="eyebrow">404 · Not found</p>
      <h1 className="page-title" style={{ marginTop: 18 }}>This corner doesn't exist yet.</h1>
      <p className="page-subtitle">Let's get you back to COMMON.</p>
      <Link className="button button-primary" href="/">Back home</Link>
    </main>
  );
}

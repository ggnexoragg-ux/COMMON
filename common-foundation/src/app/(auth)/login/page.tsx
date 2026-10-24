import Link from "next/link";

export default function LoginPage() {
  return (
    <main className="shell page-main">
      <Link className="brand" href="/"><span className="brand-mark">c.</span><span>COMMON</span></Link>
      <section style={{ maxWidth: 440, margin: "64px auto" }}>
        <h1 className="page-title">Welcome back.</h1>
        <p className="page-subtitle">Sign in to return to your communities.</p>
        <div className="placeholder">
          Authentication is not connected yet. Discord and email sign-in will be added in the auth phase.
        </div>
        <p className="page-subtitle">New here? <Link href="/signup" style={{ color: "var(--accent)" }}>Create an account</Link></p>
      </section>
    </main>
  );
}

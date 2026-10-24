import Link from "next/link";

export default function SignupPage() {
  return (
    <main className="shell page-main">
      <Link className="brand" href="/"><span className="brand-mark">c.</span><span>COMMON</span></Link>
      <section style={{ maxWidth: 440, margin: "64px auto" }}>
        <h1 className="page-title">Find your people.</h1>
        <p className="page-subtitle">Make a space for the things you care about.</p>
        <div className="placeholder">
          Account creation is not connected yet. Email and Discord OAuth will be added after the foundation is reviewed.
        </div>
        <p className="page-subtitle">Already a member? <Link href="/login" style={{ color: "var(--accent)" }}>Log in</Link></p>
      </section>
    </main>
  );
}

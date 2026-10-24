"use client";

export default function ErrorPage({ reset }: { error: Error & { digest?: string }; reset: () => void }) {
  return (
    <main className="shell page-main">
      <h1 className="page-title">Something went wrong.</h1>
      <p className="page-subtitle">Please try again. Your account information has not been displayed here.</p>
      <button className="button button-primary" onClick={() => reset()}>Try again</button>
    </main>
  );
}

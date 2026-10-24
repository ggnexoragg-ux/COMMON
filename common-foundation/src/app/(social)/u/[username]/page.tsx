export default async function ProfilePage({ params }: { params: Promise<{ username: string }> }) {
  const { username } = await params;
  return (
    <>
      <h1 className="page-title">@{username}</h1>
      <p className="page-subtitle">A COMMON member.</p>
      <div className="placeholder">Profile details and public posts will appear here after account integration.</div>
    </>
  );
}

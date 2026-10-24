export default async function CommunityPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  return (
    <>
      <h1 className="page-title">Community</h1>
      <p className="page-subtitle">/{slug}</p>
      <div className="placeholder">This community page is a placeholder until community data is connected.</div>
    </>
  );
}

export default async function PostPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  return (
    <>
      <h1 className="page-title">Conversation</h1>
      <p className="page-subtitle">Post reference: {id}</p>
      <div className="placeholder">The post and its comments will appear here once the social API is implemented.</div>
    </>
  );
}

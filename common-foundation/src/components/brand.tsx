import Link from "next/link";

export function Brand() {
  return (
    <Link className="brand" href="/" aria-label="COMMON home">
      <span className="brand-mark" aria-hidden="true">c.</span>
      <span>COMMON</span>
    </Link>
  );
}

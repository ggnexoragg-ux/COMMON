import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "COMMON — Find your people",
  description: "A calmer place to share ideas and find your people.",
};

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}

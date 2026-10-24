import Link from "next/link";
import { ArrowUpRight, Compass, MessageCircle, Users } from "lucide-react";
import { SiteHeader } from "@/components/site-header";
import { SiteFooter } from "@/components/site-footer";

const features = [
  {
    icon: MessageCircle,
    title: "Conversations over noise",
    description: "Share a thought, ask a question, or join a discussion without an overwhelming feed.",
  },
  {
    icon: Users,
    title: "Find your people",
    description: "Discover communities built around the things you care about, big or small.",
  },
  {
    icon: Compass,
    title: "Room to discover",
    description: "Explore new perspectives and ideas at your own pace.",
  },
];

export default function LandingPage() {
  return (
    <>
      <div className="shell">
        <SiteHeader />
        <main>
          <section className="hero">
            <span className="eyebrow">A new place to belong</span>
            <h1>The internet feels better when we find <span>our people.</span></h1>
            <p>
              COMMON is a calmer space to share what you think, discover new
              interests, and join conversations that matter to you.
            </p>
            <div className="hero-actions">
              <Link className="button button-primary" href="/signup">
                Find your people <ArrowUpRight size={16} />
              </Link>
              <Link className="button button-secondary" href="/explore">
                Explore COMMON
              </Link>
            </div>
          </section>
          <section className="section" aria-labelledby="why-common">
            <div className="section-heading">
              <div>
                <h2 id="why-common">A little less noise. A little more connection.</h2>
                <p>Made for people, not endless scrolling.</p>
              </div>
            </div>
            <div className="feature-grid">
              {features.map(({ icon: Icon, title, description }) => (
                <article className="feature-card" key={title}>
                  <div className="feature-icon"><Icon size={19} /></div>
                  <h3>{title}</h3>
                  <p>{description}</p>
                </article>
              ))}
            </div>
          </section>
        </main>
        <SiteFooter />
      </div>
    </>
  );
}

import Button from '../components/common/Button';
import Badge from '../components/common/Badge';
import SectionHeader from '../components/common/SectionHeader';
import { Link } from 'react-router-dom';

const LandingPage = () => {
  return (
    <main>
      <section className="page" style={{ paddingTop: 56, display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(320px, 1fr))', gap: 32, alignItems: 'center' }}>
        <div>
          <div className="pill">Speakeasy Special</div>
          <h1 className="headline" style={{ fontSize: 52, lineHeight: 1.05, margin: '14px 0 12px' }}>
            The Family’s Slice
            <br />
            Since 1928
          </h1>
          <p style={{ color: 'var(--text-secondary)', maxWidth: 520, fontSize: 16 }}>
            Mob Pizza serves cinematic pies, sides, and liquid alibis. Step into the speakeasy, keep it hush, and order like family.
          </p>
          <div style={{ display: 'flex', gap: 12, marginTop: 18, flexWrap: 'wrap' }}>
            <Link to="/menu">
              <Button>Join the Family (Order Now)</Button>
            </Link>
            <Link to="/menu">
              <Button variant="ghost">Browse the Hit List</Button>
            </Link>
          </div>
          <div style={{ display: 'flex', gap: 16, marginTop: 18, color: 'var(--text-secondary)', fontSize: 14, flexWrap: 'wrap' }}>
            <span>🔥 Boss Picks</span>
            <span>🕶️ Undercover Deals</span>
            <span>🗺️ Safehouse Pickup</span>
          </div>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(140px, 1fr))', gap: 12, marginTop: 22 }}>
            {[
              { label: 'Delivery', desc: 'Family Delivery' },
              { label: 'Pickup', desc: 'Safehouse Pickup' },
              { label: 'Tracking', desc: 'On the Streets' },
            ].map((item) => (
              <div key={item.label} className="card glass" style={{ padding: 14 }}>
                <div style={{ color: 'var(--text-secondary)', fontSize: 13, letterSpacing: 1 }}>{item.label}</div>
                <div style={{ fontWeight: 800, marginTop: 4 }}>{item.desc}</div>
              </div>
            ))}
          </div>
        </div>
        <div
          className="card hero-card"
          style={{
            backgroundImage:
              "linear-gradient(145deg, rgba(122,31,31,0.45), rgba(12,12,16,0.82)), url('https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1400&q=80&sat=-100')",
            border: '1px solid var(--gold)',
            boxShadow: '0 16px 40px rgba(0,0,0,0.35)',
          }}
        >
          <SectionHeader eyebrow="Tonight’s Specials" title="The Hit List" subtitle="Curated by the Don" />
          <div style={{ display: 'grid', gap: 14 }}>
            {[
              { title: 'The Boss Recommends', desc: 'Signature pies blessed by the Don himself.', cta: 'See Boss Picks' },
              { title: 'Under-the-Table Deals', desc: 'Limited runs, whispered only to family.', cta: 'View Deals' },
              { title: 'Family Combos', desc: 'Pies, sides, and liquid alibis bundled tight.', cta: 'Build a Combo' },
            ].map((item) => (
              <div key={item.title} style={{ padding: 14, borderRadius: 10, border: '1px solid var(--border)', background: 'rgba(28,21,18,0.65)' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', gap: 12 }}>
                  <div>
                    <div style={{ fontWeight: 800 }}>{item.title}</div>
                    <div style={{ color: 'var(--text-secondary)', fontSize: 14 }}>{item.desc}</div>
                  </div>
                  <Link to="/menu">
                    <Button variant="ghost" style={{ padding: '8px 12px' }}>
                      {item.cta}
                    </Button>
                  </Link>
                </div>
              </div>
            ))}
          </div>
          <div style={{ marginTop: 16 }}>
            <Badge label="Boss Picks • House Secrets • Family Combos" tone="olive" />
          </div>
        </div>
      </section>

      <section className="page" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(260px, 1fr))', gap: 18 }}>
        {['Boss Pies', 'Family Combos', 'Side Hustles', 'Liquid Alibis'].map((label, idx) => (
          <div key={label} className="card glass">
            <div style={{ color: 'var(--text-secondary)', letterSpacing: 1, textTransform: 'uppercase', fontSize: 13 }}>Category</div>
            <div style={{ fontSize: 22, fontWeight: 800, margin: '6px 0 10px', letterSpacing: 0.5 }}>{label}</div>
            <p style={{ color: 'var(--text-secondary)', fontSize: 14 }}>
              {idx === 0 && 'Signature pies crafted for the Don.'}
              {idx === 1 && 'Pies + sides + drinks, bundled like a good alibi.'}
              {idx === 2 && 'Garlic knots, wings, and small bites for the crew.'}
              {idx === 3 && 'Mocktails, sodas, desserts to keep things cool.'}
            </p>
            <Link to="/menu">
              <Button variant="ghost" style={{ padding: '8px 10px', marginTop: 8 }}>
                View {label}
              </Button>
            </Link>
          </div>
        ))}
      </section>

      <section className="page">
        <div className="card glass" style={{ borderLeft: '3px solid var(--gold)' }}>
          <SectionHeader eyebrow="Family Rules" title="Order Flow" subtitle="Smooth, cinematic, and to the point." />
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))', gap: 12 }}>
            {[
              'Browse the Hit List → Add to Job Summary',
              'Choose Family Delivery or Safehouse Pickup',
              'Drop Location → Payment → Lock In the Job',
              'Track Your Runner on the Streets',
            ].map((rule, idx) => (
              <div key={rule} className="card" style={{ border: '1px dashed var(--border)' }}>
                <div style={{ color: 'var(--gold)', fontWeight: 800, marginBottom: 6 }}>0{idx + 1}</div>
                <div style={{ fontWeight: 700 }}>{rule}</div>
              </div>
            ))}
          </div>
        </div>
      </section>
    </main>
  );
};

export default LandingPage;


import Button from '../components/common/Button';
import SectionHeader from '../components/common/SectionHeader';

const AuthPage = () => {
  return (
    <div className="page" style={{ maxWidth: 780 }}>
      <SectionHeader eyebrow="Join the Family" title="Sign In / Sign Up" subtitle="Back in the Family or joining for the first time." />
      <div className="card" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: 18 }}>
        <div>
          <div style={{ fontWeight: 700, marginBottom: 8 }}>Email</div>
          <input
            type="email"
            placeholder="you@example.com"
            style={{
              width: '100%',
              padding: '12px 14px',
              borderRadius: 8,
              border: '1px solid var(--border)',
              background: 'rgba(255,255,255,0.02)',
              color: 'var(--text-primary)',
            }}
          />
          <div style={{ fontWeight: 700, margin: '12px 0 8px' }}>Password</div>
          <input
            type="password"
            placeholder="••••••••"
            style={{
              width: '100%',
              padding: '12px 14px',
              borderRadius: 8,
              border: '1px solid var(--border)',
              background: 'rgba(255,255,255,0.02)',
              color: 'var(--text-primary)',
            }}
          />
          <Button style={{ marginTop: 14, width: '100%' }}>Back in the Family</Button>
          <Button variant="ghost" style={{ marginTop: 8, width: '100%' }}>
            Join the Family
          </Button>
        </div>
        <div style={{ background: 'rgba(28,21,18,0.6)', border: '1px dashed var(--border)', borderRadius: 10, padding: 16 }}>
          <div style={{ fontWeight: 800, marginBottom: 6 }}>Perks</div>
          <ul style={{ color: 'var(--text-secondary)', paddingLeft: 18, lineHeight: 1.6 }}>
            <li>Save safehouses & payment methods</li>
            <li>Track jobs in real-time</li>
            <li>Earn Family Points</li>
          </ul>
        </div>
      </div>
    </div>
  );
};

export default AuthPage;


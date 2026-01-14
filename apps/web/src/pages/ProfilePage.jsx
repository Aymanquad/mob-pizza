import SectionHeader from '../components/common/SectionHeader';
import Button from '../components/common/Button';

const ProfilePage = () => {
  return (
    <div className="page">
      <SectionHeader eyebrow="Your File" title="Profile & Preferences" subtitle="Manage addresses, payment methods, and loyalty." />
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: 16 }}>
        <div className="card">
          <div style={{ fontWeight: 800, marginBottom: 6 }}>Profile</div>
          <div style={{ color: 'var(--text-secondary)', fontSize: 14 }}>John Doe · john@example.com · +91 98765 43210</div>
          <Button style={{ marginTop: 12 }}>Edit File</Button>
        </div>
        <div className="card">
          <div style={{ fontWeight: 800, marginBottom: 6 }}>Safehouses</div>
          <div style={{ color: 'var(--text-secondary)', fontSize: 14 }}>Home Base, Office Front</div>
          <Button style={{ marginTop: 12 }} variant="ghost">
            Manage Addresses
          </Button>
        </div>
        <div className="card">
          <div style={{ fontWeight: 800, marginBottom: 6 }}>Family Loyalty</div>
          <div style={{ color: 'var(--text-secondary)', fontSize: 14 }}>Rank: Capo</div>
          <Button style={{ marginTop: 12 }} variant="ghost">
            View Rewards
          </Button>
        </div>
      </div>
    </div>
  );
};

export default ProfilePage;


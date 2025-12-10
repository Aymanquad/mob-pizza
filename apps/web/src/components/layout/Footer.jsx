const Footer = () => {
  return (
    <footer
      style={{
        borderTop: '1px solid var(--border)',
        marginTop: 48,
        padding: '24px 0 32px',
        background: 'rgba(16,14,12,0.7)',
      }}
    >
      <div className="page" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', gap: 16, flexWrap: 'wrap' }}>
        <div>
          <div style={{ letterSpacing: 1, color: 'var(--gold)', textTransform: 'uppercase', fontWeight: 800 }}>Mob Pizza</div>
          <div style={{ color: 'var(--text-secondary)', fontSize: 14 }}>The Family’s Slice Since 1928.</div>
        </div>
        <div style={{ display: 'flex', gap: 16, color: 'var(--text-secondary)', fontSize: 14, alignItems: 'center' }}>
          <span>Privacy</span>
          <span>Terms</span>
          <span>Contact</span>
          <span style={{ color: 'var(--gold)', fontWeight: 700 }}>The Family is always watching.</span>
        </div>
      </div>
    </footer>
  );
};

export default Footer;


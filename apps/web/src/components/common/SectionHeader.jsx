const SectionHeader = ({ eyebrow = 'The Family', title, subtitle }) => {
  return (
    <div style={{ marginBottom: 16 }}>
      <div style={{ letterSpacing: 1.4, color: 'var(--gold)', textTransform: 'uppercase', fontWeight: 700, fontSize: 12 }}>
        {eyebrow}
      </div>
      <div style={{ fontSize: 28, fontWeight: 800, letterSpacing: 0.5, marginTop: 4 }}>{title}</div>
      {subtitle && <div style={{ color: 'var(--text-secondary)', marginTop: 6 }}>{subtitle}</div>}
    </div>
  );
};

export default SectionHeader;


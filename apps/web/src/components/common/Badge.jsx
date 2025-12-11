const Badge = ({ label, tone = 'gold' }) => {
  const palette = {
    gold: { bg: 'rgba(198,166,103,0.12)', fg: 'var(--gangster-gold)', border: '1px solid rgba(198,166,103,0.4)' },
    red: { bg: 'rgba(193,39,39,0.12)', fg: 'var(--hitman-red)', border: '1px solid rgba(193,39,39,0.4)' },
    olive: { bg: 'rgba(82,96,78,0.12)', fg: 'var(--olive)', border: '1px solid rgba(82,96,78,0.4)' },
  }[tone];

  return (
    <span
      style={{
        display: 'inline-flex',
        alignItems: 'center',
        gap: 6,
        padding: '6px 10px',
        borderRadius: 999,
        fontSize: 12,
        letterSpacing: 0.6,
        textTransform: 'uppercase',
        ...palette,
      }}
    >
      {label}
    </span>
  );
};

export default Badge;


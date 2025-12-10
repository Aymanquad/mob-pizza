const Badge = ({ label, tone = 'gold' }) => {
  const palette = {
    gold: { bg: 'rgba(217,164,65,0.12)', fg: 'var(--gold)', border: '1px solid rgba(217,164,65,0.4)' },
    red: { bg: 'rgba(179,34,34,0.12)', fg: 'var(--mob-red)', border: '1px solid rgba(179,34,34,0.4)' },
    olive: { bg: 'rgba(145,159,137,0.12)', fg: 'var(--olive)', border: '1px solid rgba(145,159,137,0.4)' },
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


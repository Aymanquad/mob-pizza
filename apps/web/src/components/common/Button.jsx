const styles = {
  base: {
    border: 'none',
    outline: 'none',
    borderRadius: 10,
    padding: '12px 18px',
    fontWeight: 700,
    letterSpacing: 0.5,
    cursor: 'pointer',
    transition: 'transform 120ms ease, box-shadow 120ms ease',
  },
  primary: {
    background: 'var(--gold)',
    color: '#0b0c10',
    boxShadow: '0 6px 18px rgba(217,164,65,0.35)',
  },
  ghost: {
    background: 'transparent',
    color: 'var(--gold)',
    border: '1px solid var(--gold)',
  },
};

const Button = ({ children, variant = 'primary', style, ...props }) => {
  const variantStyle = styles[variant] || styles.primary;
  return (
    <button
      type="button"
      style={{ ...styles.base, ...variantStyle, ...style }}
      onMouseDown={(e) => e.currentTarget.style.transform = 'translateY(1px)'}
      onMouseUp={(e) => e.currentTarget.style.transform = 'translateY(0)'}
      {...props}
    >
      {children}
    </button>
  );
};

export default Button;


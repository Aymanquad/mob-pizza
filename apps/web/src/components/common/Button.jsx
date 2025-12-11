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
    background: 'var(--mob-black)',
    color: 'var(--gold)',
    boxShadow: '0 6px 18px rgba(0,0,0,0.25)',
    border: '1px solid var(--gold)',
  },
  ghost: {
    background: 'var(--bootleg-burgundy)',
    color: 'var(--ivory)',
    border: '1px solid var(--bootleg-burgundy)',
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


import { Link, NavLink } from 'react-router-dom';

const navStyle = ({ isActive }) => ({
  color: isActive ? 'var(--gold)' : 'var(--text-secondary)',
  fontWeight: isActive ? 800 : 600,
  letterSpacing: '0.5px',
  textTransform: 'uppercase',
  fontSize: 13,
});

const Navbar = () => {
  return (
    <header
      style={{
        position: 'sticky',
        top: 0,
        zIndex: 10,
        background: 'var(--mob-black)',
        borderBottom: '1px solid var(--gold)',
        boxShadow: '0 10px 30px rgba(0,0,0,0.35)',
      }}
    >
      <div className="page" style={{ paddingTop: 18, paddingBottom: 12, display: 'flex', alignItems: 'center', gap: 18 }}>
        <Link to="/" style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
          <img src="/logo-mob.svg" alt="Mob Pizza" width={46} height={46} />
          <div>
            <div style={{ fontSize: 13, color: 'var(--gold)', letterSpacing: 1, textTransform: 'uppercase' }}>The Family</div>
            <div style={{ fontSize: 18, fontWeight: 900, letterSpacing: 2, color: 'var(--gold)', fontFamily: 'Cinzel, serif' }}>Mob Pizza</div>
          </div>
        </Link>
        <nav style={{ display: 'flex', gap: 18, marginLeft: 'auto', alignItems: 'center' }}>
          <NavLink to="/menu" style={navStyle}>
            The Hit List
          </NavLink>
          <NavLink to="/orders" style={navStyle}>
            Past Jobs
          </NavLink>
          <NavLink to="/profile" style={navStyle}>
            Your File
          </NavLink>
          <NavLink to="/cart" style={navStyle}>
            Job Summary
          </NavLink>
          <Link
            to="/auth"
            style={{
              padding: '10px 14px',
              borderRadius: 10,
              border: '1px solid var(--gold)',
              color: '#0b0c10',
              background: 'var(--gold)',
              fontWeight: 800,
              letterSpacing: 0.5,
              boxShadow: '0 8px 20px rgba(217,164,65,0.4)',
            }}
          >
            Join the Family
          </Link>
        </nav>
      </div>
    </header>
  );
};

export default Navbar;


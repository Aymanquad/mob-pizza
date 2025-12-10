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
        backdropFilter: 'blur(10px)',
        background: 'rgba(12, 12, 16, 0.8)',
        borderBottom: '1px solid var(--border)',
        boxShadow: '0 10px 30px rgba(0,0,0,0.35)',
      }}
    >
      <div className="page" style={{ paddingTop: 18, paddingBottom: 12, display: 'flex', alignItems: 'center', gap: 18 }}>
        <Link to="/" style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
          <div
            style={{
              width: 44,
              height: 44,
              borderRadius: 10,
              background: 'linear-gradient(135deg, var(--mob-red), var(--gold))',
              display: 'grid',
              placeItems: 'center',
              fontWeight: 800,
              color: '#0b0c10',
              letterSpacing: 1,
              boxShadow: '0 10px 24px rgba(179,34,34,0.35)',
            }}
          >
            MP
          </div>
          <div>
            <div style={{ fontSize: 13, color: 'var(--text-secondary)', letterSpacing: 1 }}>The Family</div>
            <div style={{ fontSize: 18, fontWeight: 900, letterSpacing: 2, color: 'var(--text-primary)' }}>MOB PIZZA</div>
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


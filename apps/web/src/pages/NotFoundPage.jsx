import Button from '../components/common/Button';
import { Link } from 'react-router-dom';

const NotFoundPage = () => {
  return (
    <div className="page" style={{ textAlign: 'center', paddingTop: 80 }}>
      <div style={{ fontSize: 42, fontWeight: 800, marginBottom: 12 }}>Closed Case</div>
      <div style={{ color: 'var(--text-secondary)', marginBottom: 18 }}>The page you’re after is off the books.</div>
      <Link to="/menu">
        <Button>Return to The Hit List</Button>
      </Link>
    </div>
  );
};

export default NotFoundPage;


import Button from '../components/common/Button';
import SectionHeader from '../components/common/SectionHeader';

const CartPage = () => {
  return (
    <div className="page">
      <SectionHeader eyebrow="Job Summary" title="Your Cart" subtitle="Review items before locking in the job." />
      <div className="card glass" style={{ display: 'grid', gap: 14 }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderBottom: '1px solid var(--border)', paddingBottom: 10 }}>
          <div>
            <div style={{ fontWeight: 700 }}>Margherita – The Mistress</div>
            <div style={{ color: 'var(--text-secondary)', fontSize: 14 }}>Solo size · Extra cheese</div>
          </div>
          <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
            <span style={{ color: 'var(--text-secondary)' }}>x1</span>
            <div style={{ fontWeight: 800 }}>$12.00</div>
          </div>
        </div>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <div style={{ color: 'var(--text-secondary)' }}>Subtotal</div>
          <div style={{ fontWeight: 700 }}>$12.00</div>
        </div>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <div style={{ color: 'var(--text-secondary)' }}>Delivery</div>
          <div style={{ fontWeight: 700 }}>$2.00</div>
        </div>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontSize: 18 }}>
          <div style={{ fontWeight: 800 }}>The Take</div>
          <div style={{ fontWeight: 800 }}>$14.00</div>
        </div>
        <div style={{ display: 'flex', gap: 12, marginTop: 8 }}>
          <Button>Proceed to The Deal</Button>
          <Button variant="ghost">Keep Browsing the Hit List</Button>
        </div>
      </div>
    </div>
  );
};

export default CartPage;


import Button from '../components/common/Button';
import SectionHeader from '../components/common/SectionHeader';

const CheckoutPage = () => {
  return (
    <div className="page">
      <SectionHeader eyebrow="Final Briefing" title="Delivery & Payment" subtitle="Confirm drop location and payment method." />
      <div style={{ display: 'grid', gridTemplateColumns: '2fr 1fr', gap: 18, flexWrap: 'wrap' }}>
        <div className="card glass">
          <div style={{ fontWeight: 700, marginBottom: 8 }}>Drop Location</div>
          <div style={{ color: 'var(--text-secondary)', fontSize: 14 }}>Safehouse: 221B Baker Street, Apt 3</div>
          <div style={{ marginTop: 12, display: 'flex', gap: 10 }}>
            <Button variant="ghost">Edit Address</Button>
            <Button variant="ghost">Use Pickup</Button>
          </div>
          <div style={{ marginTop: 18 }}>
            <div style={{ fontWeight: 700, marginBottom: 6 }}>Payment</div>
            <div style={{ color: 'var(--text-secondary)', fontSize: 14 }}>Razorpay · **** 4242</div>
            <div style={{ marginTop: 10, display: 'flex', gap: 10 }}>
              <Button variant="ghost">Change Method</Button>
            </div>
          </div>
        </div>
        <div className="card glass">
          <div style={{ fontWeight: 800, letterSpacing: 0.5, marginBottom: 10 }}>The Take</div>
          <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 6 }}>
            <span style={{ color: 'var(--text-secondary)' }}>Subtotal</span>
            <span>$12.00</span>
          </div>
          <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 6 }}>
            <span style={{ color: 'var(--text-secondary)' }}>Delivery</span>
            <span>$2.00</span>
          </div>
          <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 12 }}>
            <span style={{ color: 'var(--text-secondary)' }}>Tax</span>
            <span>$1.00</span>
          </div>
          <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: 18, fontWeight: 800, marginBottom: 12 }}>
            <span>Total</span>
            <span>$15.00</span>
          </div>
          <Button>Lock In the Job</Button>
        </div>
      </div>
    </div>
  );
};

export default CheckoutPage;


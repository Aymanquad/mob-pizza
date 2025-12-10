import Badge from '../components/common/Badge';
import SectionHeader from '../components/common/SectionHeader';

const orders = [
  { id: 'ORD-001', status: 'On the Streets', total: 28.5, eta: '18 mins', items: '2x Boss Pies, 1x Liquid Alibi' },
  { id: 'ORD-000', status: 'Delivered', total: 14, eta: 'Delivered', items: '1x Margherita – The Mistress' },
];

const toneForStatus = (status) => {
  if (status === 'Delivered') return 'olive';
  if (status === 'On the Streets') return 'gold';
  return 'red';
};

const OrdersPage = () => {
  return (
    <div className="page">
      <SectionHeader eyebrow="Past Jobs" title="Orders & Tracking" subtitle="Track current runs and review history." />
      <div className="card glass" style={{ display: 'grid', gap: 12 }}>
        {orders.map((order) => (
          <div key={order.id} style={{ padding: 12, borderRadius: 8, border: '1px solid var(--border)', background: 'rgba(28,21,18,0.6)' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', gap: 12 }}>
              <div>
                <div style={{ fontWeight: 800, letterSpacing: 0.5 }}>{order.id}</div>
                <div style={{ color: 'var(--text-secondary)', fontSize: 14 }}>{order.items}</div>
              </div>
              <Badge label={order.status} tone={toneForStatus(order.status)} />
            </div>
            <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: 8, color: 'var(--text-secondary)' }}>
              <span>ETA: {order.eta}</span>
              <span style={{ fontWeight: 800, color: 'var(--text-primary)' }}>${order.total.toFixed(2)}</span>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default OrdersPage;


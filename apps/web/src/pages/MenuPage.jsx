import Badge from '../components/common/Badge';
import Button from '../components/common/Button';
import SectionHeader from '../components/common/SectionHeader';

const mockItems = [
  {
    id: '1',
    name: 'Margherita – The Mistress',
    desc: 'Thin crust trusted by the Don since 1928.',
    price: 12,
    tag: 'Boss Pick',
    veg: true,
  },
  {
    id: '2',
    name: 'Smoky Capo BBQ',
    desc: 'Brick oven, sweet heat, charred edges.',
    price: 15,
    tag: 'House Secret',
    veg: false,
  },
  {
    id: '3',
    name: 'Truffle White Truffle Hit',
    desc: 'White sauce, mushrooms, parmesan rain.',
    price: 16,
    tag: 'Family Favorite',
    veg: true,
  },
  {
    id: '4',
    name: 'Brick Oven Don',
    desc: 'Fire-kissed crust, smoked mozzarella, basil oil.',
    price: 17,
    tag: 'Signature',
    veg: false,
  },
];

const MenuPage = () => {
  return (
    <div className="page">
      <SectionHeader eyebrow="The Hit List" title="Tonight’s Specials" subtitle="Browse, customize, and add to your Job Summary." />
      <div className="card glass" style={{ marginBottom: 18 }}>
        <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap', alignItems: 'center' }}>
          <Button variant="ghost">Boss Picks</Button>
          <Button variant="ghost">Veg Associates</Button>
          <Button variant="ghost">Heat: Made</Button>
          <Button variant="ghost">Price: Low → High</Button>
          <span style={{ color: 'var(--text-secondary)', fontSize: 14 }}>Search the Hit List…</span>
        </div>
      </div>
      <div className="menu-grid">
        {mockItems.map((item) => (
          <div key={item.id} className="card glass menu-card" style={{ border: '1px solid rgba(217,164,65,0.1)' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <Badge label={item.tag} tone="gold" />
              <span style={{ color: item.veg ? '#7ed957' : 'var(--mob-red)', fontWeight: 700 }}>{item.veg ? 'Veg' : 'Non-Veg'}</span>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginTop: 10 }}>
              <div className="image-chip">
                <img
                  src="/images/pizza-placeholder.svg"
                  alt={item.name}
                  onError={(e) => {
                    e.currentTarget.style.display = 'none';
                  }}
                />
              </div>
              <div>
                <div style={{ fontSize: 18, fontWeight: 800 }}>{item.name}</div>
                <p style={{ color: 'var(--text-secondary)', minHeight: 40, margin: '4px 0' }}>{item.desc}</p>
              </div>
            </div>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: 10 }}>
              <div style={{ fontWeight: 800, letterSpacing: 0.5 }}>${item.price.toFixed(2)}</div>
              <div style={{ display: 'flex', gap: 8 }}>
                <Button variant="ghost" style={{ padding: '10px 12px' }}>
                  Customize
                </Button>
                <Button style={{ padding: '10px 12px' }}>Add to Hit List</Button>
              </div>
            </div>
          </div>
        ))}
      </div>
      <div className="card glass" style={{ marginTop: 18 }}>
        <SectionHeader eyebrow="Under-the-Table Deals" title="Closed Door Specials" subtitle="Limited drops, whispered to family only." />
        <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap' }}>
          <Badge label="2 for 1 after 9pm" tone="red" />
          <Badge label="Free Liquid Alibi on orders 30+" tone="gold" />
          <Badge label="Safehouse Pickup Discount" tone="olive" />
        </div>
      </div>
    </div>
  );
};

export default MenuPage;


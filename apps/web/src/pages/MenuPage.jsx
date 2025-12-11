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
    img: 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '2',
    name: 'Smoky Capo BBQ',
    desc: 'Brick oven, sweet heat, charred edges.',
    price: 15,
    tag: 'House Secret',
    veg: false,
    img: 'https://images.unsplash.com/photo-1548365328-9da9d5166be6?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '3',
    name: 'Truffle White Truffle Hit',
    desc: 'White sauce, mushrooms, parmesan rain.',
    price: 16,
    tag: 'Family Favorite',
    veg: true,
    img: 'https://images.unsplash.com/photo-1547496502-affa22d38842?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '4',
    name: 'Brick Oven Don',
    desc: 'Fire-kissed crust, smoked mozzarella, basil oil.',
    price: 17,
    tag: 'Signature',
    veg: false,
    img: 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '5',
    name: 'Caprese Hitman',
    desc: 'Fresh mozz, basil, olive mafia drizzle.',
    price: 14,
    tag: 'Limited',
    veg: true,
    img: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '6',
    name: 'Velvet Pepperoni',
    desc: 'Loaded curls, velvet cheese pull.',
    price: 15.5,
    tag: 'Boss Pick',
    veg: false,
    img: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
];

const MenuPage = () => {
  return (
    <div className="page" style={{ background: 'var(--mob-black)' }}>
      <SectionHeader eyebrow="The Hit List" title="Tonight’s Specials" subtitle="Browse, customize, and add to your Job Summary." />
      <div className="card glass" style={{ marginBottom: 18, background: 'var(--mob-black)', border: '1px solid var(--gold)' }}>
        <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap', alignItems: 'center' }}>
          <Button variant="ghost">Boss Picks</Button>
          <Button variant="ghost">Veg Associates</Button>
          <Button variant="ghost">Heat: Made</Button>
          <Button variant="ghost">Price: Low → High</Button>
          <span style={{ color: 'var(--ivory)', fontSize: 14 }}>Search the Hit List…</span>
        </div>
      </div>
      <div className="menu-grid">
        {mockItems.map((item) => (
          <div
            key={item.id}
            className="card glass menu-card"
            style={{
              border: '1px solid var(--gold)',
              background: 'var(--mob-black)',
              boxShadow: '0 14px 32px rgba(0,0,0,0.35)',
            }}
          >
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <Badge label={item.tag} tone="gold" />
              <span style={{ color: item.veg ? '#7ed957' : 'var(--hitman-red)', fontWeight: 700 }}>{item.veg ? 'Veg' : 'Non-Veg'}</span>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: 14, marginTop: 12 }}>
              <div
                className="image-chip"
                style={{
                  border: '1px solid var(--gold)',
                  width: 120,
                  height: 120,
                  overflow: 'hidden',
                }}
              >
                <img src={item.img} alt={item.name} style={{ width: '100%', height: '100%', objectFit: 'cover', filter: 'grayscale(1)' }} />
              </div>
              <div>
                <div style={{ fontSize: 18, fontWeight: 800, color: 'var(--gold)' }}>{item.name}</div>
                <p style={{ color: 'var(--ivory)', minHeight: 40, margin: '4px 0' }}>{item.desc}</p>
              </div>
            </div>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: 12 }}>
              <div style={{ fontWeight: 800, letterSpacing: 0.5, color: 'var(--gold)' }}>${item.price.toFixed(2)}</div>
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
      <div className="card glass" style={{ marginTop: 18, border: '1px solid var(--gold)', background: 'var(--mob-black)' }}>
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


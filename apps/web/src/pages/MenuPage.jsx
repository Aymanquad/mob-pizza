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
    img: 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=900&q=80',
  },
  {
    id: '2',
    name: 'Smoky Capo BBQ',
    desc: 'Brick oven, sweet heat, charred edges.',
    price: 15,
    tag: 'House Secret',
    veg: false,
    img: 'https://images.unsplash.com/photo-1548365328-9da9d5166be6?auto=format&fit=crop&w=900&q=80',
  },
  {
    id: '3',
    name: 'Truffle White Truffle Hit',
    desc: 'White sauce, mushrooms, parmesan rain.',
    price: 16,
    tag: 'Family Favorite',
    veg: true,
    img: 'https://images.unsplash.com/photo-1547496502-affa22d38842?auto=format&fit=crop&w=900&q=80',
  },
  {
    id: '4',
    name: 'Brick Oven Don',
    desc: 'Fire-kissed crust, smoked mozzarella, basil oil.',
    price: 17,
    tag: 'Signature',
    veg: false,
    img: 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?auto=format&fit=crop&w=900&q=80',
  },
  {
    id: '5',
    name: 'Caprese Hitman',
    desc: 'Fresh mozz, basil, olive mafia drizzle.',
    price: 14,
    tag: 'Limited',
    veg: true,
    img: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=900&q=80',
  },
  {
    id: '6',
    name: 'Velvet Pepperoni',
    desc: 'Loaded curls, velvet cheese pull.',
    price: 15.5,
    tag: 'Boss Pick',
    veg: false,
    img: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=900&q=80',
  },
  {
    id: '7',
    name: 'Japanese-Inspired',
    desc: 'Seafood, mayo, teriyaki elements.',
    price: 16.5,
    tag: 'Limited',
    veg: false,
    img: 'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '8',
    name: 'Indian-Inspired',
    desc: 'Paneer, tandoori toppings, spiced sauces.',
    price: 15,
    tag: 'House Secret',
    veg: true,
    img: 'https://images.unsplash.com/photo-1604908176723-3f6c9e0c8c91?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '9',
    name: 'Turkish Pide',
    desc: 'Boat-shaped flatbread with toppings.',
    price: 17.5,
    tag: 'Signature',
    veg: false,
    img: 'https://images.unsplash.com/photo-1521017432531-fbd92d768814?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '10',
    name: 'Brazilian',
    desc: 'Sweet/dessert-style alongside savory.',
    price: 14.5,
    tag: 'Limited',
    veg: false,
    img: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '11',
    name: 'New York Style',
    desc: 'Large, foldable slices; thin but sturdy crust.',
    price: 14,
    tag: 'Classic',
    veg: false,
    img: 'https://images.unsplash.com/photo-1548365328-9da9d5166be6?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '12',
    name: 'Chicago Deep Dish',
    desc: 'Thick, pie-like crust with layered cheese and sauce.',
    price: 18,
    tag: 'Signature',
    veg: false,
    img: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '13',
    name: 'Detroit Style',
    desc: 'Rectangular pan, caramelized cheese edges.',
    price: 17.5,
    tag: 'Classic',
    veg: false,
    img: 'https://images.unsplash.com/photo-1521017432531-fbd92d768814?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '14',
    name: 'California Style',
    desc: 'Thin crust with unconventional fresh toppings.',
    price: 15,
    tag: 'Limited',
    veg: false,
    img: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '15',
    name: 'Pepperoni Classic',
    desc: 'Tomato sauce, mozzarella, pepperoni slices.',
    price: 13,
    tag: 'Boss Pick',
    veg: false,
    img: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '16',
    name: 'Cheese Classic',
    desc: 'Tomato sauce and mozzarella; minimalist comfort.',
    price: 11,
    tag: 'Classic',
    veg: true,
    img: 'https://images.unsplash.com/photo-1542281286-9e0a16bb7366?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '17',
    name: 'Veggie Classic',
    desc: 'Peppers, onions, olives, mushrooms.',
    price: 12.5,
    tag: 'Classic',
    veg: true,
    img: 'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '18',
    name: 'Neapolitan',
    desc: 'Thin, soft, wood-fired with blistered edges.',
    price: 15.5,
    tag: 'Signature',
    veg: true,
    img: 'https://images.unsplash.com/photo-1541745537411-b8046dc6d66c?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '19',
    name: 'Roman al Taglio',
    desc: 'Rectangular, thin, crisp; sold by the slice.',
    price: 16,
    tag: 'Limited',
    veg: false,
    img: 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '20',
    name: 'Sicilian (Sfinciuni)',
    desc: 'Thick, airy crust; onion-forward sauce.',
    price: 16.5,
    tag: 'Signature',
    veg: false,
    img: 'https://images.unsplash.com/photo-1458642849426-cfb724f15ef7?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '21',
    name: 'Stuffed Crust',
    desc: 'Cheese-filled crust edge for the indulgent.',
    price: 17,
    tag: 'Boss Pick',
    veg: false,
    img: 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '22',
    name: 'White Pizza',
    desc: 'Ricotta, mozzarella, olive oil, garlic—no tomato sauce.',
    price: 15,
    tag: 'Limited',
    veg: true,
    img: 'https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '23',
    name: 'Gluten-Free Pizza',
    desc: 'Alternative flours for a lighter base.',
    price: 16,
    tag: 'Special',
    veg: true,
    img: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=400&q=80&sat=-100',
  },
  {
    id: '24',
    name: 'Vegan Pizza',
    desc: 'Plant-based cheese and toppings; no animal products.',
    price: 15.5,
    tag: 'Special',
    veg: true,
    img: 'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?auto=format&fit=crop&w=400&q=80&sat=-100',
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
                  width: 130,
                  height: 130,
                  overflow: 'hidden',
                }}
              >
                <img
                  src={`${item.img.replace('&sat=-100', '')}&h=900&w=900&fit=crop`}
                  alt={item.name}
                  style={{ width: '100%', height: '100%', objectFit: 'cover' }}
                />
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


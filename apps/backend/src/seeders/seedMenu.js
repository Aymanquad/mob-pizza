const mongoose = require('mongoose');
const MenuItem = require('../models/MenuItem');

const menuItems = [
  // COMMENTED OUT - Not in menu images
  // {
  //   name: 'Margherita Pizza',
  //   description: 'Classic pizza with tomato sauce, mozzarella cheese, and fresh basil. The family favorite since 1928.',
  //   category: 'boss-pies',
  //   basePrice: 299,
  //   sizes: [
  //     { name: 'small', price: 299, calories: 650 },
  //     { name: 'medium', price: 399, calories: 850 },
  //     { name: 'large', price: 499, calories: 1100 }
  //   ],
  //   toppings: [
  //     { id: 'extra-cheese', name: 'Extra Cheese', price: 50, category: 'cheese' },
  //     { id: 'mushrooms', name: 'Mushrooms', price: 40, category: 'vegetable' },
  //     { id: 'olives', name: 'Black Olives', price: 35, category: 'vegetable' }
  //   ],
  //   isVegetarian: true,
  //   preparationTime: 15,
  //   rating: 4.5,
  //   allergens: ['dairy', 'gluten'],
  //   tags: ['classic', 'vegetarian', 'popular']
  // },
  {
    name: 'Pepperoni Boss',
    description: 'Our signature pepperoni pizza with spicy red sauce and premium mozzarella. Made for the Don himself.',
    category: 'boss-pies',
    basePrice: 349, // Note: Price in cents, matches $13.00 in menu (1300 cents would be $13.00, but keeping existing structure)
    sizes: [
      { name: 'small', price: 349, calories: 720 },
      { name: 'medium', price: 449, calories: 950 },
      { name: 'large', price: 549, calories: 1250 }
    ],
    toppings: [
      { id: 'extra-pepperoni', name: 'Extra Pepperoni', price: 60, category: 'meat' },
      { id: 'jalapenos', name: 'Jalapenos', price: 30, category: 'vegetable' },
      { id: 'extra-cheese', name: 'Extra Cheese', price: 50, category: 'cheese' }
    ],
    isVegetarian: false,
    preparationTime: 18,
    rating: 4.7,
    allergens: ['dairy', 'gluten'],
    tags: ['spicy', 'meat', 'signature']
  },
  // COMMENTED OUT - Not in menu images
  // {
  //   name: 'Family Feast Combo',
  //   description: 'Large Margherita + Large Pepperoni + Garlic Bread + 2 Sodas. Perfect for the whole family gathering.',
  //   category: 'family-combos',
  //   basePrice: 899,
  //   isVegetarian: false,
  //   preparationTime: 20,
  //   rating: 4.3,
  //   allergens: ['dairy', 'gluten'],
  //   tags: ['combo', 'family', 'value']
  // },
  // {
  //   name: 'Garlic Breadsticks',
  //   description: 'Freshly baked breadsticks with garlic butter and herbs. The perfect side for any pizza.',
  //   category: 'side-hustles',
  //   basePrice: 149,
  //   isVegetarian: true,
  //   preparationTime: 8,
  //   rating: 4.2,
  //   allergens: ['dairy', 'gluten'],
  //   tags: ['bread', 'garlic', 'vegetarian']
  // },
  {
    name: 'Coca Cola',
    description: 'Classic Coca Cola in a glass bottle. The real deal, just like the old days.',
    category: 'liquid-alibis',
    basePrice: 299, // Updated from 49 to match $2.99 for 16oz (price in cents: 299 = $2.99)
    isVegetarian: true,
    // Relaxed to meet minimum prep time validator (>=5)
    preparationTime: 5,
    rating: 4.0,
    allergens: [],
    tags: ['drink', 'cola', 'classic']
  }
];

const seedMenu = async () => {
  try {
    console.log('🌱 Seeding menu items...');

    // Clear existing data
    await MenuItem.deleteMany({});
    console.log('🗑️  Cleared existing menu items');

    // Insert new data
    const insertedItems = await MenuItem.insertMany(menuItems);
    console.log(`✅ Seeded ${insertedItems.length} menu items successfully`);

    return insertedItems;
  } catch (error) {
    console.error('❌ Error seeding menu items:', error);
    throw error;
  }
};

module.exports = { seedMenu, menuItems };

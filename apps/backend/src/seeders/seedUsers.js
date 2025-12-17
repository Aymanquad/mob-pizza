const mongoose = require('mongoose');
const User = require('../models/User');

const users = [
  {
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@mobpizza.com',
    phone: '+919876543210',
    passwordHash: 'SecurePass123', // Will be hashed by pre-save middleware
    role: 'customer',
    preferences: {
      dietary: ['vegetarian'],
      spiceLevel: 'medium',
      allergies: []
    },
    loyaltyPoints: 150,
    isActive: true,
    emailVerified: true,
    phoneVerified: true,
    addresses: [
      {
        label: 'home',
        street: '221B Baker Street',
        city: 'London',
        state: 'Greater London',
        zipCode: 'NW16XE',
        coordinates: { type: 'Point', coordinates: [-0.1586, 51.5238] },
        isDefault: true
      }
    ],
    favorites: [],
    paymentMethods: [
      {
        brand: 'visa',
        last4: '4242',
        expiryMonth: 12,
        expiryYear: 2026,
        token: 'tok_test_visa',
        isDefault: true
      }
    ]
  },
  {
    firstName: 'Jane',
    lastName: 'Smith',
    email: 'jane.smith@mobpizza.com',
    phone: '+919876543211',
    passwordHash: 'SecurePass123',
    role: 'customer',
    preferences: {
      dietary: [],
      spiceLevel: 'hot',
      allergies: ['nuts']
    },
    loyaltyPoints: 300,
    isActive: true,
    emailVerified: true,
    phoneVerified: true,
    addresses: [
      {
        label: 'home',
        street: '742 Evergreen Terrace',
        city: 'Springfield',
        state: 'Oregon',
        zipCode: '97403',
        coordinates: { type: 'Point', coordinates: [-122.6822, 44.0462] },
        isDefault: true
      },
      {
        label: 'office',
        street: '123 Business Ave',
        city: 'Springfield',
        state: 'Oregon',
        zipCode: '97404',
        coordinates: { type: 'Point', coordinates: [-122.678, 44.05] },
        isDefault: false
      }
    ],
    favorites: [],
    paymentMethods: []
  },
  {
    firstName: 'Admin',
    lastName: 'User',
    email: 'admin@mobpizza.com',
    phone: '+919876543212',
    passwordHash: 'AdminPass123',
    role: 'admin',
    preferences: {
      dietary: [],
      spiceLevel: 'medium',
      allergies: []
    },
    loyaltyPoints: 0,
    isActive: true,
    emailVerified: true,
    phoneVerified: true,
    addresses: [],
    favorites: [],
    paymentMethods: []
  },
  {
    firstName: 'Delivery',
    lastName: 'Partner',
    email: 'delivery@mobpizza.com',
    phone: '+919876543213',
    passwordHash: 'DeliveryPass123',
    role: 'delivery',
    preferences: {
      dietary: [],
      spiceLevel: 'medium',
      allergies: []
    },
    loyaltyPoints: 0,
    isActive: true,
    emailVerified: true,
    phoneVerified: true,
    addresses: [],
    favorites: [],
    paymentMethods: []
  }
];

const seedUsers = async () => {
  try {
    console.log('🌱 Seeding users...');

    // Clear existing data
    await User.deleteMany({});
    console.log('🗑️  Cleared existing users');

    // Insert new data
    const insertedUsers = await User.insertMany(users);
    console.log(`✅ Seeded ${insertedUsers.length} users successfully`);

    return insertedUsers;
  } catch (error) {
    console.error('❌ Error seeding users:', error);
    throw error;
  }
};

module.exports = { seedUsers, users };

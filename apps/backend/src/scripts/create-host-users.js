require('dotenv').config();
const mongoose = require('mongoose');
const { connectDatabase } = require('../config/database');
const User = require('../models/User');
const bcrypt = require('bcryptjs');

const createHostUsers = async () => {
  try {
    await connectDatabase();
    console.log('🌱 Creating/updating host users...');

    const hostPhones = ['1234567890', '0987654321'];
    const randomPassword = 'HostPass123';
    const passwordHash = await bcrypt.hash(randomPassword, 12);

    for (const phone of hostPhones) {
      const user = await User.findOneAndUpdate(
        { phone },
        {
          $set: {
            phone,
            role: 'admin', // Set as admin
            isActive: true,
            phoneVerified: true,
            onboardingCompleted: true,
          },
          $setOnInsert: {
            firstName: 'Host',
            lastName: 'User',
            email: `${phone}@mobpizza.local`,
            passwordHash,
            locale: 'en',
            consents: { location: true, notifications: true },
          },
        },
        { new: true, upsert: true }
      );

      console.log(`✅ Host user created/updated: ${phone} (role: ${user.role})`);
    }

    await mongoose.connection.close();
    console.log('🔌 Database connection closed');
    process.exit(0);
  } catch (error) {
    console.error('💥 Error creating host users:', error);
    process.exit(1);
  }
};

createHostUsers();


/**
 * Script to fix phone index - drop and recreate as sparse
 * Run this once to fix the existing database index
 * 
 * Usage: node apps/backend/src/scripts/fix-phone-index.js
 */

require('dotenv').config();
const mongoose = require('mongoose');
const { connectDatabase } = require('../config/database');
const User = require('../models/User');

const fixPhoneIndex = async () => {
  try {
    await connectDatabase();
    console.log('🔧 Fixing phone index...');

    const db = mongoose.connection.db;
    const collection = db.collection('users');

    // Drop existing phone index
    try {
      await collection.dropIndex('phone_1');
      console.log('✅ Dropped existing phone_1 index');
    } catch (err) {
      if (err.code === 27) {
        console.log('ℹ️  phone_1 index does not exist, skipping drop');
      } else {
        throw err;
      }
    }

    // Create new sparse index
    await collection.createIndex({ phone: 1 }, { sparse: true, unique: true });
    console.log('✅ Created new sparse phone_1 index');

    // Also fix googleId index
    try {
      await collection.dropIndex('googleId_1');
      console.log('✅ Dropped existing googleId_1 index');
    } catch (err) {
      if (err.code === 27) {
        console.log('ℹ️  googleId_1 index does not exist, skipping drop');
      } else {
        throw err;
      }
    }

    await collection.createIndex({ googleId: 1 }, { sparse: true, unique: true });
    console.log('✅ Created new sparse googleId_1 index');

    await mongoose.connection.close();
    console.log('🔌 Database connection closed');
    console.log('✅ Index fix complete!');
    process.exit(0);
  } catch (error) {
    console.error('💥 Error fixing index:', error);
    process.exit(1);
  }
};

fixPhoneIndex();



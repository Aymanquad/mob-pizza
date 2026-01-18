/**
 * Script to fix the email index - make it sparse to allow multiple null emails
 * Run this to fix the duplicate key error: E11000 duplicate key error collection: mob-pizza.users index: email_1
 * 
 * Usage: node apps/backend/src/scripts/fix-email-index.js
 */

require('dotenv').config();
const mongoose = require('mongoose');
const { connectDatabase } = require('../config/database');
const User = require('../models/User');

const fixEmailIndex = async () => {
  try {
    await connectDatabase();
    console.log('🔧 Fixing email index...');

    const db = mongoose.connection.db;
    const collection = db.collection('users');

    // Drop existing email index
    try {
      await collection.dropIndex('email_1');
      console.log('✅ Dropped existing email_1 index');
    } catch (err) {
      if (err.code === 27) {
        console.log('ℹ️  email_1 index does not exist, skipping drop');
      } else {
        throw err;
      }
    }

    // Create new sparse unique index
    await collection.createIndex({ email: 1 }, { sparse: true, unique: true });
    console.log('✅ Created new sparse email_1 index');

    // Verify the index
    const indexes = await collection.indexes();
    const emailIndex = indexes.find(idx => idx.name === 'email_1');
    if (emailIndex && emailIndex.sparse) {
      console.log('✅ Verified: email_1 index is now sparse and unique');
    } else {
      console.log('⚠️  Warning: email_1 index may not be sparse');
    }

    await mongoose.connection.close();
    console.log('🔌 Database connection closed');
    console.log('✅ Email index fix complete!');
    process.exit(0);
  } catch (error) {
    console.error('💥 Error fixing email index:', error);
    process.exit(1);
  }
};

fixEmailIndex();


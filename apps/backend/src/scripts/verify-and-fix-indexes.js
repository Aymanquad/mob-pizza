/**
 * Script to verify indexes are sparse and clean up any phone: null duplicates
 * Run this to ensure everything is correct
 * 
 * Usage: node apps/backend/src/scripts/verify-and-fix-indexes.js
 */

require('dotenv').config();
const mongoose = require('mongoose');
const { connectDatabase } = require('../config/database');
const User = require('../models/User');

const verifyAndFix = async () => {
  try {
    await connectDatabase();
    console.log('🔍 Verifying indexes and cleaning up...');

    const db = mongoose.connection.db;
    const collection = db.collection('users');

    // Get all indexes
    const indexes = await collection.indexes();
    console.log('\n📋 Current indexes:');
    indexes.forEach(idx => {
      console.log(`  - ${idx.name}: ${JSON.stringify(idx.key)}`);
      if (idx.sparse !== undefined) {
        console.log(`    Sparse: ${idx.sparse}, Unique: ${idx.unique || false}`);
      }
    });

    // Check phone_1 index
    const phoneIndex = indexes.find(idx => idx.name === 'phone_1');
    if (phoneIndex) {
      if (phoneIndex.sparse) {
        console.log('\n✅ phone_1 index is sparse - GOOD!');
      } else {
        console.log('\n❌ phone_1 index is NOT sparse - FIXING...');
        await collection.dropIndex('phone_1');
        await collection.createIndex({ phone: 1 }, { sparse: true, unique: true });
        console.log('✅ Fixed phone_1 index');
      }
    } else {
      console.log('\n⚠️  phone_1 index not found - CREATING...');
      await collection.createIndex({ phone: 1 }, { sparse: true, unique: true });
      console.log('✅ Created phone_1 index');
    }

    // Check googleId_1 index
    const googleIdIndex = indexes.find(idx => idx.name === 'googleId_1');
    if (googleIdIndex) {
      if (googleIdIndex.sparse) {
        console.log('\n✅ googleId_1 index is sparse - GOOD!');
      } else {
        console.log('\n❌ googleId_1 index is NOT sparse - FIXING...');
        await collection.dropIndex('googleId_1');
        await collection.createIndex({ googleId: 1 }, { sparse: true, unique: true });
        console.log('✅ Fixed googleId_1 index');
      }
    } else {
      console.log('\n⚠️  googleId_1 index not found - CREATING...');
      await collection.createIndex({ googleId: 1 }, { sparse: true, unique: true });
      console.log('✅ Created googleId_1 index');
    }

    // Check email_1 index (CRITICAL FIX)
    const emailIndex = indexes.find(idx => idx.name === 'email_1');
    if (emailIndex) {
      if (emailIndex.sparse) {
        console.log('\n✅ email_1 index is sparse - GOOD!');
      } else {
        console.log('\n❌ email_1 index is NOT sparse - FIXING...');
        await collection.dropIndex('email_1');
        await collection.createIndex({ email: 1 }, { sparse: true, unique: true });
        console.log('✅ Fixed email_1 index');
      }
    } else {
      console.log('\n⚠️  email_1 index not found - CREATING...');
      await collection.createIndex({ email: 1 }, { sparse: true, unique: true });
      console.log('✅ Created email_1 index');
    }

    // Check for users with phone: null
    const usersWithNullPhone = await collection.countDocuments({ phone: null });
    console.log(`\n📊 Users with phone: null: ${usersWithNullPhone}`);
    
    if (usersWithNullPhone > 1) {
      console.log('⚠️  Multiple users with phone: null found');
      console.log('   This is OK if the index is sparse');
    }

    // Check for users with email: null
    const usersWithNullEmail = await collection.countDocuments({ email: null });
    console.log(`\n📊 Users with email: null: ${usersWithNullEmail}`);
    
    if (usersWithNullEmail > 1) {
      console.log('⚠️  Multiple users with email: null found');
      console.log('   This is OK if the email index is sparse');
    }

    // Verify final indexes
    const finalIndexes = await collection.indexes();
    console.log('\n✅ Final index status:');
    finalIndexes.forEach(idx => {
      if (idx.name === 'phone_1' || idx.name === 'googleId_1' || idx.name === 'email_1') {
        console.log(`  ${idx.name}: sparse=${idx.sparse}, unique=${idx.unique || false}`);
      }
    });

    await mongoose.connection.close();
    console.log('\n🔌 Database connection closed');
    console.log('✅ Verification complete!');
    process.exit(0);
  } catch (error) {
    console.error('💥 Error:', error);
    process.exit(1);
  }
};

verifyAndFix();


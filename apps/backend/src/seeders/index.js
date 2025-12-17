const mongoose = require('mongoose');
const { connectDatabase } = require('../config/database');
const { seedUsers } = require('./seedUsers');
const { seedMenu } = require('./seedMenu');

const runSeeders = async () => {
  try {
    console.log('🚀 Starting database seeding...');

    // Connect to database
    await connectDatabase();

    // Run all seeders
    const users = await seedUsers();
    const menuItems = await seedMenu();

    console.log('🎉 All seeders completed successfully!');
    console.log(`📊 Summary:`);
    console.log(`   - Users: ${users.length}`);
    console.log(`   - Menu Items: ${menuItems.length}`);

    // Close connection
    await mongoose.connection.close();
    console.log('🔌 Database connection closed');

    process.exit(0);
  } catch (error) {
    console.error('💥 Seeding failed:', error);
    process.exit(1);
  }
};

// Run if called directly
if (require.main === module) {
  runSeeders();
}

module.exports = { runSeeders };

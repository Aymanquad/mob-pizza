const mongoose = require('mongoose');

const connectDatabase = async () => {
  const uri = process.env.MONGO_URI;
  if (!uri) {
    throw new Error('MONGO_URI is required to connect to MongoDB');
  }

  await mongoose.connect(uri, {
    serverSelectionTimeoutMS: 5000,
  });
  // eslint-disable-next-line no-console
  console.log('MongoDB connected');
};

module.exports = { connectDatabase };


// Entry point for the Mob Pizza API (Render-compatible).
require('dotenv').config();
const { startServer } = require('./src/index');

startServer().catch((err) => {
  // eslint-disable-next-line no-console
  console.error('Failed to start server', err);
  process.exit(1);
});


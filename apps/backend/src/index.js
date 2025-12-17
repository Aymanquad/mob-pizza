const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const compression = require('compression');
const rateLimit = require('express-rate-limit');
const { connectDatabase } = require('./config/database');
const onboardingRoutes = require('./routes/onboarding.routes');

const PORT = process.env.PORT || 5000;

const createApp = () => {
  const app = express();
  app.use(helmet());
  app.use(cors());
  app.use(express.json());
  app.use(compression());
  app.use(
    rateLimit({
      windowMs: 15 * 60 * 1000,
      max: 1000,
      standardHeaders: true,
      legacyHeaders: false,
    })
  );
  if (process.env.NODE_ENV !== 'production') {
    app.use(morgan('dev'));
  }

  // Routes
  app.use('/api/v1/onboarding', onboardingRoutes);
  // TODO: wire routes (auth/menu/order/etc.)
  app.get('/health', (_req, res) => {
    res.json({ status: 'ok', service: 'mob-pizza-api' });
  });

  return app;
};

const startServer = async () => {
  await connectDatabase();
  const app = createApp();
  app.listen(PORT, () => {
    // eslint-disable-next-line no-console
    console.log(`API listening on port ${PORT}`);
  });
};

module.exports = { startServer, createApp };


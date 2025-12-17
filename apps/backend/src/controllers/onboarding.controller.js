const bcrypt = require('bcryptjs');
const User = require('../models/User');

// Basic phone regex aligned with model
const phoneRegex = /^\+?[1-9]\d{1,14}$/;

const normalizeLocale = (locale) => {
  if (!locale) return 'en';
  const lower = String(locale).toLowerCase();
  return lower === 'es' ? 'es' : 'en';
};

const onboarding = async (req, res, next) => {
  try {
    const { phone, locale, allowLocation, allowNotifications } = req.body || {};

    // Debug log incoming payload
    // eslint-disable-next-line no-console
    console.log('[onboarding] payload', {
      phone,
      locale,
      allowLocation,
      allowNotifications,
      ts: new Date().toISOString(),
    });

    if (!phone || !phoneRegex.test(phone)) {
      return res.status(400).json({ success: false, message: 'Valid phone is required' });
    }

    const normalizedLocale = normalizeLocale(locale);
    const consents = {
      location: Boolean(allowLocation),
      notifications: Boolean(allowNotifications),
    };

    // Default names for quick onboarding; can be updated later
    const defaultFirst = 'Guest';
    const defaultLast = 'User';
    const randomPassword = `Temp!${Math.random().toString(36).slice(-8)}`;
    const passwordHash = await bcrypt.hash(randomPassword, 12);

    const user = await User.findOneAndUpdate(
      { phone },
      {
        $set: {
          phone,
          phoneVerified: true, // since user confirmed phone entry at onboarding step
          locale: normalizedLocale,
          consents,
          onboardingCompleted: true,
          onboardingAt: new Date(),
        },
        $setOnInsert: {
          firstName: defaultFirst,
          lastName: defaultLast,
          email: `${phone.replace(/\\D/g, '')}@placeholder.local`,
          passwordHash,
          isActive: true,
        },
      },
      { new: true, upsert: true }
    ).select('-passwordHash -__v');

    return res.status(200).json({
      success: true,
      message: 'Onboarding saved',
      data: user,
    });
  } catch (err) {
    // eslint-disable-next-line no-console
    console.error('[onboarding] error', err);
    return next(err);
  }
};

module.exports = { onboarding };


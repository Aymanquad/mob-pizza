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
    const { phone, email, googleId, firstName, lastName, locale, allowLocation, allowNotifications } = req.body || {};

    // Debug log incoming payload
    // eslint-disable-next-line no-console
    console.log('[onboarding] payload', {
      phone,
      email,
      googleId,
      firstName,
      lastName,
      locale,
      allowLocation,
      allowNotifications,
      ts: new Date().toISOString(),
    });

    // Validate: Either phone OR (email + googleId) must be provided
    const isOAuthFlow = Boolean(email && googleId);
    const isPhoneFlow = Boolean(phone && phoneRegex.test(phone));

    // eslint-disable-next-line no-console
    console.log('[onboarding] validation check', {
      isOAuthFlow,
      isPhoneFlow,
      hasEmail: Boolean(email),
      hasGoogleId: Boolean(googleId),
      hasPhone: Boolean(phone),
    });

    if (!isOAuthFlow && !isPhoneFlow) {
      return res.status(400).json({ 
        success: false, 
        message: 'Either phone number OR (email + googleId) is required' 
      });
    }

    const normalizedLocale = normalizeLocale(locale);
    const consents = {
      location: Boolean(allowLocation),
      notifications: Boolean(allowNotifications),
    };

    // Default names for quick onboarding; can be updated later
    const defaultFirst = firstName || 'Guest';
    const defaultLast = lastName || 'User';

    // Build query and update object
    let query = {};
    let updateData = {
      $set: {
        locale: normalizedLocale,
        consents,
        onboardingCompleted: true,
        onboardingAt: new Date(),
      },
      $setOnInsert: {
        firstName: defaultFirst,
        lastName: defaultLast,
        isActive: true,
      },
    };

    if (isOAuthFlow) {
      // OAuth flow: use email + googleId
      query = { googleId };
      updateData.$set.email = email.toLowerCase();
      updateData.$set.googleId = googleId;
      updateData.$set.emailVerified = true;
      if (phone && phoneRegex.test(phone)) {
        updateData.$set.phone = phone;
        updateData.$set.phoneVerified = true;
      }
      // OAuth users don't need passwordHash
    } else {
      // Phone flow: use phone
      query = { phone };
      updateData.$set.phone = phone;
      updateData.$set.phoneVerified = true;
      // Generate password for phone-based users
      const randomPassword = `Temp!${Math.random().toString(36).slice(-8)}`;
      const passwordHash = await bcrypt.hash(randomPassword, 12);
      updateData.$setOnInsert.passwordHash = passwordHash;
    }

    const user = await User.findOneAndUpdate(
      query,
      updateData,
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


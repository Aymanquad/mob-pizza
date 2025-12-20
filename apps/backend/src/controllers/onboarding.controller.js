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
    // For OAuth, ensure email and googleId are non-empty strings
    const hasValidEmail = email && typeof email === 'string' && email.trim().length > 0;
    const hasValidGoogleId = googleId && typeof googleId === 'string' && googleId.trim().length > 0;
    const isOAuthFlow = hasValidEmail && hasValidGoogleId;
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
    // Handle empty strings as well as null/undefined
    const defaultFirst = (firstName && firstName.trim()) || 'Guest';
    const defaultLast = (lastName && lastName.trim()) || 'User';

    // Build query and update object
    let query = {};
    let updateData = {
      $set: {
        locale: normalizedLocale,
        consents,
        onboardingCompleted: true,
        onboardingAt: new Date(),
        // Always set firstName/lastName in $set (for both new and existing users)
        firstName: defaultFirst,
        lastName: defaultLast,
      },
      $setOnInsert: {
        isActive: true,
      },
    };

    if (isOAuthFlow) {
      // OAuth flow: use email + googleId
      query = { googleId: googleId.trim() };
      updateData.$set.email = email.trim().toLowerCase();
      updateData.$set.googleId = googleId.trim();
      updateData.$set.emailVerified = true;
      
      // Only set phone if provided and valid
      // Don't set phone at all if not provided - this avoids duplicate key errors
      // on phone: null when the index isn't properly sparse
      if (phone && phoneRegex.test(phone)) {
        updateData.$set.phone = phone.trim();
        updateData.$set.phoneVerified = true;
      }
      // If phone is not provided, we don't set it at all
      // This way existing users keep their phone (if any), and new users
      // won't have phone field set (not null, just missing)
      // OAuth users don't need passwordHash
    } else {
      // Phone flow: use phone
      query = { phone };
      updateData.$set.phone = phone;
      updateData.$set.phoneVerified = true;
      // Generate password for phone-based users (only on insert)
      const randomPassword = `Temp!${Math.random().toString(36).slice(-8)}`;
      const passwordHash = await bcrypt.hash(randomPassword, 12);
      updateData.$setOnInsert.passwordHash = passwordHash;
    }

    const user = await User.findOneAndUpdate(
      query,
      updateData,
      { new: true, upsert: true, runValidators: true }
    ).select('-passwordHash -__v');

    return res.status(200).json({
      success: true,
      message: 'Onboarding saved',
      data: user,
    });
  } catch (err) {
    // eslint-disable-next-line no-console
    console.error('[onboarding] error', err);
    
    // Return more detailed error for debugging
    if (err.name === 'ValidationError') {
      return res.status(400).json({
        success: false,
        message: 'Validation error',
        error: err.message,
        details: err.errors,
      });
    }
    
    return next(err);
  }
};

module.exports = { onboarding };


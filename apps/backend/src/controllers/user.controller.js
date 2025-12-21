const User = require('../models/User');

/**
 * Get user profile by phone, email, or googleId
 * Supports: /users/:identifier where identifier can be phone, email, or googleId
 */
exports.getProfile = async (req, res) => {
  try {
    const { phone } = req.params; // Actually can be phone, email, or googleId
    // eslint-disable-next-line no-console
    console.log('[user] fetching profile for identifier:', phone);

    // Try to find user by phone, email, or googleId
    let user = await User.findOne({ phone });
    
    // If not found by phone, try email or googleId
    if (!user) {
      // Check if it looks like an email
      if (phone.includes('@')) {
        user = await User.findOne({ email: phone.toLowerCase() });
      } else {
        // Try as googleId
        user = await User.findOne({ googleId: phone });
      }
    }
    
    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'User not found'
      });
    }

    return res.status(200).json({
      success: true,
      data: user
    });
  } catch (error) {
    // eslint-disable-next-line no-console
    console.error('[user] error fetching profile:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to fetch profile',
      error: error.message
    });
  }
};

/**
 * Update user profile by phone, email, or googleId
 */
exports.updateProfile = async (req, res) => {
  try {
    const { phone } = req.params; // Actually can be phone, email, or googleId
    const updates = req.body;

    // eslint-disable-next-line no-console
    console.log('[user] updating profile for identifier:', phone, 'with:', updates);

    // Validate allowed fields
    const allowedUpdates = ['firstName', 'lastName', 'locale', 'addresses'];
    const updateKeys = Object.keys(updates);
    const isValidOperation = updateKeys.every(key => allowedUpdates.includes(key));

    if (!isValidOperation) {
      return res.status(400).json({
        success: false,
        message: 'Invalid updates. Allowed fields: firstName, lastName, locale, addresses'
      });
    }

    // Build query - try email first (if contains @), then phone, then googleId
    let query = {};
    let existingUser = null;
    
    // Check if identifier is an email
    if (phone.includes('@')) {
      query = { email: phone.toLowerCase() };
      existingUser = await User.findOne(query);
    }
    
    // If not found and not an email, try phone
    if (!existingUser && !phone.includes('@')) {
      query = { phone };
      existingUser = await User.findOne(query);
    }
    
    // If still not found, try googleId (for long numeric strings)
    if (!existingUser && phone.length > 15 && /^\d+$/.test(phone)) {
      query = { googleId: phone };
      existingUser = await User.findOne(query);
    }
    
    // If still not found, return 404
    if (!existingUser) {
      return res.status(404).json({
        success: false,
        message: 'User not found'
      });
    }

    // Handle addresses update - if addresses array is provided, replace the entire array
    // Otherwise, just update other fields
    const updateQuery = {};
    if (updates.addresses && Array.isArray(updates.addresses)) {
      // Replace addresses array
      updateQuery.$set = {
        firstName: updates.firstName,
        lastName: updates.lastName,
        locale: updates.locale,
        addresses: updates.addresses,
      };
    } else {
      // Just update other fields
      updateQuery.$set = {};
      if (updates.firstName) updateQuery.$set.firstName = updates.firstName;
      if (updates.lastName) updateQuery.$set.lastName = updates.lastName;
      if (updates.locale) updateQuery.$set.locale = updates.locale;
    }

    const user = await User.findOneAndUpdate(
      query,
      updateQuery,
      { new: true, runValidators: true }
    );

    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'User not found'
      });
    }

    // eslint-disable-next-line no-console
    console.log('[user] profile updated successfully');

    return res.status(200).json({
      success: true,
      message: 'Profile updated',
      data: user
    });
  } catch (error) {
    // eslint-disable-next-line no-console
    console.error('[user] error updating profile:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to update profile',
      error: error.message
    });
  }
};


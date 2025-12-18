const User = require('../models/User');

/**
 * Get user profile by phone
 */
exports.getProfile = async (req, res) => {
  try {
    const { phone } = req.params;
    // eslint-disable-next-line no-console
    console.log('[user] fetching profile for phone:', phone);

    const user = await User.findOne({ phone });
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
 * Update user profile
 */
exports.updateProfile = async (req, res) => {
  try {
    const { phone } = req.params;
    const updates = req.body;

    // eslint-disable-next-line no-console
    console.log('[user] updating profile for phone:', phone, 'with:', updates);

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
      { phone },
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


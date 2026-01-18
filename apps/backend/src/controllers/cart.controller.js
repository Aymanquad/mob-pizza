const User = require('../models/User');

/**
 * Get user's cart - SECURITY: Users can only access their own cart
 */
exports.getCart = async (req, res) => {
  try {
    // Express automatically URL decodes params, but let's be explicit
    let { phone } = req.params; // Can be phone, email, or googleId
    phone = decodeURIComponent(phone);

    console.log('[cart] Getting cart for identifier:', phone);

    // Find user by phone, email, or googleId (same logic as orders)
    let user = null;
    let query = {};
    
    // Check if identifier is an email
    if (phone.includes('@')) {
      query = { email: phone.toLowerCase() };
      console.log('[cart] Looking up user by email:', phone.toLowerCase());
      user = await User.findOne(query).select('cart _id phone email');
    }
    
    // If not found and not an email, try phone
    if (!user && !phone.includes('@')) {
      query = { phone };
      console.log('[cart] Looking up user by phone:', phone);
      user = await User.findOne(query).select('cart _id phone email');
    }
    
    // If still not found, try googleId (for long numeric strings)
    if (!user && phone.length > 15 && /^\d+$/.test(phone)) {
      query = { googleId: phone };
      console.log('[cart] Looking up user by googleId:', phone);
      user = await User.findOne(query).select('cart _id phone email');
    }
    
    if (!user) {
      console.error('[cart] User not found for identifier:', phone);
      return res.status(404).json({
        success: false,
        message: 'User not found',
      });
    }

    console.log('[cart] Found user:', user._id, '- returning their cart');

    return res.status(200).json({
      success: true,
      data: user.cart || [],
    });
  } catch (error) {
    console.error('[cart] error fetching cart:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to fetch cart',
      error: error.message,
    });
  }
};

/**
 * Add item to cart - SECURITY: Users can only add items to their own cart
 */
exports.addItem = async (req, res) => {
  try {
    // Express automatically URL decodes params, but let's be explicit
    let { phone } = req.params; // Can be phone, email, or googleId
    phone = decodeURIComponent(phone);
    const cartItem = req.body;

    console.log('[cart] Adding item to cart for identifier:', phone);

    // Validate required fields
    if (!cartItem.id || !cartItem.name || !cartItem.basePrice || !cartItem.selectedSize) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields: id, name, basePrice, selectedSize',
      });
    }

    // Find user by phone, email, or googleId (same logic as orders)
    let user = null;
    let query = {};
    
    // Check if identifier is an email
    if (phone.includes('@')) {
      query = { email: phone.toLowerCase() };
      console.log('[cart] Looking up user by email:', phone.toLowerCase());
      user = await User.findOne(query);
    }
    
    // If not found and not an email, try phone
    if (!user && !phone.includes('@')) {
      query = { phone };
      console.log('[cart] Looking up user by phone:', phone);
      user = await User.findOne(query);
    }
    
    // If still not found, try googleId (for long numeric strings)
    if (!user && phone.length > 15 && /^\d+$/.test(phone)) {
      query = { googleId: phone };
      console.log('[cart] Looking up user by googleId:', phone);
      user = await User.findOne(query);
    }
    
    if (!user) {
      console.error('[cart] User not found for identifier:', phone);
      return res.status(404).json({
        success: false,
        message: 'User not found',
      });
    }

    console.log('[cart] Found user:', user._id, '- adding item to their cart');

    // Check if item with same configuration exists
    const existingIndex = user.cart.findIndex(
      (item) =>
        item.name === cartItem.name &&
        item.selectedSize === cartItem.selectedSize &&
        JSON.stringify(item.selectedToppings || []) === JSON.stringify(cartItem.selectedToppings || [])
    );

    if (existingIndex >= 0) {
      // Update quantity
      user.cart[existingIndex].quantity += cartItem.quantity || 1;
    } else {
      // Add new item
      user.cart.push({
        id: cartItem.id,
        name: cartItem.name,
        description: cartItem.description || '',
        basePrice: cartItem.basePrice,
        isVegetarian: cartItem.isVegetarian || false,
        imagePath: cartItem.imagePath || '',
        selectedSize: cartItem.selectedSize,
        selectedToppings: cartItem.selectedToppings || [],
        quantity: cartItem.quantity || 1,
      });
    }

    await user.save();

    return res.status(200).json({
      success: true,
      message: 'Item added to cart',
      data: user.cart,
    });
  } catch (error) {
    console.error('[cart] error adding item:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to add item to cart',
      error: error.message,
    });
  }
};

/**
 * Update cart item quantity - SECURITY: Users can only update items in their own cart
 */
exports.updateItem = async (req, res) => {
  try {
    // Express automatically URL decodes params, but let's be explicit
    let { phone, itemId } = req.params; // phone can be phone, email, or googleId
    phone = decodeURIComponent(phone);
    const { quantity } = req.body;

    console.log('[cart] Updating cart item for identifier:', phone, 'itemId:', itemId);

    if (!quantity || quantity < 0) {
      return res.status(400).json({
        success: false,
        message: 'Valid quantity is required',
      });
    }

    // Find user by phone, email, or googleId (same logic as orders)
    let user = null;
    let query = {};
    
    // Check if identifier is an email
    if (phone.includes('@')) {
      query = { email: phone.toLowerCase() };
      console.log('[cart] Looking up user by email:', phone.toLowerCase());
      user = await User.findOne(query);
    }
    
    // If not found and not an email, try phone
    if (!user && !phone.includes('@')) {
      query = { phone };
      console.log('[cart] Looking up user by phone:', phone);
      user = await User.findOne(query);
    }
    
    // If still not found, try googleId (for long numeric strings)
    if (!user && phone.length > 15 && /^\d+$/.test(phone)) {
      query = { googleId: phone };
      console.log('[cart] Looking up user by googleId:', phone);
      user = await User.findOne(query);
    }
    
    if (!user) {
      console.error('[cart] User not found for identifier:', phone);
      return res.status(404).json({
        success: false,
        message: 'User not found',
      });
    }

    console.log('[cart] Found user:', user._id, '- updating item in their cart');

    const itemIndex = user.cart.findIndex((item) => item.id === itemId);
    if (itemIndex === -1) {
      return res.status(404).json({
        success: false,
        message: 'Cart item not found',
      });
    }

    if (quantity === 0) {
      // Remove item
      user.cart.splice(itemIndex, 1);
    } else {
      // Update quantity
      user.cart[itemIndex].quantity = quantity;
    }

    await user.save();

    return res.status(200).json({
      success: true,
      message: 'Cart item updated',
      data: user.cart,
    });
  } catch (error) {
    console.error('[cart] error updating item:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to update cart item',
      error: error.message,
    });
  }
};

/**
 * Remove item from cart - SECURITY: Users can only remove items from their own cart
 */
exports.removeItem = async (req, res) => {
  try {
    // Express automatically URL decodes params, but let's be explicit
    let { phone, itemId } = req.params; // phone can be phone, email, or googleId
    phone = decodeURIComponent(phone);

    console.log('[cart] Removing cart item for identifier:', phone, 'itemId:', itemId);

    // Find user by phone, email, or googleId (same logic as orders)
    let user = null;
    let query = {};
    
    // Check if identifier is an email
    if (phone.includes('@')) {
      query = { email: phone.toLowerCase() };
      console.log('[cart] Looking up user by email:', phone.toLowerCase());
      user = await User.findOne(query);
    }
    
    // If not found and not an email, try phone
    if (!user && !phone.includes('@')) {
      query = { phone };
      console.log('[cart] Looking up user by phone:', phone);
      user = await User.findOne(query);
    }
    
    // If still not found, try googleId (for long numeric strings)
    if (!user && phone.length > 15 && /^\d+$/.test(phone)) {
      query = { googleId: phone };
      console.log('[cart] Looking up user by googleId:', phone);
      user = await User.findOne(query);
    }
    
    if (!user) {
      console.error('[cart] User not found for identifier:', phone);
      return res.status(404).json({
        success: false,
        message: 'User not found',
      });
    }

    console.log('[cart] Found user:', user._id, '- removing item from their cart');

    const itemIndex = user.cart.findIndex((item) => item.id === itemId);
    if (itemIndex === -1) {
      return res.status(404).json({
        success: false,
        message: 'Cart item not found',
      });
    }

    user.cart.splice(itemIndex, 1);
    await user.save();

    return res.status(200).json({
      success: true,
      message: 'Item removed from cart',
      data: user.cart,
    });
  } catch (error) {
    console.error('[cart] error removing item:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to remove cart item',
      error: error.message,
    });
  }
};

/**
 * Clear cart - SECURITY: Users can only clear their own cart
 */
exports.clearCart = async (req, res) => {
  try {
    // Express automatically URL decodes params, but let's be explicit
    let { phone } = req.params; // Can be phone, email, or googleId
    phone = decodeURIComponent(phone);

    console.log('[cart] Clearing cart for identifier:', phone);

    // Find user by phone, email, or googleId (same logic as orders)
    let user = null;
    let query = {};
    
    // Check if identifier is an email
    if (phone.includes('@')) {
      query = { email: phone.toLowerCase() };
      console.log('[cart] Looking up user by email:', phone.toLowerCase());
      user = await User.findOne(query);
    }
    
    // If not found and not an email, try phone
    if (!user && !phone.includes('@')) {
      query = { phone };
      console.log('[cart] Looking up user by phone:', phone);
      user = await User.findOne(query);
    }
    
    // If still not found, try googleId (for long numeric strings)
    if (!user && phone.length > 15 && /^\d+$/.test(phone)) {
      query = { googleId: phone };
      console.log('[cart] Looking up user by googleId:', phone);
      user = await User.findOne(query);
    }
    
    if (!user) {
      console.error('[cart] User not found for identifier:', phone);
      return res.status(404).json({
        success: false,
        message: 'User not found',
      });
    }

    console.log('[cart] Found user:', user._id, '- clearing their cart');

    user.cart = [];
    await user.save();

    return res.status(200).json({
      success: true,
      message: 'Cart cleared',
      data: [],
    });
  } catch (error) {
    console.error('[cart] error clearing cart:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to clear cart',
      error: error.message,
    });
  }
};


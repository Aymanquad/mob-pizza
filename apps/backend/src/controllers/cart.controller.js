const User = require('../models/User');

/**
 * Get user's cart
 */
exports.getCart = async (req, res) => {
  try {
    const { phone } = req.params;

    const user = await User.findOne({ phone }).select('cart');
    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'User not found',
      });
    }

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
 * Add item to cart
 */
exports.addItem = async (req, res) => {
  try {
    const { phone } = req.params;
    const cartItem = req.body;

    // Validate required fields
    if (!cartItem.id || !cartItem.name || !cartItem.basePrice || !cartItem.selectedSize) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields: id, name, basePrice, selectedSize',
      });
    }

    const user = await User.findOne({ phone });
    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'User not found',
      });
    }

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
 * Update cart item quantity
 */
exports.updateItem = async (req, res) => {
  try {
    const { phone, itemId } = req.params;
    const { quantity } = req.body;

    if (!quantity || quantity < 0) {
      return res.status(400).json({
        success: false,
        message: 'Valid quantity is required',
      });
    }

    const user = await User.findOne({ phone });
    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'User not found',
      });
    }

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
 * Remove item from cart
 */
exports.removeItem = async (req, res) => {
  try {
    const { phone, itemId } = req.params;

    const user = await User.findOne({ phone });
    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'User not found',
      });
    }

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
 * Clear cart
 */
exports.clearCart = async (req, res) => {
  try {
    const { phone } = req.params;

    const user = await User.findOne({ phone });
    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'User not found',
      });
    }

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


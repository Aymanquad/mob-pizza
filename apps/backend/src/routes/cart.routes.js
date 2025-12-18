const express = require('express');
const cartController = require('../controllers/cart.controller');

const router = express.Router();

// GET /api/v1/cart/:phone - Get user's cart
router.get('/:phone', cartController.getCart);

// POST /api/v1/cart/:phone - Add item to cart
router.post('/:phone', cartController.addItem);

// PUT /api/v1/cart/:phone/:itemId - Update cart item quantity
router.put('/:phone/:itemId', cartController.updateItem);

// DELETE /api/v1/cart/:phone/:itemId - Remove item from cart
router.delete('/:phone/:itemId', cartController.removeItem);

// DELETE /api/v1/cart/:phone - Clear cart
router.delete('/:phone', cartController.clearCart);

module.exports = router;


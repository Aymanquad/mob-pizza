const express = require('express');
const orderController = require('../controllers/order.controller');

const router = express.Router();

// POST /api/v1/orders/:phone - Create new order
router.post('/:phone', orderController.createOrder);

// GET /api/v1/orders/:phone - Get user's orders
router.get('/:phone', orderController.getOrders);

// GET /api/v1/orders/:phone/:orderId - Get single order
router.get('/:phone/:orderId', orderController.getOrder);

// PUT /api/v1/orders/:phone/:orderId/status - Update order status
router.put('/:phone/:orderId/status', orderController.updateOrderStatus);

module.exports = router;


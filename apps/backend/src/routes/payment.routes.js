const express = require('express');
const paymentController = require('../controllers/payment.controller');

const router = express.Router();

// POST /api/v1/payment/stripe/create-intent - Create Stripe payment intent
router.post('/stripe/create-intent', paymentController.createPaymentIntent);

// POST /api/v1/payment/stripe/confirm - Confirm Stripe payment
router.post('/stripe/confirm', paymentController.confirmPayment);

module.exports = router;


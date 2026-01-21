const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
const Order = require('../models/Order');

/**
 * Create Stripe payment intent
 */
exports.createPaymentIntent = async (req, res) => {
  try {
    const { orderId, amount, currency = 'usd' } = req.body;

    if (!orderId || !amount) {
      return res.status(400).json({
        success: false,
        message: 'Order ID and amount are required',
      });
    }

    // Verify order exists
    const order = await Order.findById(orderId);
    if (!order) {
      return res.status(404).json({
        success: false,
        message: 'Order not found',
      });
    }

    // Verify order amount matches
    const amountInCents = Math.round(amount);
    const orderAmountInCents = Math.round(order.totalAmount * 100);
    
    if (amountInCents !== orderAmountInCents) {
      console.warn(`[payment] Amount mismatch: requested ${amountInCents}, order ${orderAmountInCents}`);
    }

    // Create payment intent
    const paymentIntent = await stripe.paymentIntents.create({
      amount: amountInCents,
      currency: currency.toLowerCase(),
      metadata: {
        orderId: orderId.toString(),
        orderNumber: order.orderId || orderId.toString(),
      },
      automatic_payment_methods: {
        enabled: true,
      },
    });

    console.log(`[payment] Created payment intent ${paymentIntent.id} for order ${orderId}`);

    return res.status(200).json({
      success: true,
      data: {
        clientSecret: paymentIntent.client_secret,
        paymentIntentId: paymentIntent.id,
        publishableKey: process.env.STRIPE_PUBLISHABLE_KEY,
      },
    });
  } catch (error) {
    console.error('[payment] Error creating payment intent:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to create payment intent',
      error: error.message,
    });
  }
};

/**
 * Confirm Stripe payment and update order
 */
exports.confirmPayment = async (req, res) => {
  try {
    const { orderId, paymentIntentId, paymentMethodId } = req.body;

    if (!orderId || !paymentIntentId) {
      return res.status(400).json({
        success: false,
        message: 'Order ID and payment intent ID are required',
      });
    }

    // Verify payment intent
    const paymentIntent = await stripe.paymentIntents.retrieve(paymentIntentId);

    if (paymentIntent.status !== 'succeeded') {
      return res.status(400).json({
        success: false,
        message: `Payment not succeeded. Status: ${paymentIntent.status}`,
      });
    }

    // Find and update order
    const order = await Order.findById(orderId);
    if (!order) {
      return res.status(404).json({
        success: false,
        message: 'Order not found',
      });
    }

    // Update order payment status
    order.paymentStatus = 'completed';
    order.paymentMethod = 'stripe';
    await order.save();

    console.log(`[payment] Payment confirmed for order ${orderId}, payment intent ${paymentIntentId}`);

    // Populate order for response
    await order.populate('customer', 'firstName lastName phone');

    return res.status(200).json({
      success: true,
      message: 'Payment confirmed successfully',
      data: {
        order: order,
        paymentIntentId: paymentIntentId,
        paymentStatus: 'completed',
      },
    });
  } catch (error) {
    console.error('[payment] Error confirming payment:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to confirm payment',
      error: error.message,
    });
  }
};


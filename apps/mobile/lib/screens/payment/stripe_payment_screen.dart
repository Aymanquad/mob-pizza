import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';
import 'package:mob_pizza_mobile/providers/cart_provider.dart';
import 'package:mob_pizza_mobile/providers/order_provider.dart';
import 'package:mob_pizza_mobile/services/stripe_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class StripePaymentScreen extends StatefulWidget {
  final String orderId;
  final double amount;
  final String currency;

  const StripePaymentScreen({
    super.key,
    required this.orderId,
    required this.amount,
    this.currency = 'USD',
  });

  @override
  State<StripePaymentScreen> createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvcController = TextEditingController();
  final _cardHolderNameController = TextEditingController();

  bool _isProcessing = false;
  String? _errorMessage;
  final StripeService _stripeService = StripeService();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvcController.dispose();
    _cardHolderNameController.dispose();
    super.dispose();
  }

  Future<void> _processPayment() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isProcessing = true;
      _errorMessage = null;
    });

    try {
      // Create payment intent on backend
      final paymentIntentData = await _stripeService.createPaymentIntent(
        orderId: widget.orderId,
        amount: widget.amount,
        currency: widget.currency,
      );

      final clientSecret = paymentIntentData['clientSecret'] as String;
      final publishableKey = paymentIntentData['publishableKey'] as String;

      // Initialize Stripe with publishable key
      Stripe.publishableKey = publishableKey;
      await Stripe.instance.applySettings();

      // Parse card details for validation
      final expiryParts = _expiryDateController.text.split('/');
      if (expiryParts.length != 2) {
        throw Exception('Invalid expiry date format');
      }

      // Create payment method using card details
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(
              name: _cardHolderNameController.text,
            ),
          ),
        ),
      );

      // Confirm payment with the payment method
      await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: clientSecret,
        data: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(
              name: _cardHolderNameController.text,
            ),
          ),
        ),
      );

      // Confirm payment on backend
      await _stripeService.confirmPayment(
        orderId: widget.orderId,
        paymentIntentId: paymentIntentData['paymentIntentId'] as String,
        paymentMethodId: paymentMethod.id,
      );

      // Only after successful payment: clear cart and refresh orders
      if (mounted) {
        final cartProvider = Provider.of<CartProvider>(context, listen: false);
        final orderProvider = Provider.of<OrderProvider>(context, listen: false);
        await cartProvider.clearCart();
        await orderProvider.loadOrders(forceReload: true);
      }

      // Show success dialog
      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      debugPrint('[stripe_payment] Payment error: $e');
      setState(() {
        _isProcessing = false;
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });

      // Show failure dialog
      if (mounted) {
        _showFailureDialog(e.toString());
      }
    }
  }

  void _showSuccessDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0F0F0F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFC6A667), width: 2),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF00E676),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.check, color: Colors.black, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                l10n.paymentSuccessful,
                style: GoogleFonts.cinzel(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFFF8E1),
                ),
              ),
            ),
          ],
        ),
        content: Text(
          l10n.paymentCompletedSuccessfully,
          style: const TextStyle(
            color: Color(0xFFD4AF7A),
            fontSize: 14,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/orders');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC6A667),
              foregroundColor: const Color(0xFF0F0F0F),
            ),
            child: Text(
              l10n.viewOrders,
              style: GoogleFonts.cinzel(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFailureDialog(String error) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0F0F0F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.red, width: 2),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.error, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                l10n.paymentFailed,
                style: GoogleFonts.cinzel(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFFF8E1),
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.paymentCouldNotBeProcessed,
              style: const TextStyle(
                color: Color(0xFFD4AF7A),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.replaceAll('Exception: ', ''),
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _isProcessing = false;
              });
            },
            child: Text(
              l10n.tryAgain,
              style: GoogleFonts.cinzel(
                fontWeight: FontWeight.w600,
                color: const Color(0xFFC6A667),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.pop(); // Go back to checkout
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC6A667),
              foregroundColor: const Color(0xFF0F0F0F),
            ),
            child: Text(
              l10n.backToCheckout,
              style: GoogleFonts.cinzel(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatCardNumber(String value) {
    // Remove all non-digits
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    
    // Add spaces every 4 digits
    final buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(digitsOnly[i]);
    }
    return buffer.toString();
  }

  String _formatExpiryDate(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length >= 2) {
      return '${digitsOnly.substring(0, 2)}/${digitsOnly.length > 2 ? digitsOnly.substring(2, 4) : ''}';
    }
    return digitsOnly;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1C1512),
        appBar: AppBar(
          title: Text(
            l10n.payment,
            style: GoogleFonts.cinzel(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              letterSpacing: 1.2,
              color: const Color(0xFFFFF8E1),
            ),
          ),
          backgroundColor: const Color(0xFF1C1512),
          foregroundColor: const Color(0xFFF5E8C7),
          elevation: 2,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Summary
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F0F0F),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF878787), width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.orderTotal,
                            style: GoogleFonts.cinzel(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFD4AF7A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${widget.amount.toStringAsFixed(2)}',
                            style: GoogleFonts.cinzel(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFFC6A667),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC6A667).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFC6A667), width: 1),
                        ),
                        child: const Icon(
                          Icons.credit_card,
                          color: Color(0xFFC6A667),
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Card Holder Name
                Text(
                  l10n.cardHolderName,
                  style: GoogleFonts.cinzel(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFD4AF7A),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _cardHolderNameController,
                  style: const TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    fillColor: const Color(0xFFFFF8E1),
                    filled: true,
                    hintText: l10n.enterCardHolderName,
                    hintStyle: const TextStyle(color: Color(0xFF878787)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF878787)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFC6A667)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.pleaseEnterCardHolderName;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Card Number
                Text(
                  l10n.cardNumber,
                  style: GoogleFonts.cinzel(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFD4AF7A),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _cardNumberController,
                  style: const TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.w600),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: const Color(0xFFFFF8E1),
                    filled: true,
                    hintText: '1234 5678 9012 3456',
                    hintStyle: const TextStyle(color: Color(0xFF878787)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF878787)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFC6A667)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.credit_card, color: Color(0xFF878787)),
                  ),
                  onChanged: (value) {
                    final formatted = _formatCardNumber(value);
                    if (formatted != value) {
                      _cardNumberController.value = TextEditingValue(
                        text: formatted,
                        selection: TextSelection.collapsed(offset: formatted.length),
                      );
                    }
                  },
                  validator: (value) {
                    final digitsOnly = value?.replaceAll(' ', '') ?? '';
                    if (digitsOnly.isEmpty) {
                      return l10n.pleaseEnterCardNumber;
                    }
                    if (digitsOnly.length < 13 || digitsOnly.length > 19) {
                      return l10n.invalidCardNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Expiry Date and CVC
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.expiryDate,
                            style: GoogleFonts.cinzel(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFD4AF7A),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _expiryDateController,
                            style: const TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.w600),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              fillColor: const Color(0xFFFFF8E1),
                              filled: true,
                              hintText: 'MM/YY',
                              hintStyle: const TextStyle(color: Color(0xFF878787)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFF878787)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFFC6A667)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: (value) {
                              final formatted = _formatExpiryDate(value);
                              if (formatted != value) {
                                _expiryDateController.value = TextEditingValue(
                                  text: formatted,
                                  selection: TextSelection.collapsed(offset: formatted.length),
                                );
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.pleaseEnterExpiryDate;
                              }
                              final parts = value.split('/');
                              if (parts.length != 2) {
                                return l10n.invalidExpiryDate;
                              }
                              final month = int.tryParse(parts[0]);
                              final year = int.tryParse(parts[1]);
                              if (month == null || year == null || month < 1 || month > 12) {
                                return l10n.invalidExpiryDate;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.cvc,
                            style: GoogleFonts.cinzel(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFD4AF7A),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _cvcController,
                            style: const TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.w600),
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            maxLength: 4,
                            decoration: InputDecoration(
                              fillColor: const Color(0xFFFFF8E1),
                              filled: true,
                              hintText: '123',
                              hintStyle: const TextStyle(color: Color(0xFF878787)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFF878787)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFFC6A667)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.pleaseEnterCvc;
                              }
                              if (value.length < 3) {
                                return l10n.invalidCvc;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Error Message
                if (_errorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red, width: 1),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),

                // Pay Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isProcessing ? null : _processPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC6A667),
                      foregroundColor: const Color(0xFF0F0F0F),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBackgroundColor: const Color(0xFF878787),
                    ),
                    child: _isProcessing
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0F0F0F)),
                            ),
                          )
                        : Text(
                            l10n.payNow,
                            style: GoogleFonts.cinzel(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


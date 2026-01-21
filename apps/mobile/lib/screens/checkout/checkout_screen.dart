import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:mob_pizza_mobile/providers/cart_provider.dart';
import 'package:mob_pizza_mobile/providers/order_provider.dart';
import 'package:mob_pizza_mobile/models/order.dart';
import 'package:mob_pizza_mobile/config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mob_pizza_mobile/services/user_service.dart';
import 'package:mob_pizza_mobile/services/auth_service.dart';
import 'package:mob_pizza_mobile/services/order_service.dart';
import 'package:flutter/foundation.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  
  String _paymentMethod = 'cash_on_delivery';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString(PrefKeys.firstName) ?? '';
    final lastName = prefs.getString(PrefKeys.lastName) ?? '';
    final phone = prefs.getString(PrefKeys.phone) ?? '';
    final address = prefs.getString(PrefKeys.address) ?? '';

    setState(() {
      _nameController.text = '$firstName $lastName'.trim();
      _phoneController.text = phone;
      _addressController.text = address;
    });
  }

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    final l10n = AppLocalizations.of(context)!;
    if (cartProvider.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.yourCartIsEmpty),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validate address is not empty
    if (_addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.deliveryAddressRequired),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Save updated address and name to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final nameParts = _nameController.text.trim().split(' ');
      if (nameParts.isNotEmpty) {
        await prefs.setString(PrefKeys.firstName, nameParts.first);
        if (nameParts.length > 1) {
          await prefs.setString(PrefKeys.lastName, nameParts.sublist(1).join(' '));
        }
      }
      await prefs.setString(PrefKeys.address, _addressController.text.trim());
      
      // Get identifier BEFORE saving phone to SharedPreferences
      // This ensures we use email for OAuth users, not the new phone number
      final originalIdentifier = await AuthService.getUserIdentifier();
      if (originalIdentifier.isEmpty) {
        throw Exception('User not found. Please complete onboarding first.');
      }
      
      // If phone number is entered, save it to backend profile FIRST
      final phoneNumber = _phoneController.text.trim();
      if (phoneNumber.isNotEmpty) {
        // Update backend profile with phone number BEFORE saving to SharedPreferences
        // This ensures the phone is in the database before we use it as identifier
        try {
          final userService = UserService();
          // Use original identifier (email for OAuth users) to update profile
          await userService.updateProfile(originalIdentifier, {
            'phone': phoneNumber,
            'phoneVerified': true,
          });
          debugPrint('[checkout] Updated backend profile with phone number: $phoneNumber');
          
          // Only save to SharedPreferences AFTER backend update succeeds
          await prefs.setString(PrefKeys.phone, phoneNumber);
        } catch (e) {
          // If profile update fails, still save phone locally but log the error
          debugPrint('[checkout] Error updating profile with phone: $e');
          await prefs.setString(PrefKeys.phone, phoneNumber);
          // Continue anyway - we'll use original identifier for order creation
        }
      }

      // If Stripe payment, create order on backend first, then navigate to payment
      if (_paymentMethod == 'stripe') {
        try {
          // Save total price before clearing cart
          final totalPrice = cartProvider.totalPrice;
          
          final orderService = OrderService();
          final orderData = await orderService.createOrder(
            originalIdentifier,
            items: cartProvider.items,
            customerName: _nameController.text.trim(),
            phoneNumber: phoneNumber,
            deliveryAddress: _addressController.text.trim(),
            paymentMethod: 'stripe',
            totalPrice: totalPrice,
            deliveryCharges: 0,
            tax: totalPrice * 0.1,
            discount: 0,
            estimatedDelivery: DateTime.now().add(const Duration(minutes: 30)),
          );

          final backendOrderId = orderData['_id']?.toString() ?? orderData['id']?.toString() ?? '';
          // Use the backend-calculated totalAmount to ensure consistency
          final orderTotalAmount = (orderData['totalAmount'] as num?)?.toDouble() ?? totalPrice;

          if (backendOrderId.isEmpty) {
            throw Exception('Failed to get order ID from backend');
          }

          // Clear cart before navigating to payment
          await cartProvider.clearCart();

          // Navigate to Stripe payment screen with backend-calculated amount
          if (mounted) {
            context.go(
              '/payment/stripe?orderId=$backendOrderId&amount=$orderTotalAmount&currency=USD',
            );
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to create order: ${e.toString()}'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 5),
              ),
            );
          }
          setState(() => _isLoading = false);
          return;
        }
        return; // Exit early for Stripe payment
      }

      // For cash on delivery, proceed with existing flow
      // Generate order number
      final orderNumber = 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
      final orderId = DateTime.now().millisecondsSinceEpoch.toString();

      // Create order
      final order = Order(
        id: orderId,
        orderNumber: orderNumber,
        items: cartProvider.items,
        customerName: _nameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        deliveryAddress: _addressController.text.trim(),
        paymentMethod: _paymentMethod,
        totalPrice: cartProvider.totalPrice,
        status: OrderStatus.confirmed,
        createdAt: DateTime.now(),
        estimatedDelivery: DateTime.now().add(const Duration(minutes: 30)),
      );

      // Save order
      try {
        await orderProvider.addOrder(order);
      } catch (e) {
        // If order creation fails, show error and don't clear cart
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to create order: ${e.toString()}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
            ),
          );
        }
        setState(() => _isLoading = false);
        return; // Don't proceed if order creation failed
      }

      // Clear cart only if order was created successfully
      await cartProvider.clearCart();

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E676),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.check, color: Colors.black, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.orderPlacedSuccessfully,
                          style: GoogleFonts.cinzel(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: const Color(0xFFFFF8E1),
                          ),
                        ),
                        Text(
                          '${l10n.orderNumber}$orderNumber',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFD4AF7A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: const Color(0xFF1C1512),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFC6A667), width: 1.5),
            ),
            duration: const Duration(seconds: 3),
            margin: const EdgeInsets.all(16),
          ),
        );

        // Navigate to orders page
        context.go('/orders');
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.errorPlacingOrder} $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cartProvider = Provider.of<CartProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1C1512),
        appBar: AppBar(
          title: Text(
            l10n.checkout,
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
        body: cartProvider.items.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      size: 64,
                      color: Color(0xFF878787),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.yourCartIsEmpty,
                      style: GoogleFonts.cinzel(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFF5E8C7),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC6A667),
                        foregroundColor: const Color(0xFF0F0F0F),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                      onPressed: () => context.go('/menu'),
                      child: Text(
                        l10n.browseMenu,
                        style: GoogleFonts.cinzel(
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
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
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0x33),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.orderSummary,
                              style: GoogleFonts.cinzel(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFFD4AF7A),
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...cartProvider.items.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${item.quantity}x ${item.name}',
                                          style: const TextStyle(
                                            color: Color(0xFFFFF8E1),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '${item.selectedSize}',
                                          style: const TextStyle(
                                            color: Color(0xFF878787),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '\$${item.totalPrice.toStringAsFixed(2)}',
                                    style: GoogleFonts.cinzel(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFFC6A667),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            const Divider(color: Color(0xFF878787), height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  l10n.total.toUpperCase(),
                                  style: GoogleFonts.cinzel(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFFD4AF7A),
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                Text(
                                  '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFFC6A667),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Contact Information
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F0F0F),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF878787), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0x33),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.contactInformation,
                              style: GoogleFonts.cinzel(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFD4AF7A),
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _nameController,
                              style: const TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                fillColor: const Color(0xFFFFF8E1),
                                filled: true,
                                labelText: l10n.fullName,
                                labelStyle: const TextStyle(color: Color(0xFF878787)),
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
                                  return l10n.pleaseEnterName;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _phoneController,
                              style: const TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.w600),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                fillColor: const Color(0xFFFFF8E1),
                                filled: true,
                                labelText: l10n.phoneNumber,
                                labelStyle: const TextStyle(color: Color(0xFF878787)),
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
                                  return l10n.pleaseEnterPhone;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Delivery Address
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F0F0F),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF878787), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0x33),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.dropLocation,
                              style: GoogleFonts.cinzel(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFD4AF7A),
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _addressController,
                              style: const TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.w600),
                              maxLines: 3,
                              decoration: InputDecoration(
                                fillColor: const Color(0xFFFFF8E1),
                                filled: true,
                                labelText: l10n.address,
                                hintText: l10n.enterCompleteDeliveryAddress,
                                hintStyle: const TextStyle(color: Color(0xFF878787)),
                                labelStyle: const TextStyle(color: Color(0xFF878787)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFF878787)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFFC6A667)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return l10n.deliveryAddressRequired;
                                }
                                if (value.trim().length < 10) {
                                  return l10n.enterCompleteAddress;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Payment Method
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F0F0F),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF878787), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0x33),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.paymentMethod.toUpperCase(),
                              style: GoogleFonts.cinzel(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFD4AF7A),
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 16),
                            RadioListTile<String>(
                              title: Text(
                                l10n.cashOnDelivery,
                                style: const TextStyle(color: Color(0xFFF5E8C7)),
                              ),
                              value: 'cash_on_delivery',
                              groupValue: _paymentMethod,
                              activeColor: const Color(0xFFC6A667),
                              onChanged: (value) {
                                setState(() {
                                  _paymentMethod = value!;
                                });
                              },
                            ),
                            RadioListTile<String>(
                              title: Text(
                                l10n.stripeOnlinePayment,
                                style: const TextStyle(color: Color(0xFFF5E8C7)),
                              ),
                              value: 'stripe',
                              groupValue: _paymentMethod,
                              activeColor: const Color(0xFFC6A667),
                              onChanged: (value) {
                                setState(() {
                                  _paymentMethod = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Place Order Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _placeOrder,
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
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0F0F0F)),
                                  ),
                                )
                              : Text(
                                  l10n.lockInTheOrder,
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

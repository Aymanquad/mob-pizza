import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mob_pizza_mobile/providers/order_provider.dart';
import 'package:mob_pizza_mobile/models/order.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailScreen({super.key, required this.orderId});

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy • hh:mm a').format(date);
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return const Color(0xFF878787);
      case OrderStatus.confirmed:
        return const Color(0xFFC6A667);
      case OrderStatus.preparing:
        return const Color(0xFFC6A667);
      case OrderStatus.onTheWay:
        return const Color(0xFFC6A667);
      case OrderStatus.delivered:
        return const Color(0xFF00E676);
      case OrderStatus.cancelled:
        return const Color(0xFFFF5252);
    }
  }

  Color _getStatusTextColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return const Color(0xFFFFF8E1);
      case OrderStatus.confirmed:
        return const Color(0xFF0F0F0F);
      case OrderStatus.preparing:
        return const Color(0xFF0F0F0F);
      case OrderStatus.onTheWay:
        return const Color(0xFF0F0F0F);
      case OrderStatus.delivered:
        return const Color(0xFF0F0F0F);
      case OrderStatus.cancelled:
        return const Color(0xFFFFF8E1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final orderProvider = Provider.of<OrderProvider>(context);
    final order = orderProvider.getOrderById(orderId);

    if (order == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            l10n.orderNotFound,
            style: GoogleFonts.cinzel(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              letterSpacing: 1.2,
              color: const Color(0xFFFFF8E1),
            ),
          ),
          backgroundColor: const Color(0xFF1C1512),
          foregroundColor: const Color(0xFFF5E8C7),
        ),
        body: Center(
          child: Text(
            l10n.orderNotFoundMessage,
            style: const TextStyle(color: Color(0xFFF5E8C7)),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          order.orderNumber,
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF5E8C7)),
          onPressed: () => context.go('/orders'),
        ),
      ),
      backgroundColor: const Color(0xFF1C1512),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Badge
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: _getStatusColor(order.status),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _getStatusColor(order.status), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: _getStatusColor(order.status).withValues(alpha: 0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  order.status.displayName.toUpperCase(),
                  style: GoogleFonts.cinzel(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: _getStatusTextColor(order.status),
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Order Items
            Text(
              l10n.orderItems,
              style: GoogleFonts.cinzel(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: const Color(0xFFD4AF7A),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            ...order.items.map((item) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0F0F0F),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF878787), width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item.imagePath,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 60,
                        height: 60,
                        color: const Color(0xFF1C1512),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.quantity}x ${item.name}',
                          style: const TextStyle(
                            color: Color(0xFFFFF8E1),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${l10n.size} ${item.selectedSize}',
                          style: const TextStyle(
                            color: Color(0xFFD4AF7A),
                            fontSize: 12,
                          ),
                        ),
                        if (item.selectedToppings.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            '${l10n.toppings} ${item.selectedToppings.length}',
                            style: const TextStyle(
                              color: Color(0xFF878787),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Text(
                    '\$${item.totalPrice.toStringAsFixed(2)}',
                    style: GoogleFonts.cinzel(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFC6A667),
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 24),

            // Order Information
            Text(
              l10n.orderInformation,
              style: GoogleFonts.cinzel(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: const Color(0xFFD4AF7A),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0F0F0F),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF878787), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(l10n.orderNumber, order.orderNumber),
                  const Divider(color: Color(0xFF878787), height: 24),
                  _buildInfoRow(l10n.customer, order.customerName),
                  const Divider(color: Color(0xFF878787), height: 24),
                  _buildInfoRow(l10n.phone, order.phoneNumber),
                  const Divider(color: Color(0xFF878787), height: 24),
                  _buildInfoRow(l10n.deliveryAddress, order.deliveryAddress),
                  const Divider(color: Color(0xFF878787), height: 24),
                  _buildInfoRow(
                    l10n.paymentMethod,
                    order.paymentMethod == 'cash_on_delivery' ? l10n.cashOnDelivery : l10n.stripeOnlinePayment,
                  ),
                  const Divider(color: Color(0xFF878787), height: 24),
                  _buildInfoRow(l10n.orderDate, _formatDate(order.createdAt)),
                  if (order.estimatedDelivery != null) ...[
                    const Divider(color: Color(0xFF878787), height: 24),
                    _buildInfoRow(l10n.estimatedDelivery, _formatDate(order.estimatedDelivery!)),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Total
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF7A1F1F).withValues(alpha: 0x66),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFC6A667), width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.total.toUpperCase(),
                    style: GoogleFonts.cinzel(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFD4AF7A),
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    '\$${order.totalPrice.toStringAsFixed(2)}',
                    style: GoogleFonts.cinzel(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFC6A667),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF878787),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFFFFF8E1),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

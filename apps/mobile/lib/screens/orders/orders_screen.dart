import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mob_pizza_mobile/providers/order_provider.dart';
import 'package:mob_pizza_mobile/models/order.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _hasLoaded = false;

  @override
  void initState() {
    super.initState();
    // Load orders once when screen opens
    // CRITICAL: Always force reload to ensure we have current user's orders
    // This prevents showing cached orders from a previous user
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_hasLoaded) {
        final orderProvider = Provider.of<OrderProvider>(context, listen: false);
        // Always force reload to ensure fresh data for current user
        orderProvider.loadOrders(forceReload: true);
        _hasLoaded = true;
      }
    });
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy • hh:mm a').format(date);
  }

  String _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return '0xFF878787';
      case OrderStatus.confirmed:
        return '0xFFC6A667';
      case OrderStatus.preparing:
        return '0xFFC6A667';
      case OrderStatus.onTheWay:
        return '0xFFC6A667';
      case OrderStatus.delivered:
        return '0xFF00E676';
      case OrderStatus.cancelled:
        return '0xFFFF5252';
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

    return SafeArea(
      child: Container(
        color: const Color(0xFF1C1512),
        child: orderProvider.orders.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F0F0F),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFC6A667), width: 2),
                        ),
                        child: const Icon(
                          Icons.receipt_long_outlined,
                          size: 64,
                          color: Color(0xFF878787),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        l10n.noOrders,
                        style: GoogleFonts.cinzel(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFF5E8C7),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.orderHistoryWillAppear,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF878787),
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC6A667),
                          foregroundColor: const Color(0xFF0F0F0F),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orderProvider.orders.length,
                itemBuilder: (context, index) {
                  final order = orderProvider.orders[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
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
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              order.orderNumber,
                              style: GoogleFonts.cinzel(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFFFF8E1),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Color(int.parse(_getStatusColor(order.status))),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Color(int.parse(_getStatusColor(order.status))),
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                order.status.displayName.toUpperCase(),
                                style: TextStyle(
                                  color: _getStatusTextColor(order.status),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.5,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            '${order.items.length} ${order.items.length > 1 ? l10n.items : l10n.item} • \$${order.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Color(0xFFD4AF7A),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDate(order.createdAt),
                            style: const TextStyle(
                              color: Color(0xFF878787),
                              fontSize: 12,
                            ),
                          ),
                          if (order.estimatedDelivery != null && 
                              (order.status == OrderStatus.confirmed || 
                               order.status == OrderStatus.preparing || 
                               order.status == OrderStatus.onTheWay)) ...[
                            const SizedBox(height: 4),
                            Text(
                              '${l10n.eta}: ${_formatDate(order.estimatedDelivery!)}',
                              style: const TextStyle(
                                color: Color(0xFFC6A667),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ],
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Color(0xFFC6A667),
                      ),
                      onTap: () => context.go('/orders/${order.id}'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

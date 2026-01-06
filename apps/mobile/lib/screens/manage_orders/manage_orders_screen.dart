import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_pizza_mobile/providers/order_provider.dart';
import 'package:mob_pizza_mobile/models/order.dart';
import 'package:intl/intl.dart';

class ManageOrdersScreen extends StatefulWidget {
  const ManageOrdersScreen({super.key});

  @override
  State<ManageOrdersScreen> createState() => _ManageOrdersScreenState();
}

class _ManageOrdersScreenState extends State<ManageOrdersScreen> {
  final TextEditingController _securityAnswerController = TextEditingController();
  bool _securityVerified = false;
  bool _hasLoaded = false;

  @override
  void initState() {
    super.initState();
    // Reload orders once when screen opens to get all orders (for hosts)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_hasLoaded) {
        final orderProvider = Provider.of<OrderProvider>(context, listen: false);
        orderProvider.loadOrders(forceReload: true);
        _hasLoaded = true;
      }
    });
  }

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

  Future<void> _verifySecurity() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0F0F0F),
        title: Text(
          'Security Verification',
          style: GoogleFonts.cinzel(
            color: const Color(0xFFC6A667),
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What is the code name for Mob Pizza?',
              style: const TextStyle(color: Color(0xFFF5E8C7), fontSize: 14),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _securityAnswerController,
              style: const TextStyle(color: Color(0xFF000000)),
              decoration: InputDecoration(
                fillColor: const Color(0xFFFFF8E1),
                filled: true,
                hintText: 'Enter answer',
                hintStyle: const TextStyle(color: Color(0xFF878787)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF878787)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF878787)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFC6A667)),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _securityAnswerController.clear();
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF878787))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC6A667),
              foregroundColor: const Color(0xFF0F0F0F),
            ),
            onPressed: () {
              final answer = _securityAnswerController.text.trim().toLowerCase();
              _securityAnswerController.clear();
              // Simple answer: "the don" or "don" or "mob"
              if (answer == 'the don' || answer == 'don' || answer == 'mob') {
                Navigator.of(context).pop(true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Incorrect answer. Access denied.'),
                    backgroundColor: Colors.red,
                  ),
                );
                Navigator.of(context).pop(false);
              }
            },
            child: const Text('Verify'),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      setState(() {
        _securityVerified = true;
      });
    }
  }

  Future<void> _changeOrderStatus(Order order, OrderStatus newStatus) async {
    if (!_securityVerified) {
      await _verifySecurity();
      if (!_securityVerified) return;
    }

    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    await orderProvider.updateOrderStatus(order.id, newStatus);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Order ${order.orderNumber} status updated to ${newStatus.displayName}',
          ),
          backgroundColor: const Color(0xFF00E676),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showStatusChangeDialog(Order order) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F0F0F),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF878787),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                'Change Order Status',
                style: GoogleFonts.cinzel(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFC6A667),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select new status for ${order.orderNumber}',
                style: const TextStyle(
                  color: Color(0xFF878787),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  shrinkWrap: true,
                  children: [
                    OrderStatus.pending,
                    OrderStatus.confirmed,
                    OrderStatus.preparing,
                    OrderStatus.onTheWay,
                    OrderStatus.delivered,
                    OrderStatus.cancelled,
                  ].map((status) => ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    leading: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _getStatusColor(status),
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(
                      status.displayName,
                      style: TextStyle(
                        color: status == order.status
                            ? const Color(0xFFC6A667)
                            : const Color(0xFFF5E8C7),
                        fontWeight: status == order.status
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                    ),
                    trailing: status == order.status
                        ? const Icon(Icons.check, color: Color(0xFFC6A667))
                        : null,
                    onTap: () {
                      Navigator.of(context).pop();
                      _changeOrderStatus(order, status);
                    },
                  )).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _securityAnswerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1C1512),
        appBar: AppBar(
          title: Text(
            'MANAGE ORDERS',
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
          actions: [
            if (!_securityVerified)
              IconButton(
                icon: const Icon(Icons.lock_outline),
                tooltip: 'Verify Security',
                onPressed: _verifySecurity,
              ),
            if (_securityVerified)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF00E676).withValues(alpha: 0x19),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF00E676)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.verified, color: Color(0xFF00E676), size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Verified',
                      style: GoogleFonts.cinzel(
                        color: const Color(0xFF00E676),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        body: orderProvider.orders.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.receipt_long_outlined,
                        size: 64,
                        color: Color(0xFF878787),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'No orders found',
                        style: GoogleFonts.cinzel(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFF5E8C7),
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
                  final statusColor = _getStatusColor(order.status);

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
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.all(16),
                        onTap: () {
                          context.go('/orders/${order.id}');
                        },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  order.orderNumber,
                                  style: GoogleFonts.cinzel(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFFFF8E1),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.19),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: statusColor, width: 1),
                                ),
                                child: Text(
                                  order.status.displayName,
                                  style: TextStyle(
                                    color: statusColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
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
                                '${order.items.length} items • \$${order.totalPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Color(0xFFD4AF7A),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Customer: ${order.customerName}',
                                style: const TextStyle(
                                  color: Color(0xFF878787),
                                  fontSize: 12,
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
                            ],
                          ),
                        ),
                        if (_securityVerified)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Color(0xFF878787), width: 1),
                              ),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFC6A667),
                                  foregroundColor: const Color(0xFF0F0F0F),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () => _showStatusChangeDialog(order),
                                child: Text(
                                  'CHANGE STATUS',
                                  style: GoogleFonts.cinzel(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}


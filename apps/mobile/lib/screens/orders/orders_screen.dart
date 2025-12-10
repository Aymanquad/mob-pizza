import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      ('ORD-001', 'On the Streets', '18 mins'),
      ('ORD-000', 'Delivered', 'Completed'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Past Jobs')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final o = orders[index];
          return Card(
            color: const Color(0xFF1C1512),
            child: ListTile(
              title: Text(o.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
              subtitle: Text('Status: ${o.$2} · ETA: ${o.$3}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go('/orders/${o.$1}'),
            ),
          );
        },
      ),
    );
  }
}


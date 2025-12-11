import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order $orderId')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Kitchen in Motion → On the Streets → Delivered', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            const Text('Items'),
            const ListTile(
              title: Text('Margherita – The Mistress'),
              subtitle: Text('Solo · Extra cheese'),
              trailing: Text('\$12.00', style: TextStyle(fontWeight: FontWeight.w800)),
            ),
            const Spacer(),
            const Text('Runner: Tony • ETA 18 mins', style: TextStyle(color: Color(0xFFC0B8A8))),
            const SizedBox(height: 6),
            const Text('Family Tip: Keep your line open; runners may call on arrival.', style: TextStyle(color: Color(0xFFC0B8A8))),
          ],
        ),
      ),
    );
  }
}


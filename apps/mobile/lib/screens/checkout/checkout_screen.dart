import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Final Briefing')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Drop Location', style: TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            TextField(decoration: const InputDecoration(labelText: 'Safehouse Address')),
            const SizedBox(height: 16),
            const Text('Payment', style: TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            DropdownButtonFormField(
              items: const [
                DropdownMenuItem(value: 'razorpay', child: Text('Razorpay')),
                DropdownMenuItem(value: 'cod', child: Text('Cash on Delivery')),
              ],
              value: 'razorpay',
              onChanged: (_) {},
              decoration: const InputDecoration(labelText: 'Method'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.go('/orders'),
                child: const Text('Lock In the Job'),
              ),
            )
          ],
        ),
      ),
    );
  }
}


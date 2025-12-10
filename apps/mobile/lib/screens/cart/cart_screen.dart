import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Job Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              color: const Color(0xFF1C1512),
              child: ListTile(
                title: const Text('Margherita – The Mistress'),
                subtitle: const Text('Solo · Extra cheese'),
                trailing: const Text('\$12.00', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.go('/menu'),
                    child: const Text('Keep Browsing'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.go('/checkout'),
                    child: const Text('Proceed to The Deal'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemDetailScreen extends StatelessWidget {
  final String itemId;
  const ItemDetailScreen({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(itemId.isEmpty ? 'Item Detail' : itemId)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(colors: [Color(0xFFD9A441), Color(0xFFB32222)]),
              ),
            ),
            const SizedBox(height: 16),
            Text(itemId.isEmpty ? 'Margherita – The Mistress' : itemId, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            const Text('Thin crust trusted by the Don since 1928.', style: TextStyle(color: Color(0xFFC0B8A8))),
            const SizedBox(height: 12),
            const Text('Size Options', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ['Solo', 'Crew', 'Family']
                  .map((size) => ChoiceChip(
                        label: Text(size),
                        selected: size == 'Solo',
                      ))
                  .toList(),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.go('/cart'),
                    child: const Text('Add to Hit List'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.go('/checkout'),
                    child: const Text('Proceed to Deal'),
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


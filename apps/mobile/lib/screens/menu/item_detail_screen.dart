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
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 220,
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(Color(0x550B0C10), BlendMode.darken),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1548365328-9da9d5166be6?auto=format&fit=crop&w=900&q=80&sat=-100',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: const Color(0x550F0F0F)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(itemId.isEmpty ? 'Margherita – The Mistress' : itemId, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            const Text('Thin crust trusted by the Don since 1928. Smoke, basil oil, speakeasy flair.', style: TextStyle(color: Color(0xFFC0B8A8))),
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
            ),
            const SizedBox(height: 8),
            const Text('House Notes: Brick oven, 12 min prep. Add truffle drizzle for a small upcharge.', style: TextStyle(color: Color(0xFFC0B8A8))),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      ('The Hit List', 'Browse signature pies', '/menu'),
      ('Job Summary', 'Your cart, Mob-styled', '/cart'),
      ('Past Jobs', 'Track & re-order', '/orders'),
      ('Your File', 'Profile & safehouses', '/profile'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Family’s Table'),
        actions: [
          IconButton(
            onPressed: () => context.go('/cart'),
            icon: const Icon(Icons.shopping_bag_outlined),
            tooltip: 'Job Summary',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: const LinearGradient(
                colors: [Color(0xFFD9A441), Color(0xFFB32222)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Tonight’s Specials', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF0B0C10))),
                SizedBox(height: 4),
                Text('Mob-themed picks curated by the Don.', style: TextStyle(color: Color(0xFF0B0C10))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: cards
                .map(
                  (c) => GestureDetector(
                    onTap: () => context.go(c.$3),
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 64) / 2,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1512),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF3A3A3A)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.$1, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(c.$2, style: const TextStyle(color: Color(0xFFC0B8A8))),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final featured = [
      ('Boss Pick', 'Margherita – The Mistress', '\$12', 'Solo • Extra cheese'),
      ('House Secret', 'Smoky Capo BBQ', '\$15', 'Brick oven • Sweet heat'),
      ('Family Combo', 'Crew Feast', '\$29', '2 pies • Sides • Liquid alibi'),
    ];

    final stats = [
      ('Jobs Closed', '124'),
      ('Family Points', '1,240'),
      ('Safehouses', '3'),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/logo_emblem.svg',
              height: 32,
              width: 32,
            ),
            const SizedBox(width: 10),
            SvgPicture.asset(
              'assets/icons/logo_wordmark.svg',
              height: 28,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => context.go('/cart'),
            icon: const Icon(Icons.shopping_bag_outlined, color: Color(0xFFC6A667)),
            tooltip: 'Job Summary',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                colors: [Color(0xFF7A1F1F), Color(0xFF0F0F0F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: const Color(0xFFC6A667)),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.25,
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(Color(0x990F0F0F), BlendMode.darken),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1521017432531-fbd92d768814?auto=format&fit=crop&w=1200&q=80&sat=-100',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(color: const Color(0x550F0F0F)),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/icons/filigree_top.svg', width: 140, color: const Color(0xFFC6A667)),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: const Text('The Don’s Briefing', style: TextStyle(fontSize: 12, letterSpacing: 1, fontWeight: FontWeight.w700, color: Color(0xFFF5E8C7))),
                    ),
                    const SizedBox(height: 10),
                    const Text('Mob Pizza', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFFC6A667))),
                    const SizedBox(height: 4),
                    const Text('Cinematic pies. Speakeasy service. Whisper your order.', style: TextStyle(color: Color(0xFFF5E8C7))),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC6A667),
                            foregroundColor: const Color(0xFF0F0F0F),
                          ),
                          onPressed: () => context.go('/menu'),
                          child: const Text('Order Now'),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFFC6A667),
                            side: const BorderSide(color: Color(0xFFC6A667)),
                          ),
                          onPressed: () => context.go('/orders'),
                          child: const Text('Track Jobs'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SvgPicture.asset('assets/icons/filigree_bottom.svg', width: 140, color: const Color(0xFFC6A667)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: const [
                        Chip(label: Text('Boss Picks')),
                        Chip(label: Text('Under-the-Table Deals')),
                        Chip(label: Text('Family Combos')),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF7A1F1F),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFC6A667)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: stats
                  .map(
                    (s) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.$1.toUpperCase(), style: const TextStyle(color: Color(0xFF878787), fontWeight: FontWeight.w700, letterSpacing: 0.5, fontSize: 12)),
                        Text(s.$2, style: const TextStyle(color: Color(0xFFC6A667), fontWeight: FontWeight.w900, fontSize: 20)),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Family Shortcuts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFFC6A667))),
          const SizedBox(height: 10),
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
                        color: const Color(0xFF0F0F0F),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFF878787)),
                        boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, 6))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                image: NetworkImage('https://images.unsplash.com/photo-1521017432531-fbd92d768814?auto=format&fit=crop&w=800&q=80&sat=-100'),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(Color(0x880F0F0F), BlendMode.darken),
                              ),
                            ),
                            foregroundDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black.withOpacity(0.02),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(c.$1, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFFF5E8C7))),
                          const SizedBox(height: 4),
                          Text(c.$2, style: const TextStyle(color: Color(0xFFC6A667))),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF0F0F0F),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF878787)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Family Bulletin', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFFC6A667))),
                const SizedBox(height: 8),
                ...featured.map(
                  (f) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(f.$1, style: const TextStyle(color: Color(0xFFC6A667), fontWeight: FontWeight.w700)),
                            Text(f.$2, style: const TextStyle(color: Color(0xFFF5E8C7), fontWeight: FontWeight.w800)),
                            Text(f.$4, style: const TextStyle(color: Color(0xFF878787))),
                          ],
                        ),
                        Text(f.$3, style: const TextStyle(color: Color(0xFFF5E8C7), fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF7A1F1F),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFC6A667)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('House Secrets', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFFF5E8C7))),
                SizedBox(height: 8),
                Text('Boss Picks • Under-the-Table Deals • Family Combos', style: TextStyle(color: Color(0xFFF5E8C7))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';

class MenuListScreen extends StatelessWidget {
  const MenuListScreen({super.key});

  String getSpiceLevel(String name, String description) {
    final lowerName = name.toLowerCase();
    final lowerDesc = description.toLowerCase();

    // High spice (🌶️🌶️🌶️) - about 25% of pizzas
    if (lowerName.contains('indian') || lowerDesc.contains('spiced') || lowerDesc.contains('tandoori') ||
        lowerName.contains('brick oven') || lowerDesc.contains('fire-kissed') ||
        lowerName.contains('smoky capo') || lowerDesc.contains('sweet heat')) {
      return '🌶️🌶️🌶️'; // High spice
    }
    // Medium spice (🌶️🌶️) - about 25% of pizzas
    else if (lowerName.contains('bbq') || lowerDesc.contains('smoky') ||
             lowerName.contains('velvet pepperoni') || lowerDesc.contains('red pepper flakes') ||
             lowerName.contains('detroit style') || lowerDesc.contains('jalapeños') ||
             lowerName.contains('sicilian') || lowerDesc.contains('hot peppers') ||
             lowerName.contains('neapolitan') || lowerDesc.contains('hot peppers')) {
      return '🌶️🌶️'; // Medium spice
    }
    // Low spice (🌶️) - about 20% of pizzas (remaining spicy ones)
    else if (lowerName.contains('japanese') || lowerName.contains('teriyaki') || lowerDesc.contains('mayo') ||
             lowerName.contains('turkish') || lowerDesc.contains('onion-forward') ||
             lowerName.contains('california') || lowerDesc.contains('jalapeños') ||
             lowerName.contains('new york') || lowerDesc.contains('red onions') ||
             lowerName.contains('vegan') || lowerDesc.contains('jalapeños') ||
             lowerName.contains('roman al taglio') || lowerDesc.contains('seasonal')) {
      return '🌶️'; // Low spice
    }
    return ''; // No spice (about 30% of pizzas are mild)
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sections = [
      (
        'International Variations',
        [
      (
        'Japanese-Inspired',
        'Seafood, mayo, teriyaki elements.',
        16.5,
        false,
        'assets/images/japanese-inspired-pizza.jpg'
      ),
      (
        'Indian-Inspired',
        'Paneer, tandoori toppings, spiced sauces.',
        15.0,
        true,
        'assets/images/indian-inspired-pizza.jpg'
      ),
      (
        'Turkish Pide',
        'Boat-shaped flatbread with toppings.',
        17.5,
        false,
        'assets/images/turkish-pide-pizza.webp'
      ),
      (
        'Brazilian',
        'Sweet/dessert-style options alongside savory.',
        14.5,
        false,
        'assets/images/Brazilian-inspired-Pizza.jpg'
      ),
        ]
      ),
      (
        'Speciality and Alternative Bases',
        [
          (
            'Gluten-Free Pizza',
            'Alternative flours, crafted for a lighter base.',
            16.0,
            true,
            'assets/images/gluten-free-pizza.jpg'
          ),
          (
            'Vegan Pizza',
            'Plant-based cheese and toppings; no animal products.',
            15.5,
            true,
            'assets/images/vegan-pizza.jpg'
          ),
          (
            'Stuffed Crust',
            'Cheese-filled crust edge for the indulgent.',
            17.0,
            false,
            'assets/images/stuffed-crust-pizza.jpg'
          ),
          (
            'White Pizza',
            'Ricotta, mozzarella, olive oil, garlic—no tomato sauce.',
            15.0,
            true,
            'assets/images/white-pizza.jpg'
          ),
        ]
      ),
      (
        'American Regional Style',
        [
          (
            'New York Style',
            'Large, foldable slices; thin but sturdy crust.',
            14.0,
            false,
            'assets/images/new-york-style-pizza.jpg'
          ),
          (
            'Chicago Deep Dish',
            'Thick, pie-like crust with layered cheese and sauce.',
            18.0,
            false,
            'assets/images/chicago-style-pizza.jpg'
          ),
          (
            'Detroit Style',
            'Rectangular pan, caramelized cheese edges.',
            17.5,
            false,
            'assets/images/detroit-style-pizza.jpg'
          ),
          (
            'California Style',
            'Thin crust with unconventional fresh toppings.',
            15.0,
            false,
            'assets/images/california-style-pizza.jpg'
          ),
        ]
      ),
      (
        'Italian Style',
        [
          (
            'Neapolitan',
            'Thin, soft, wood-fired with blistered edges.',
            15.5,
            true,
            'assets/images/neapolitan-style-pizza.webp'
          ),
          (
            'Roman al Taglio',
            'Rectangular, thin, crisp; sold by the slice.',
            16.0,
            false,
            'assets/images/Romanaltaglio-Style-Pizza.webp'
          ),
          (
            'Sicilian (Sfinciuni)',
            'Thick, airy crust; onion-forward sauce.',
            16.5,
            false,
            'assets/images/Sicilian-Pizza.webp'
          ),
        ]
      ),
      (
        'Classic and Widely Sold Pizzas',
        [
          (
            'Margherita – The Mistress',
            'Thin crust trusted by the Don.',
            12.0,
            true,
            'assets/images/margherita-pizza.jpg'
          ),
          (
            'Pepperoni Classic',
            'Tomato sauce, mozzarella, pepperoni slices.',
            13.0,
            false,
            'assets/images/Classic-Pepperoni-Pizza.jpg'
          ),
          (
            'Cheese Classic',
            'Tomato sauce and mozzarella; minimalist and comforting.',
            11.0,
            true,
            'assets/images/Cheese_Classic_Pizza.jpg'
          ),
          (
            'Veggie Classic',
            'Peppers, onions, olives, mushrooms.',
            12.5,
            true,
            'assets/images/veggie-pizza.png'
          ),
          (
            'Caprese Hitman',
            'Fresh mozz, basil, olive mafia drizzle.',
            14.0,
            true,
            'assets/images/caprese-pizza.jpeg'
          ),
          (
            'Truffle White Hit',
            'White sauce, parmesan rain.',
            16.0,
            true,
            'assets/images/Truffle-White-Pizza.jpg'
          ),
          (
            'Brick Oven Don',
            'Fire-kissed crust, basil oil.',
            17.0,
            false,
            'assets/images/brick-oven-pizza.webp'
          ),
          (
            'Smoky Capo BBQ',
            'Brick oven, sweet heat.',
            15.0,
            false,
            'assets/images/smoke-bbq-pizza.jpg'
          ),
          (
            'Velvet Pepperoni',
            'Loaded curls, velvet cheese pull.',
            15.5,
            false,
            'assets/images/velvet-pepperoni-pizza.jpg'
          ),
        ]
      ),
    ];
    return SafeArea(
      child: Container(
        color: const Color(0xFF1C1512),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF0F0F0F),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF878787), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0x4D),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                  BoxShadow(
                    color: const Color(0xFFC6A667).withValues(alpha: 0x19),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: TextField(
                style: TextStyle(
                  color: Color(0xFFF5E8C7),
                  fontFamily: 'Cinzel',
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Color(0xFFC6A667)),
                  hintText: l10n.searchMenu,
                  hintStyle: TextStyle(
                    color: Color(0xFFC6A667),
                    fontFamily: 'Cinzel',
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    letterSpacing: 0.8,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...sections.map((section) {
              final sectionTitle = section.$1;
              final sectionItems = section.$2;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7A1F1F), Color(0xFF1C1512)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: const Color(0xFFC6A667), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFC6A667).withValues(alpha: 0x66),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0x4D),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        sectionTitle.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFF5E8C7),
                          fontFamily: 'Cinzel',
                          letterSpacing: 1.2,
                          height: 1.2,
                          shadows: [
                            Shadow(
                              color: Color(0xFFC6A667),
                              offset: Offset(0, 0),
                              blurRadius: 6,
                            ),
                            Shadow(
                              color: Color(0xFF000000),
                              offset: Offset(0.5, 0.5),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ...sectionItems.asMap().entries.map((entry) {
                    final globalIndex = sections.takeWhile((s) => s.$1 != sectionTitle).fold<int>(0, (sum, s) => sum + s.$2.length) + entry.key;
                    final spiceLevel = getSpiceLevel(entry.value.$1, entry.value.$2);
                    return GestureDetector(
                      onTap: () => context.go('/menu/$globalIndex'),
                child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        constraints: const BoxConstraints(minHeight: 140),
                decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0F0F0F), Color(0xFF1C1512)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF878787), width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFC6A667).withValues(alpha: 0x26),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0x80),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0x4D),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                ),
                child: Padding(
                          padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                                  width: 100,
                                  height: 100,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                entry.value.$5,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(color: const Color(0x550F0F0F)),
                              ),
                              Container(
                                        decoration: const BoxDecoration(
                                  gradient: const LinearGradient(
                                            colors: const [
                                              Color(0x990F0F0F),
                                              Colors.transparent,
                                              Color(0x660F0F0F)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                              const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              entry.value.$1,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'Playfair Display',
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: Color(0xFFF5E8C7),
                                letterSpacing: 0.2,
                                height: 1.1,
                                shadows: [
                                  Shadow(
                                    color: Color(0xFFC6A667),
                                    offset: Offset(0, 0),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                                    const SizedBox(height: 6),
                            Text(
                              entry.value.$2,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xFFC6A667),
                                fontSize: 11,
                                fontFamily: 'Inter',
                                height: 1.3,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 0.1,
                              ),
                            ),
                                    if (spiceLevel.isNotEmpty) ...[
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Text(
                                            'Heat Level: $spiceLevel',
                                            style: const TextStyle(
                                              color: Color(0xFFFF6B6B),
                                              fontSize: 9,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Cinzel',
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFC6A667).withValues(alpha: 0x19),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: const Color(0xFFC6A667), width: 1.5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFC6A667).withValues(alpha: 0x33),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      '\$${entry.value.$3.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 14,
                                        color: Color(0xFFC6A667),
                                        fontFamily: 'Cinzel',
                                        letterSpacing: 0.5,
                                        shadows: [
                                          Shadow(
                                            color: Color(0xFF000000),
                                            offset: Offset(0.5, 0.5),
                                            blurRadius: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: entry.value.$4 ? Colors.greenAccent.withValues(alpha: 0x19) : Colors.redAccent.withValues(alpha: 0x19),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: entry.value.$4 ? Colors.greenAccent : Colors.redAccent,
                                        width: 1.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: (entry.value.$4 ? Colors.greenAccent : Colors.redAccent).withValues(alpha: 0x33),
                                          blurRadius: 4,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      entry.value.$4 ? 'VEG' : 'NON-VEG',
                                      style: TextStyle(
                                        color: entry.value.$4 ? Colors.greenAccent : Colors.redAccent,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 0.8,
                                        fontFamily: 'Cinzel',
                                      ),
                                    ),
                                  ),
                        ],
                      ),
                    ],
                  ),
                  ),
                ),
                    );
                  }),
                  const SizedBox(height: 24),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';

class MenuListScreen extends StatefulWidget {
  const MenuListScreen({super.key});

  @override
  State<MenuListScreen> createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuListScreen> {
  String _searchQuery = '';

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
        l10n.internationalVariations,
        [
      (
        l10n.pizzaJapaneseInspired,
        l10n.pizzaJapaneseInspiredDesc,
        16.5,
        false,
        'assets/images/japanese-inspired-pizza.jpg'
      ),
      (
        l10n.pizzaIndianInspired,
        l10n.pizzaIndianInspiredDesc,
        15.0,
        true,
        'assets/images/indian-inspired-pizza.jpg'
      ),
      (
        l10n.pizzaTurkishPide,
        l10n.pizzaTurkishPideDesc,
        17.5,
        false,
        'assets/images/turkish-pide-pizza.webp'
      ),
      (
        l10n.pizzaBrazilian,
        l10n.pizzaBrazilianDesc,
        14.5,
        false,
        'assets/images/Brazilian-inspired-Pizza.jpg'
      ),
        ]
      ),
      (
        l10n.specialityAndAlternativeBases,
        [
          (
            l10n.pizzaGlutenFree,
            l10n.pizzaGlutenFreeDesc,
            16.0,
            true,
            'assets/images/gluten-free-pizza.jpg'
          ),
          (
            l10n.pizzaVegan,
            l10n.pizzaVeganDesc,
            15.5,
            true,
            'assets/images/vegan-pizza.jpg'
          ),
          (
            l10n.pizzaStuffedCrust,
            l10n.pizzaStuffedCrustDesc,
            17.0,
            false,
            'assets/images/stuffed-crust-pizza.jpg'
          ),
          (
            l10n.pizzaWhite,
            l10n.pizzaWhiteDesc,
            15.0,
            true,
            'assets/images/white-pizza.jpg'
          ),
        ]
      ),
      (
        l10n.americanRegionalStyle,
        [
          (
            l10n.pizzaNewYorkStyle,
            l10n.pizzaNewYorkStyleDesc,
            14.0,
            false,
            'assets/images/new-york-style-pizza.jpg'
          ),
          (
            l10n.pizzaChicagoDeepDish,
            l10n.pizzaChicagoDeepDishDesc,
            18.0,
            false,
            'assets/images/chicago-style-pizza.jpg'
          ),
          (
            l10n.pizzaDetroitStyle,
            l10n.pizzaDetroitStyleDesc,
            17.5,
            false,
            'assets/images/detroit-style-pizza.jpg'
          ),
          (
            l10n.pizzaCaliforniaStyle,
            l10n.pizzaCaliforniaStyleDesc,
            15.0,
            false,
            'assets/images/california-style-pizza.jpg'
          ),
        ]
      ),
      (
        l10n.italianStyle,
        [
          (
            l10n.pizzaNeapolitan,
            l10n.pizzaNeapolitanDesc,
            15.5,
            true,
            'assets/images/neapolitan-style-pizza.webp'
          ),
          (
            l10n.pizzaRomanAlTaglio,
            l10n.pizzaRomanAlTaglioDesc,
            16.0,
            false,
            'assets/images/Romanaltaglio-Style-Pizza.webp'
          ),
          (
            l10n.pizzaSicilian,
            l10n.pizzaSicilianDesc,
            16.5,
            false,
            'assets/images/Sicilian-Pizza.webp'
          ),
        ]
      ),
      (
        l10n.classicAndWidelySoldPizzas,
        [
          (
            l10n.pizzaMargherita,
            l10n.pizzaMargheritaDesc,
            12.0,
            true,
            'assets/images/margherita-pizza.jpg'
          ),
          (
            l10n.pizzaPepperoniClassic,
            l10n.pizzaPepperoniClassicDesc,
            13.0,
            false,
            'assets/images/Classic-Pepperoni-Pizza.jpg'
          ),
          (
            l10n.pizzaCheeseClassic,
            l10n.pizzaCheeseClassicDesc,
            11.0,
            true,
            'assets/images/Cheese_Classic_Pizza.jpg'
          ),
          (
            l10n.pizzaVeggieClassic,
            l10n.pizzaVeggieClassicDesc,
            12.5,
            true,
            'assets/images/veggie-pizza.png'
          ),
          (
            l10n.pizzaCapreseHitman,
            l10n.pizzaCapreseHitmanDesc,
            14.0,
            true,
            'assets/images/caprese-pizza.jpeg'
          ),
          (
            l10n.pizzaTruffleWhiteHit,
            l10n.pizzaTruffleWhiteHitDesc,
            16.0,
            true,
            'assets/images/Truffle-White-Pizza.jpg'
          ),
          (
            l10n.pizzaBrickOvenDon,
            l10n.pizzaBrickOvenDonDesc,
            17.0,
            false,
            'assets/images/brick-oven-pizza.webp'
          ),
          (
            l10n.pizzaSmokyCapoBBQ,
            l10n.pizzaSmokyCapoBBQDesc,
            15.0,
            false,
            'assets/images/smoke-bbq-pizza.jpg'
          ),
          (
            l10n.pizzaVelvetPepperoni,
            l10n.pizzaVelvetPepperoniDesc,
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
                    color: Colors.black.withValues(alpha: 0x26),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontFamily: 'Cinzel',
                  fontSize: 14,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFC6A667)),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Color(0xFFC6A667)),
                          onPressed: () {
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  hintText: l10n.searchMenu,
                  hintStyle: const TextStyle(
                    color: Color(0xFFC6A667),
                    fontFamily: 'Cinzel',
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    letterSpacing: 0.8,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Check if any items match the search
            if (_searchQuery.isNotEmpty && 
                sections.every((section) => 
                  section.$2.every((item) => 
                    !item.$1.toLowerCase().contains(_searchQuery) && 
                    !item.$2.toLowerCase().contains(_searchQuery) &&
                    !section.$1.toLowerCase().contains(_searchQuery)
                  )
                ))
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.search_off,
                        size: 64,
                        color: Color(0xFF878787),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.noPizzasFound,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFC6A667),
                          fontFamily: 'Cinzel',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.tryDifferentKeywords,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF878787),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ...sections.map((section) {
              final sectionTitle = section.$1;
              final sectionItems = section.$2;
              
              // Filter items based on search query
              final filteredItems = _searchQuery.isEmpty
                  ? sectionItems
                  : sectionItems.where((item) {
                      final name = item.$1.toLowerCase();
                      final description = item.$2.toLowerCase();
                      return name.contains(_searchQuery) || 
                             description.contains(_searchQuery) ||
                             sectionTitle.toLowerCase().contains(_searchQuery);
                    }).toList();
              
              // Skip section if no items match
              if (filteredItems.isEmpty) {
                return const SizedBox.shrink();
              }
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
                          color: const Color(0xFFC6A667).withValues(alpha: 0x33),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0x26),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
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
                              color: Color(0xFF000000),
                              offset: Offset(0, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ...filteredItems.asMap().entries.map((entry) {
                    // Find the original index in sectionItems
                    final originalIndexInSection = sectionItems.indexOf(entry.value);
                    final globalIndex = sections.takeWhile((s) => s.$1 != sectionTitle).fold<int>(0, (sum, s) => sum + s.$2.length) + originalIndexInSection;
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
                              color: Colors.black.withValues(alpha: 0x33),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
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
                                fontSize: 17,
                                color: Color(0xFFFFF8E1),
                                letterSpacing: 0.3,
                                height: 1.1,
                                shadows: [
                                  Shadow(
                                    color: Color(0xFF000000),
                                    offset: Offset(0.5, 0.5),
                                    blurRadius: 2,
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
                                color: Color(0xFFD4AF7A),
                                fontSize: 12,
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
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFF6B6B).withValues(alpha: 0x33),
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(color: const Color(0xFFFF6B6B), width: 1),
                                            ),
                                            child: Text(
                                              '${l10n.heatLevel} $spiceLevel',
                                              style: const TextStyle(
                                                color: Color(0xFFFFE0E0),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Cinzel',
                                                letterSpacing: 0.3,
                                              ),
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
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFC6A667),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: const Color(0xFFF5E8C7), width: 2),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0x33),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      '\$${entry.value.$3.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                        color: Color(0xFF1C1512),
                                        fontFamily: 'Cinzel',
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: entry.value.$4 ? const Color(0xFF00E676) : const Color(0xFFFF5252),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: entry.value.$4 ? const Color(0xFF69F0AE) : const Color(0xFFFF8A80),
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0x26),
                                          blurRadius: 3,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      entry.value.$4 ? l10n.veg : l10n.nonVeg,
                                      style: const TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 9,
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


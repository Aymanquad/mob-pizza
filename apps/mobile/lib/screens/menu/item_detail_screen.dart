import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mob_pizza_mobile/providers/cart_provider.dart';
import 'package:mob_pizza_mobile/models/cart_item.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';

class ItemDetailScreen extends StatefulWidget {
  final int itemIndex;
  const ItemDetailScreen({super.key, required this.itemIndex});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  String selectedSize = 'Solo';
  Set<String> selectedToppings = {};

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

  List _getItems(AppLocalizations l10n) {
    return [
    // International Variations
    (
      l10n.pizzaJapaneseInspired,
      l10n.pizzaJapaneseInspiredDesc,
      16.5,
      false,
      'assets/images/japanese-inspired-pizza.jpg',
      l10n.pizzaJapaneseInspiredFullDesc,
      ['Sushi Tuna', 'Japanese Mayo', 'Teriyaki Glaze', 'Nori', 'Sesame Seeds', 'Cucumber'],
      ['Extra Tuna (+4.00)', 'Spicy Mayo (+1.50)', 'Wasabi (+1.00)']
    ),
    (
      l10n.pizzaIndianInspired,
      l10n.pizzaIndianInspiredDesc,
      15.0,
      true,
      'assets/images/indian-inspired-pizza.jpg',
      l10n.pizzaIndianInspiredFullDesc,
      ['Tandoori Paneer', 'Pickled Onions', 'Cilantro Chutney', 'Mozzarella', 'Garam Masala'],
      ['Extra Paneer (+3.00)', 'Mango Chutney (+1.50)', 'Chili Flakes (+1.00)']
    ),
    (
      l10n.pizzaTurkishPide,
      l10n.pizzaTurkishPideDesc,
      17.5,
      false,
      'assets/images/turkish-pide-pizza.webp',
      l10n.pizzaTurkishPideFullDesc,
      ['Ground Lamb', 'Onions', 'Bell Peppers', 'Tomatoes', 'Yogurt Sauce', 'Sumac'],
      ['Extra Lamb (+3.50)', 'Feta Cheese (+2.00)', 'Hot Sauce (+1.00)']
    ),
    (
      l10n.pizzaBrazilian,
      l10n.pizzaBrazilianDesc,
      14.5,
      false,
      'assets/images/Brazilian-inspired-Pizza.jpg',
      l10n.pizzaBrazilianFullDesc,
      ['Hearts of Palm', 'Corn', 'Coconut Flakes', 'Catupiry Cheese', 'Tomato Sauce'],
      ['Extra Catupiry (+2.50)', 'Pineapple (+2.00)', 'Cilantro (+1.50)']
    ),

    // Speciality and Alternative Bases
    (
      l10n.pizzaGlutenFree,
      l10n.pizzaGlutenFreeDesc,
      16.0,
      true,
      'assets/images/gluten-free-pizza.jpg',
      l10n.pizzaGlutenFreeFullDesc,
      ['Gluten-Free Crust', 'Tomato Sauce', 'Mozzarella', 'Bell Peppers', 'Onions', 'Mushrooms'],
      ['Dairy-Free Cheese (+2.00)', 'Extra Veggies (+2.00)', 'Olives (+1.50)']
    ),
    (
      l10n.pizzaVegan,
      l10n.pizzaVeganDesc,
      15.5,
      true,
      'assets/images/vegan-pizza.jpg',
      l10n.pizzaVeganFullDesc,
      ['Vegan Cheese', 'Vegan Tomato Sauce', 'Bell Peppers', 'Onions', 'Mushrooms', 'Fresh Basil'],
      ['Vegan Pepperoni (+3.00)', 'Pineapple (+2.00)', 'Jalapeños (+1.00)']
    ),
    (
      l10n.pizzaStuffedCrust,
      l10n.pizzaStuffedCrustDesc,
      17.0,
      false,
      'assets/images/stuffed-crust-pizza.jpg',
      l10n.pizzaStuffedCrustFullDesc,
      ['Stuffed Cheese Crust', 'Pepperoni', 'Mozzarella', 'Tomato Sauce', 'Garlic Butter'],
      ['Extra Stuffed Crust (+2.50)', 'Sausage (+3.00)', 'Mushrooms (+1.50)']
    ),
    (
      l10n.pizzaWhite,
      l10n.pizzaWhiteDesc,
      15.0,
      true,
      'assets/images/white-pizza.jpg',
      l10n.pizzaWhiteFullDesc,
      ['Ricotta Cheese', 'Mozzarella', 'Roasted Garlic', 'Fresh Herbs', 'Extra Virgin Olive Oil'],
      ['Truffle Oil (+3.00)', 'Prosciutto (+4.00)', 'Arugula (+2.50)']
    ),

    // American Regional Style
    (
      l10n.pizzaNewYorkStyle,
      l10n.pizzaNewYorkStyleDesc,
      14.0,
      false,
      'assets/images/new-york-style-pizza.jpg',
      l10n.pizzaNewYorkStyleFullDesc,
      ['Thin Crust', 'House Tomato Sauce', 'Premium Pepperoni', 'Mozzarella', 'Oregano'],
      ['Extra Pepperoni (+2.50)', 'Mushrooms (+1.50)', 'Sausage (+3.00)']
    ),
    (
      l10n.pizzaChicagoDeepDish,
      l10n.pizzaChicagoDeepDishDesc,
      18.0,
      false,
      'assets/images/chicago-style-pizza.jpg',
      l10n.pizzaChicagoDeepDishFullDesc,
      ['Buttery Deep Crust', 'Italian Sausage', 'Mozzarella', 'Parmesan', 'Chunky Tomato Sauce'],
      ['Extra Sausage (+3.00)', 'Mushrooms (+1.50)', 'Green Peppers (+1.50)']
    ),
    (
      l10n.pizzaDetroitStyle,
      l10n.pizzaDetroitStyleDesc,
      17.5,
      false,
      'assets/images/detroit-style-pizza.jpg',
      l10n.pizzaDetroitStyleFullDesc,
      ['Brick Cheese', 'Premium Pepperoni', 'Detroit Tomato Sauce', 'Oregano', 'Garlic'],
      ['Extra Cheese (+2.00)', 'Hot Honey (+1.50)', 'Jalapeños (+1.00)']
    ),
    (
      l10n.pizzaCaliforniaStyle,
      l10n.pizzaCaliforniaStyleDesc,
      15.0,
      false,
      'assets/images/california-style-pizza.jpg',
      l10n.pizzaCaliforniaStyleFullDesc,
      ['Goat Cheese', 'Walnuts', 'Fresh Figs', 'Arugula', 'Balsamic Glaze'],
      ['Prosciutto (+4.00)', 'Extra Figs (+2.50)', 'Honey Drizzle (+1.50)']
    ),

    // Italian Style
    (
      l10n.pizzaNeapolitan,
      l10n.pizzaNeapolitanDesc,
      15.5,
      true,
      'assets/images/neapolitan-style-pizza.webp',
      l10n.pizzaNeapolitanFullDesc,
      ['High-Hydration Dough', 'San Marzano Tomatoes', 'Fresh Mozzarella', 'Basil', 'Sea Salt'],
      ['Extra Mozzarella (+2.00)', 'Anchovies (+3.00)', 'Hot Peppers (+1.00)']
    ),
    (
      l10n.pizzaRomanAlTaglio,
      l10n.pizzaRomanAlTaglioDesc,
      16.0,
      false,
      'assets/images/Romanaltaglio-Style-Pizza.webp',
      l10n.pizzaRomanAlTaglioFullDesc,
      ['Roman Thin Crust', 'Seasonal Toppings', 'Mozzarella', 'Tomato Sauce', 'Fresh Herbs'],
      ['Prosciutto (+4.00)', 'Artichokes (+2.50)', 'Buffalo Mozzarella (+3.00)']
    ),
    (
      l10n.pizzaSicilian,
      l10n.pizzaSicilianDesc,
      16.5,
      false,
      'assets/images/Sicilian-Pizza.webp',
      l10n.pizzaSicilianFullDesc,
      ['Thick Focaccia Crust', 'Sweet Onions', 'Anchovies', 'Tomato Sauce', 'Oregano', 'Caciocavallo Cheese'],
      ['Extra Onions (+1.50)', 'Capers (+1.50)', 'Hot Peppers (+1.00)']
    ),

    // Classic and Widely Sold Pizzas
    (
      l10n.pizzaMargherita,
      l10n.pizzaMargheritaDesc,
      12.0,
      true,
      'assets/images/margherita-pizza.jpg',
      l10n.pizzaMargheritaFullDesc,
      ['San Marzano Tomatoes', 'Fresh Mozzarella', 'Basil Leaves', 'Extra Virgin Olive Oil', 'Sea Salt'],
      ['Truffle Oil Drizzle (+3.00)', 'Arugula (+2.50)', 'Prosciutto (+4.00)']
    ),
    (
      l10n.pizzaPepperoniClassic,
      l10n.pizzaPepperoniClassicDesc,
      13.0,
      false,
      'assets/images/Classic-Pepperoni-Pizza.jpg',
      l10n.pizzaPepperoniClassicFullDesc,
      ['House Tomato Sauce', 'Mozzarella', 'Classic Pepperoni', 'Oregano', 'Garlic Powder'],
      ['Extra Pepperoni (+2.50)', 'Hot Honey (+1.50)', 'Red Onions (+1.00)']
    ),
    (
      l10n.pizzaCheeseClassic,
      l10n.pizzaCheeseClassicDesc,
      11.0,
      true,
      'assets/images/Cheese_Classic_Pizza.jpg',
      l10n.pizzaCheeseClassicFullDesc,
      ['House Tomato Sauce', 'Premium Mozzarella', 'Extra Virgin Olive Oil', 'Fresh Basil'],
      ['Extra Cheese (+2.00)', 'Basil (+1.50)', 'Hot Oil (+1.00)']
    ),
    (
      l10n.pizzaVeggieClassic,
      l10n.pizzaVeggieClassicDesc,
      12.5,
      true,
      'assets/images/veggie-pizza.png',
      l10n.pizzaVeggieClassicFullDesc,
      ['Bell Peppers', 'Red Onions', 'Black Olives', 'Mushrooms', 'Tomato Sauce', 'Mozzarella'],
      ['Extra Veggies (+2.00)', 'Feta Cheese (+2.50)', 'Artichokes (+2.50)']
    ),
    (
      l10n.pizzaCapreseHitman,
      l10n.pizzaCapreseHitmanDesc,
      14.0,
      true,
      'assets/images/caprese-pizza.jpeg',
      l10n.pizzaCapreseHitmanFullDesc,
      ['Heirloom Tomatoes', 'Fresh Mozzarella', 'Basil', 'Balsamic Reduction', 'Extra Virgin Olive Oil'],
      ['Extra Tomatoes (+2.00)', 'Burrata (+3.50)', 'Pine Nuts (+2.50)']
    ),
    (
      l10n.pizzaTruffleWhiteHit,
      l10n.pizzaTruffleWhiteHitDesc,
      16.0,
      true,
      'assets/images/Truffle-White-Pizza.jpg',
      l10n.pizzaTruffleWhiteHitFullDesc,
      ['Ricotta Cheese', 'Parmesan', 'Black Truffle', 'Garlic', 'Fresh Herbs', 'Mozzarella'],
      ['Extra Truffle (+5.00)', 'Prosciutto (+4.00)', 'Arugula (+2.50)']
    ),
    (
      l10n.pizzaBrickOvenDon,
      l10n.pizzaBrickOvenDonDesc,
      17.0,
      false,
      'assets/images/brick-oven-pizza.webp',
      l10n.pizzaBrickOvenDonFullDesc,
      ['Type 00 Flour Crust', 'San Marzano Tomatoes', 'Fresh Mozzarella', 'Basil Oil', 'Sea Salt'],
      ['Extra Basil Oil (+1.50)', 'Anchovies (+3.00)', 'Olives (+1.50)']
    ),
    (
      l10n.pizzaSmokyCapoBBQ,
      l10n.pizzaSmokyCapoBBQDesc,
      15.0,
      false,
      'assets/images/smoke-bbq-pizza.jpg',
      l10n.pizzaSmokyCapoBBQFullDesc,
      ['House BBQ Sauce', 'Smoked Brisket', 'Red Onions', 'Cheddar Cheese', 'Cilantro'],
      ['Extra BBQ Sauce (+1.50)', 'Jalapeños (+1.00)', 'Corn (+2.00)']
    ),
    (
      l10n.pizzaVelvetPepperoni,
      l10n.pizzaVelvetPepperoniDesc,
      15.5,
      false,
      'assets/images/velvet-pepperoni-pizza.jpg',
      l10n.pizzaVelvetPepperoniFullDesc,
      ['House Tomato Sauce', 'Premium Pepperoni', 'Mozzarella', 'Oregano', 'Garlic'],
      ['Extra Pepperoni (+2.50)', 'Hot Honey (+1.50)', 'Red Pepper Flakes (+1.00)']
    ),
    ];
  }

  double getTotalPrice() {
    final l10n = AppLocalizations.of(context)!;
    final items = _getItems(l10n);
    double basePrice = widget.itemIndex < items.length ? items[widget.itemIndex].$3 : items.first.$3;

    // Size multiplier
    double sizeMultiplier = selectedSize == 'Solo' ? 1.0 :
                           selectedSize == 'Crew' ? 1.5 : 2.0;

    // Toppings cost
    double toppingsCost = 0.0;
    for (String topping in selectedToppings) {
      // Extract price from topping string (format: "Name (+price)")
      RegExp priceRegex = RegExp(r'\(\+\$(\d+\.?\d*)\)');
      Match? match = priceRegex.firstMatch(topping);
      if (match != null) {
        toppingsCost += double.parse(match.group(1)!);
      }
    }

    return (basePrice * sizeMultiplier) + toppingsCost;
  }

  Future<void> _addToCart(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final items = _getItems(l10n);
    final item = widget.itemIndex < items.length ? items[widget.itemIndex] : items.first;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    final cartItem = CartItem(
      id: '${item.$1}_${DateTime.now().millisecondsSinceEpoch}',
      name: item.$1,
      description: item.$2,
      basePrice: item.$3,
      isVegetarian: item.$4,
      imagePath: item.$5,
      selectedSize: selectedSize,
      selectedToppings: selectedToppings.toList(),
    );

    await cartProvider.addItem(cartItem);

    // Show snackbar with cart info
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF00E676),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.check, color: Colors.black, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.addedToCart,
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: const Color(0xFFFFF8E1),
                      ),
                    ),
                    Text(
                      '${l10n.cartItems} (${cartProvider.totalQuantity})',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFD4AF7A),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  context.go('/cart');
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFC6A667),
                  foregroundColor: const Color(0xFF0F0F0F),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  l10n.viewCart,
                  style: GoogleFonts.cinzel(
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xFF1C1512),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFFC6A667), width: 1.5),
        ),
        duration: const Duration(seconds: 4),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = _getItems(l10n);
    final item = widget.itemIndex < items.length ? items[widget.itemIndex] : items.first;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.$1.toUpperCase(),
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w900,
            fontSize: 18,
            letterSpacing: 1.2,
            color: const Color(0xFFFFF8E1),
          ),
        ),
        backgroundColor: const Color(0xFF1C1512),
        foregroundColor: const Color(0xFFF5E8C7),
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0x33),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF5E8C7)),
          onPressed: () => context.go('/menu'),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F0F0F), Color(0xFF1C1512)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFC6A667).withValues(alpha: 0x4D), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0x33),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: SizedBox(
                    height: 240,
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(Color(0x330B0C10), BlendMode.darken),
                      child: Image.asset(
                        item.$5,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(color: const Color(0x550F0F0F)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Spice Level Indicator
              Builder(
                builder: (context) {
                  final spiceLevel = getSpiceLevel(item.$1, item.$2);
                  if (spiceLevel.isEmpty) return const SizedBox.shrink();
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7A1F1F).withValues(alpha: 0xCC),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFC6A667), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0x26),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.heatLevel,
                          style: GoogleFonts.cinzel(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: const Color(0xFFC6A667),
                            letterSpacing: 1.0,
                          ),
                        ),
                        Text(
                          spiceLevel,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFFF5E8C7),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Detailed Description Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F0F).withValues(alpha: 0xCC),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF878787), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0x33),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      l10n.aboutThisPizza,
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        color: const Color(0xFFD4AF7A),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.$6,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFFFF8E1),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Ingredients Section
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF878787), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0x33),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      l10n.ingredients,
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        color: const Color(0xFF000000),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: item.$7.map<Widget>((ingredient) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC6A667).withValues(alpha: 0x19),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFC6A667).withValues(alpha: 0x4D), width: 1),
                        ),
                        child: Text(
                          ingredient,
                          style: const TextStyle(
                            color: Color(0xFF1C1512),
                            fontSize: 12,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Special Toppings Section
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F0F).withValues(alpha: 0xCC),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF878787), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0x33),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      l10n.specialToppings,
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        color: const Color(0xFFD4AF7A),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...item.$8.map<Widget>((topping) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: selectedToppings.contains(topping) ?
                            const Color(0xFFC6A667) :
                            const Color(0xFF1C1512).withValues(alpha: 0x80),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: selectedToppings.contains(topping) ?
                              const Color(0xFFC6A667) :
                              const Color(0xFF878787),
                            width: selectedToppings.contains(topping) ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                topping,
                                style: TextStyle(
                                  color: selectedToppings.contains(topping) ?
                                    const Color(0xFF000000) :
                                    const Color(0xFFF5E8C7),
                                  fontSize: 13,
                                  fontFamily: 'Lato',
                                  fontWeight: selectedToppings.contains(topping) ?
                                    FontWeight.w700 : FontWeight.w400,
                                ),
                              ),
                            ),
                            Checkbox(
                              value: selectedToppings.contains(topping),
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    selectedToppings.add(topping);
                                  } else {
                                    selectedToppings.remove(topping);
                                  }
                                });
                              },
                              activeColor: const Color(0xFFC6A667),
                              checkColor: const Color(0xFF0F0F0F),
                            ),
                          ],
                        ),
                      ),
                    )).toList(),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Size Options and Action Buttons
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF7A1F1F).withValues(alpha: 0x66),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFC6A667), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0x26),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      l10n.sizeOptions,
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        color: const Color(0xFFD4AF7A),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        (l10n.solo, 'Solo'),
                        (l10n.crew, 'Crew'),
                        (l10n.family, 'Family'),
                      ]
                          .map<Widget>((size) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSize = size.$2;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: size.$2 == selectedSize ? const Color(0xFFC6A667) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: const Color(0xFFC6A667),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Text(
                                    size.$1.toUpperCase(),
                                    style: TextStyle(
                                      color: size.$2 == selectedSize ? const Color(0xFF0F0F0F) : const Color(0xFFF5E8C7),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Action Buttons and Info
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F0F).withValues(alpha: 0xE6),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF878787), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0x33),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _addToCart(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC6A667),
                          foregroundColor: const Color(0xFF0F0F0F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                          shadowColor: Colors.black.withValues(alpha: 0x33),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(
                          l10n.addToCartButton,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1512).withValues(alpha: 0xE6),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF878787), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0x26),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: Color(0xFFC6A667),
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${l10n.houseNotes} ${item.$2.split('.').first}. ${l10n.addTruffleDrizzle}',
                              style: TextStyle(
                                color: const Color(0xFFC6A667).withValues(alpha: 0xCC),
                                fontSize: 12,
                                fontFamily: 'Lato',
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}
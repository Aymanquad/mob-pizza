import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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

  final List items = [
    // International Variations
    (
      'Japanese-Inspired',
      'Seafood, mayo, teriyaki elements.',
      16.5,
      false,
      'assets/images/japanese-inspired-pizza.jpg',
      'A fusion masterpiece blending Japanese flavors with Italian technique. Fresh sushi-grade tuna, creamy mayo, and teriyaki glaze create an unexpected harmony. The nori and sesame seeds add texture and umami depth that will transport your taste buds to new territories.',
      ['Sushi Tuna', 'Japanese Mayo', 'Teriyaki Glaze', 'Nori', 'Sesame Seeds', 'Cucumber'],
      ['Extra Tuna (+4.00)', 'Spicy Mayo (+1.50)', 'Wasabi (+1.00)']
    ),
    (
      'Indian-Inspired',
      'Paneer, tandoori toppings, spiced sauces.',
      15.0,
      true,
      'assets/images/indian-inspired-pizza.jpg',
      'Experience the vibrant flavors of India reimagined on a crispy crust. Tandoori-marinated paneer, pickled onions, and cilantro chutney create a symphony of spice and freshness. This pizza bridges two culinary worlds with remarkable harmony and bold character.',
      ['Tandoori Paneer', 'Pickled Onions', 'Cilantro Chutney', 'Mozzarella', 'Garam Masala'],
      ['Extra Paneer (+3.00)', 'Mango Chutney (+1.50)', 'Chili Flakes (+1.00)']
    ),
    (
      'Turkish Pide',
      'Boat-shaped flatbread with toppings.',
      17.5,
      false,
      'assets/images/turkish-pide-pizza.webp',
      'Authentic Turkish pide featuring a boat-shaped crust filled with seasoned ground lamb, onions, and peppers. The dough is stretched thin and folded to create the perfect vessel for these aromatic fillings. A taste of Istanbul\'s bustling streets in every bite.',
      ['Ground Lamb', 'Onions', 'Bell Peppers', 'Tomatoes', 'Yogurt Sauce', 'Sumac'],
      ['Extra Lamb (+3.50)', 'Feta Cheese (+2.00)', 'Hot Sauce (+1.00)']
    ),
    (
      'Brazilian',
      'Sweet/dessert-style options alongside savory.',
      14.5,
      false,
      'assets/images/Brazilian-inspired-Pizza.jpg',
      'A celebration of Brazilian flavors featuring tropical hearts of palm, corn, and coconut flakes. The unique combination of sweet and savory elements reflects Brazil\'s diverse culinary heritage. Light, refreshing, and utterly unique.',
      ['Hearts of Palm', 'Corn', 'Coconut Flakes', 'Catupiry Cheese', 'Tomato Sauce'],
      ['Extra Catupiry (+2.50)', 'Pineapple (+2.00)', 'Cilantro (+1.50)']
    ),

    // Speciality and Alternative Bases
    (
      'Gluten-Free Pizza',
      'Alternative flours, crafted for a lighter base.',
      16.0,
      true,
      'assets/images/gluten-free-pizza.jpg',
      'Our gluten-free crust uses a special blend of rice and tapioca flours for that perfect texture. Topped with fresh vegetables and our signature sauce, this pizza proves that dietary restrictions don\'t mean compromising on flavor.',
      ['Gluten-Free Crust', 'Tomato Sauce', 'Mozzarella', 'Bell Peppers', 'Onions', 'Mushrooms'],
      ['Dairy-Free Cheese (+2.00)', 'Extra Veggies (+2.00)', 'Olives (+1.50)']
    ),
    (
      'Vegan Pizza',
      'Plant-based cheese and toppings; no animal products.',
      15.5,
      true,
      'assets/images/vegan-pizza.jpg',
      'A compassionate creation featuring plant-based cheese, fresh vegetables, and house-made vegan tomato sauce. Every ingredient is carefully selected to ensure both flavor and ethics are satisfied. Delicious food that does good.',
      ['Vegan Cheese', 'Vegan Tomato Sauce', 'Bell Peppers', 'Onions', 'Mushrooms', 'Fresh Basil'],
      ['Vegan Pepperoni (+3.00)', 'Pineapple (+2.00)', 'Jalapeños (+1.00)']
    ),
    (
      'Stuffed Crust',
      'Cheese-filled crust edge for the indulgent.',
      17.0,
      false,
      'assets/images/stuffed-crust-pizza.jpg',
      'The ultimate indulgence featuring a crust stuffed with gooey mozzarella cheese. Every bite includes that extra stretch of melted cheese. Topped with pepperoni and our signature sauce, this is pizza\'s answer to a warm hug.',
      ['Stuffed Cheese Crust', 'Pepperoni', 'Mozzarella', 'Tomato Sauce', 'Garlic Butter'],
      ['Extra Stuffed Crust (+2.50)', 'Sausage (+3.00)', 'Mushrooms (+1.50)']
    ),
    (
      'White Pizza',
      'Ricotta, mozzarella, olive oil, garlic—no tomato sauce.',
      15.0,
      true,
      'assets/images/white-pizza.jpg',
      'A sophisticated departure from the red sauce crowd. Creamy ricotta and mozzarella mingle with roasted garlic and fresh herbs on a perfectly baked crust. The absence of tomato sauce lets the pure, dairy-forward flavors shine through.',
      ['Ricotta Cheese', 'Mozzarella', 'Roasted Garlic', 'Fresh Herbs', 'Extra Virgin Olive Oil'],
      ['Truffle Oil (+3.00)', 'Prosciutto (+4.00)', 'Arugula (+2.50)']
    ),

    // American Regional Style
    (
      'New York Style',
      'Large, foldable slices; thin but sturdy crust.',
      14.0,
      false,
      'assets/images/new-york-style-pizza.jpg',
      'The quintessential New York slice that made pizza famous worldwide. Thin, foldable crust with just the right amount of char. Premium pepperoni and our house tomato sauce create that perfect ratio of crust to topping that defines NYC pizza perfection.',
      ['Thin Crust', 'House Tomato Sauce', 'Premium Pepperoni', 'Mozzarella', 'Oregano'],
      ['Extra Pepperoni (+2.50)', 'Mushrooms (+1.50)', 'Sausage (+3.00)']
    ),
    (
      'Chicago Deep Dish',
      'Thick, pie-like crust with layered cheese and sauce.',
      18.0,
      false,
      'assets/images/chicago-style-pizza.jpg',
      'The king of deep dish pizzas, built in a cast-iron skillet for that perfect buttery crust. Layered cheese and chunky tomato sauce create a hearty, satisfying pie that\'s more casserole than pizza. A Chicago institution worth every calorie.',
      ['Buttery Deep Crust', 'Italian Sausage', 'Mozzarella', 'Parmesan', 'Chunky Tomato Sauce'],
      ['Extra Sausage (+3.00)', 'Mushrooms (+1.50)', 'Green Peppers (+1.50)']
    ),
    (
      'Detroit Style',
      'Rectangular pan, caramelized cheese edges.',
      17.5,
      false,
      'assets/images/detroit-style-pizza.jpg',
      'Detroit\'s answer to the deep dish, featuring a rectangular pan that creates those legendary caramelized cheese edges. The crispy bottom and cheesy perimeter make this style uniquely addictive. Brick cheese and pepperoni create the perfect Motor City experience.',
      ['Brick Cheese', 'Premium Pepperoni', 'Detroit Tomato Sauce', 'Oregano', 'Garlic'],
      ['Extra Cheese (+2.00)', 'Hot Honey (+1.50)', 'Jalapeños (+1.00)']
    ),
    (
      'California Style',
      'Thin crust with unconventional fresh toppings.',
      15.0,
      false,
      'assets/images/california-style-pizza.jpg',
      'California dreaming on a crust featuring goat cheese, walnuts, and fresh figs. This innovative style broke all the rules when it debuted, proving that pizza could be both gourmet and approachable. A celebration of fresh, seasonal ingredients.',
      ['Goat Cheese', 'Walnuts', 'Fresh Figs', 'Arugula', 'Balsamic Glaze'],
      ['Prosciutto (+4.00)', 'Extra Figs (+2.50)', 'Honey Drizzle (+1.50)']
    ),

    // Italian Style
    (
      'Neapolitan',
      'Thin, soft, wood-fired with blistered edges.',
      15.5,
      true,
      'assets/images/neapolitan-style-pizza.webp',
      'Authentic Neapolitan pizza as it\'s meant to be eaten. High-hydration dough creates that perfect leopard spotting when cooked at 900°F in our wood-fired oven. Fresh, simple ingredients that capture the essence of Naples in every tender bite.',
      ['High-Hydration Dough', 'San Marzano Tomatoes', 'Fresh Mozzarella', 'Basil', 'Sea Salt'],
      ['Extra Mozzarella (+2.00)', 'Anchovies (+3.00)', 'Hot Peppers (+1.00)']
    ),
    (
      'Roman al Taglio',
      'Rectangular, thin, crisp; sold by the slice.',
      16.0,
      false,
      'assets/images/Romanaltaglio-Style-Pizza.webp',
      'Roman-style pizza that\'s all about sharing. Thin, crisp crust topped with seasonal ingredients and cut into rectangles. The perfect canvas for creative toppings and communal dining. Each slice tells its own story of Roman culinary tradition.',
      ['Roman Thin Crust', 'Seasonal Toppings', 'Mozzarella', 'Tomato Sauce', 'Fresh Herbs'],
      ['Prosciutto (+4.00)', 'Artichokes (+2.50)', 'Buffalo Mozzarella (+3.00)']
    ),
    (
      'Sicilian (Sfinciuni)',
      'Thick, airy crust; onion-forward sauce.',
      16.5,
      false,
      'assets/images/Sicilian-Pizza.webp',
      'Thick, focaccia-like crust topped with sweet onions, anchovies, and herbs. This Sicilian classic features a bread-like base that\'s perfect for soaking up the savory tomato sauce. A hearty, flavorful experience that\'s uniquely Sicilian.',
      ['Thick Focaccia Crust', 'Sweet Onions', 'Anchovies', 'Tomato Sauce', 'Oregano', 'Caciocavallo Cheese'],
      ['Extra Onions (+1.50)', 'Capers (+1.50)', 'Hot Peppers (+1.00)']
    ),

    // Classic and Widely Sold Pizzas
    (
      'Margherita – The Mistress',
      'Thin crust trusted by the Don.',
      12.0,
      true,
      'assets/images/margherita-pizza.jpg',
      'A masterpiece of simplicity, this classic Margherita combines the freshest San Marzano tomatoes, creamy mozzarella di bufala, and fragrant basil leaves. Each bite tells a story of Italian tradition, where the perfect balance of flavors creates an unforgettable experience that has stood the test of time.',
      ['San Marzano Tomatoes', 'Fresh Mozzarella', 'Basil Leaves', 'Extra Virgin Olive Oil', 'Sea Salt'],
      ['Truffle Oil Drizzle (+3.00)', 'Arugula (+2.50)', 'Prosciutto (+4.00)']
    ),
    (
      'Pepperoni Classic',
      'Tomato sauce, mozzarella, pepperoni slices.',
      13.0,
      false,
      'assets/images/Classic-Pepperoni-Pizza.jpg',
      'The pizza that started it all. Simple, perfect, and utterly satisfying. Our house tomato sauce, premium mozzarella, and classic pepperoni slices come together in perfect harmony. Sometimes the classics are classics for a reason.',
      ['House Tomato Sauce', 'Mozzarella', 'Classic Pepperoni', 'Oregano', 'Garlic Powder'],
      ['Extra Pepperoni (+2.50)', 'Hot Honey (+1.50)', 'Red Onions (+1.00)']
    ),
    (
      'Cheese Classic',
      'Tomato sauce and mozzarella; minimalist and comforting.',
      11.0,
      true,
      'assets/images/Cheese_Classic_Pizza.jpg',
      'Pure, unadulterated pizza perfection. Just our house tomato sauce, premium mozzarella, and a kiss of olive oil. This minimalist approach lets the quality of our ingredients shine through. Simple ingredients, simply extraordinary.',
      ['House Tomato Sauce', 'Premium Mozzarella', 'Extra Virgin Olive Oil', 'Fresh Basil'],
      ['Extra Cheese (+2.00)', 'Basil (+1.50)', 'Hot Oil (+1.00)']
    ),
    (
      'Veggie Classic',
      'Peppers, onions, olives, mushrooms.',
      12.5,
      true,
      'assets/images/veggie-pizza.png',
      'A garden-fresh celebration of vegetables done right. Crisp bell peppers, sweet onions, briny olives, and earthy mushrooms create a symphony of textures and flavors. Our vegetarian masterpiece proves that meat isn\'t necessary for extraordinary pizza.',
      ['Bell Peppers', 'Red Onions', 'Black Olives', 'Mushrooms', 'Tomato Sauce', 'Mozzarella'],
      ['Extra Veggies (+2.00)', 'Feta Cheese (+2.50)', 'Artichokes (+2.50)']
    ),
    (
      'Caprese Hitman',
      'Fresh mozz, basil, olive mafia drizzle.',
      14.0,
      true,
      'assets/images/caprese-pizza.jpeg',
      'A Sicilian-inspired masterpiece featuring the classic Caprese combination elevated to perfection. Juicy heirloom tomatoes, creamy fresh mozzarella, and fragrant basil come together with our signature olive oil reduction. Each slice captures the essence of Mediterranean sunshine.',
      ['Heirloom Tomatoes', 'Fresh Mozzarella', 'Basil', 'Balsamic Reduction', 'Extra Virgin Olive Oil'],
      ['Extra Tomatoes (+2.00)', 'Burrata (+3.50)', 'Pine Nuts (+2.50)']
    ),
    (
      'Truffle White Hit',
      'White sauce, parmesan rain.',
      16.0,
      true,
      'assets/images/Truffle-White-Pizza.jpg',
      'Indulge in luxury with our truffle-infused white pizza. Creamy ricotta and parmesan create a velvety canvas for earthy black truffles and fresh herbs. This sophisticated creation elevates the simple white pizza to a gourmet experience worthy of the finest Italian trattorias.',
      ['Ricotta Cheese', 'Parmesan', 'Black Truffle', 'Garlic', 'Fresh Herbs', 'Mozzarella'],
      ['Extra Truffle (+5.00)', 'Prosciutto (+4.00)', 'Arugula (+2.50)']
    ),
    (
      'Brick Oven Don',
      'Fire-kissed crust, basil oil.',
      17.0,
      false,
      'assets/images/brick-oven-pizza.webp',
      'Experience the authentic taste of Naples with our wood-fired pizza baked in a traditional brick oven. The high-heat cooking creates that perfect leopard spotting on the crust while preserving the delicate balance of fresh ingredients and aromatic basil-infused olive oil.',
      ['Type 00 Flour Crust', 'San Marzano Tomatoes', 'Fresh Mozzarella', 'Basil Oil', 'Sea Salt'],
      ['Extra Basil Oil (+1.50)', 'Anchovies (+3.00)', 'Olives (+1.50)']
    ),
    (
      'Smoky Capo BBQ',
      'Brick oven, sweet heat.',
      15.0,
      false,
      'assets/images/smoke-bbq-pizza.jpg',
      'Our signature BBQ pizza brings together the smoky depth of slow-cooked brisket with tangy house-made BBQ sauce and caramelized onions. The perfect marriage of Southern comfort and Italian tradition creates a flavor profile that\'s equal parts comforting and crave-worthy.',
      ['House BBQ Sauce', 'Smoked Brisket', 'Red Onions', 'Cheddar Cheese', 'Cilantro'],
      ['Extra BBQ Sauce (+1.50)', 'Jalapeños (+1.00)', 'Corn (+2.00)']
    ),
    (
      'Velvet Pepperoni',
      'Loaded curls, velvet cheese pull.',
      15.5,
      false,
      'assets/images/velvet-pepperoni-pizza.jpg',
      'Our take on the classic pepperoni pizza features premium pepperoni cups that curl perfectly during baking, creating crispy edges and juicy centers. Combined with our house tomato sauce and stretchy mozzarella, this is comfort food at its finest.',
      ['House Tomato Sauce', 'Premium Pepperoni', 'Mozzarella', 'Oregano', 'Garlic'],
      ['Extra Pepperoni (+2.50)', 'Hot Honey (+1.50)', 'Red Pepper Flakes (+1.00)']
    ),
  ];

  double getTotalPrice() {
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final item = widget.itemIndex < items.length ? items[widget.itemIndex] : items.first;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.$1.toUpperCase(),
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w900,
            fontSize: 18,
            letterSpacing: 1.2,
            shadows: const [
              Shadow(
                color: Color(0xFFC6A667),
                offset: Offset(0, 0),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xFF1C1512),
        foregroundColor: const Color(0xFFF5E8C7),
        elevation: 8,
        shadowColor: const Color(0xFFC6A667).withValues(alpha: 0x4D),
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
                      color: const Color(0xFFC6A667).withValues(alpha: 0x33),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0x80),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
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
                          color: const Color(0xFFC6A667).withValues(alpha: 0x33),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'HEAT LEVEL: ',
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
                      color: const Color(0xFFC6A667).withValues(alpha: 0x26),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0x66),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'ABOUT THIS PIZZA',
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        color: const Color(0xFFC6A667),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.$6,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFF5E8C7),
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
                  color: const Color(0xFF0F0F0F).withValues(alpha: 0xCC),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF878787), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFC6A667).withValues(alpha: 0x26),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0x66),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'INGREDIENTS',
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        color: const Color(0xFFC6A667),
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
                            color: Color(0xFFF5E8C7),
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
                      color: const Color(0xFFC6A667).withValues(alpha: 0x26),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0x66),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'SPECIAL TOPPINGS',
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        color: const Color(0xFFC6A667),
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
                            const Color(0xFFC6A667).withValues(alpha: 0x33) :
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
                                    const Color(0xFFC6A667) :
                                    const Color(0xFFF5E8C7),
                                  fontSize: 13,
                                  fontFamily: 'Lato',
                                  fontWeight: selectedToppings.contains(topping) ?
                                    FontWeight.w600 : FontWeight.w400,
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
                      color: const Color(0xFFC6A667).withValues(alpha: 0x33),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'SIZE OPTIONS',
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        color: const Color(0xFFC6A667),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: ['Solo', 'Crew', 'Family']
                          .map<Widget>((size) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSize = size;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: size == selectedSize ? const Color(0xFFC6A667) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: const Color(0xFFC6A667),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Text(
                                    size.toUpperCase(),
                                    style: TextStyle(
                                      color: size == selectedSize ? const Color(0xFF0F0F0F) : const Color(0xFFF5E8C7),
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
                      color: Colors.black.withValues(alpha: 0x80),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => context.go('/cart'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC6A667),
                              foregroundColor: const Color(0xFF0F0F0F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              shadowColor: const Color(0xFFC6A667).withValues(alpha: 0x4D),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text(
                              'ADD TO HIT LIST',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => context.go('/checkout'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7A1F1F),
                              foregroundColor: const Color(0xFFF5E8C7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              shadowColor: const Color(0xFF7A1F1F).withValues(alpha: 0x4D),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text(
                              'PROCEED TO DEAL',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ),
                      ],
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
                            color: Colors.black.withValues(alpha: 0x4D),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
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
                              'House Notes: ${item.$2.split('.').first}. Add truffle drizzle for a small upcharge.',
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
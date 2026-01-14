import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mob_pizza_mobile/providers/cart_provider.dart';
import 'package:mob_pizza_mobile/models/cart_item.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';

class ItemDetailScreen extends StatefulWidget {
  final int itemIndex;
  final CartItem? cartItemForEdit;
  const ItemDetailScreen({
    super.key, 
    required this.itemIndex,
    this.cartItemForEdit,
  });

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  String selectedSize = '10"'; // Default to 10" for pizzas
  Set<String> selectedToppings = {};
  List<String> selectedPizzaSlices = []; // For combos with slices
  int? _actualItemIndex; // Will be set based on cart item name if editing

  // 5 pizzas available for slice selection in combos
  List<String> getAvailableSlicePizzas(AppLocalizations l10n) {
    return [
      l10n.pizzaPepperoniClassic,
      l10n.pizzaSupreme,
      l10n.pizzaMargherita,
      l10n.pizzaCheeseClassic,
      l10n.pizzaVeggieClassic,
    ];
  }

  bool isComboWithSlices(String itemName, AppLocalizations l10n) {
    final lowerName = itemName.toLowerCase();
    return lowerName.contains(l10n.combo2SlicesDrink.toLowerCase()) ||
           lowerName.contains(l10n.comboSliceDrink.toLowerCase()) ||
           lowerName.contains(l10n.comboSliceWingsSoda.toLowerCase());
  }

  // Helper function to check if item should show size options (ONLY pizzas)
  bool shouldShowSizeOptions(String itemName, AppLocalizations l10n, List toppings) {
    final lowerName = itemName.toLowerCase();
    
    // Check against actual localized names (exact match) OR check if toppings array is empty (indicates dip/drink)
    final isDip = itemName == l10n.dipHoneyMustard ||
                  itemName == l10n.dipItalianDressing ||
                  itemName == l10n.dipGarlic ||
                  itemName == l10n.dipParmesan ||
                  itemName == l10n.dipRanch ||
                  itemName == l10n.dipBlueCheese ||
                  lowerName.contains('dip') ||
                  lowerName.contains('honey mustard') ||
                  lowerName.contains('italian dressing') ||
                  lowerName.contains('ranch') ||
                  lowerName.contains('blue cheese') ||
                  (toppings.isEmpty && (lowerName.contains('mustard') || lowerName.contains('dressing') || lowerName.contains('parmesan')));
    
    final isDrink = itemName == l10n.drink2Liter ||
                    itemName == l10n.drink16oz ||
                    lowerName.contains('drink') ||
                    lowerName.contains('liter') ||
                    (toppings.isEmpty && lowerName.contains('oz'));
    
    final isDessert = itemName == l10n.dessertChocolateChipCookiePizza ||
                      itemName == l10n.dessertChocolateChurros ||
                      itemName == l10n.dessertCheesecake ||
                      itemName == l10n.dessertFreshCannoli ||
                      lowerName.contains('dessert') ||
                      lowerName.contains('churros') ||
                      lowerName.contains('cheesecake') ||
                      lowerName.contains('cookie pizza') ||
                      lowerName.contains('chocolate chip cookie') ||
                      lowerName.contains('cannoli');
    
    final isPasta = itemName == l10n.pastaChickenAlfredo ||
                    (lowerName.contains('pasta') && lowerName.contains('alfredo')) ||
                    (lowerName.contains('pasta') && !lowerName.contains('pizza'));
    
    final isCombo = isComboWithSlices(itemName, l10n) ||
                    lowerName.contains('combo') ||
                    lowerName.contains('slice') && lowerName.contains('drink');
    
    final isSalad = lowerName.contains('salad');
    final isFries = lowerName.contains('fries');
    
    final isWings = itemName == l10n.wingsBuffalo ||
                    itemName == l10n.wingsGarlicParmesan ||
                    itemName == l10n.wingsBBQ ||
                    itemName == l10n.wingsMangoHabanero ||
                    itemName == l10n.wingsLemonPepper ||
                    itemName == l10n.wingsHotHoney ||
                    lowerName.contains('wings');
    
    // If it's any of these categories, don't show size options
    if (isDip || isDrink || isDessert || isPasta || isCombo || isSalad || isFries || isWings) {
      return false;
    }
    
    // Only pizzas should show size options
    return true;
  }

  // Helper function to check if item should show special toppings
  bool shouldShowSpecialToppings(String itemName, AppLocalizations l10n, List toppings) {
    final lowerName = itemName.toLowerCase();
    
    // Check against actual localized names (exact match) OR check if toppings array is empty (indicates dip/drink/dessert)
    final isDip = itemName == l10n.dipHoneyMustard ||
                  itemName == l10n.dipItalianDressing ||
                  itemName == l10n.dipGarlic ||
                  itemName == l10n.dipParmesan ||
                  itemName == l10n.dipRanch ||
                  itemName == l10n.dipBlueCheese ||
                  lowerName.contains('dip') ||
                  lowerName.contains('honey mustard') ||
                  lowerName.contains('italian dressing') ||
                  lowerName.contains('ranch') ||
                  lowerName.contains('blue cheese') ||
                  (toppings.isEmpty && (lowerName.contains('mustard') || lowerName.contains('dressing') || lowerName.contains('parmesan')));
    
    final isDrink = itemName == l10n.drink2Liter ||
                    itemName == l10n.drink16oz ||
                    lowerName.contains('drink') ||
                    lowerName.contains('liter') ||
                    (toppings.isEmpty && lowerName.contains('oz'));
    
    final isDessert = itemName == l10n.dessertChocolateChipCookiePizza ||
                      itemName == l10n.dessertChocolateChurros ||
                      itemName == l10n.dessertCheesecake ||
                      itemName == l10n.dessertFreshCannoli ||
                      lowerName.contains('dessert') ||
                      lowerName.contains('churros') ||
                      lowerName.contains('cheesecake') ||
                      lowerName.contains('cookie pizza') ||
                      lowerName.contains('chocolate chip cookie') ||
                      lowerName.contains('cannoli');
    
    final isCombo = isComboWithSlices(itemName, l10n) ||
                    lowerName.contains('combo') ||
                    (lowerName.contains('slice') && lowerName.contains('drink'));
    
    // If it's any of these categories, don't show toppings
    if (isDip || isDrink || isDessert || isCombo) {
      return false;
    }
    
    // Show toppings for pizzas, salads, fries, pasta, wings
    return true;
  }

  int getRequiredSliceCount(String itemName, AppLocalizations l10n) {
    final lowerName = itemName.toLowerCase();
    if (lowerName.contains(l10n.combo2SlicesDrink.toLowerCase())) {
      return 2;
    }
    return 1; // For slice + drink or slice + wings
  }

  @override
  void initState() {
    super.initState();
    // If editing a cart item, pre-populate the fields
    if (widget.cartItemForEdit != null) {
      final cartItem = widget.cartItemForEdit!;
      selectedSize = cartItem.selectedSize.isNotEmpty ? cartItem.selectedSize : '10"';
      selectedToppings = Set<String>.from(cartItem.selectedToppings);
      
      // Restore combo pizza slice selections from description
      if (cartItem.description.contains('Selected slices:')) {
        final slicesMatch = RegExp(r'Selected slices:\s*(.+?)(?:\n|$)').firstMatch(cartItem.description);
        if (slicesMatch != null) {
          final slicesText = slicesMatch.group(1) ?? '';
          selectedPizzaSlices = slicesText.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
        }
      } else {
        // Also check if slices are stored in a different format
        // Some combos might store slices differently
        selectedPizzaSlices = [];
      }
      
      // Find the item index by matching the name
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          final l10n = AppLocalizations.of(context)!;
          final items = _getItems(l10n);
          final index = items.indexWhere((item) => item.$1 == cartItem.name);
          if (index >= 0) {
            setState(() {
              _actualItemIndex = index;
            });
          } else {
            // Item not found in menu (could be custom pizza or other custom item)
            // Keep _actualItemIndex as null, will use widget.itemIndex (0) as fallback
            debugPrint('[ItemDetailScreen] Cart item "${cartItem.name}" not found in menu items');
          }
        }
      });
    }
    // Size will be initialized based on item type in build method
  }

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
    // COMMENTED OUT - Not in menu images
    // // International Variations
    // (
    //   l10n.pizzaJapaneseInspired,
    //   l10n.pizzaJapaneseInspiredDesc,
    //   16.5,
    //   false,
    //   'assets/images/japanese-inspired-pizza.jpg',
    //   l10n.pizzaJapaneseInspiredFullDesc,
    //   ['Sushi Tuna', 'Japanese Mayo', 'Teriyaki Glaze', 'Nori', 'Sesame Seeds', 'Cucumber'],
    //   ['Extra Tuna (+4.00)', 'Spicy Mayo (+1.50)', 'Wasabi (+1.00)']
    // ),
    // (
    //   l10n.pizzaIndianInspired,
    //   l10n.pizzaIndianInspiredDesc,
    //   15.0,
    //   true,
    //   'assets/images/indian-inspired-pizza.jpg',
    //   l10n.pizzaIndianInspiredFullDesc,
    //   ['Tandoori Paneer', 'Pickled Onions', 'Cilantro Chutney', 'Mozzarella', 'Garam Masala'],
    //   ['Extra Paneer (+3.00)', 'Mango Chutney (+1.50)', 'Chili Flakes (+1.00)']
    // ),
    // (
    //   l10n.pizzaTurkishPide,
    //   l10n.pizzaTurkishPideDesc,
    //   17.5,
    //   false,
    //   'assets/images/turkish-pide-pizza.webp',
    //   l10n.pizzaTurkishPideFullDesc,
    //   ['Ground Lamb', 'Onions', 'Bell Peppers', 'Tomatoes', 'Yogurt Sauce', 'Sumac'],
    //   ['Extra Lamb (+3.50)', 'Feta Cheese (+2.00)', 'Hot Sauce (+1.00)']
    // ),
    // (
    //   l10n.pizzaBrazilian,
    //   l10n.pizzaBrazilianDesc,
    //   14.5,
    //   false,
    //   'assets/images/Brazilian-inspired-Pizza.jpg',
    //   l10n.pizzaBrazilianFullDesc,
    //   ['Hearts of Palm', 'Corn', 'Coconut Flakes', 'Catupiry Cheese', 'Tomato Sauce'],
    //   ['Extra Catupiry (+2.50)', 'Pineapple (+2.00)', 'Cilantro (+1.50)']
    // ),

    // // Speciality and Alternative Bases
    // (
    //   l10n.pizzaGlutenFree,
    //   l10n.pizzaGlutenFreeDesc,
    //   16.0,
    //   true,
    //   'assets/images/gluten-free-pizza.jpg',
    //   l10n.pizzaGlutenFreeFullDesc,
    //   ['Gluten-Free Crust', 'Tomato Sauce', 'Mozzarella', 'Bell Peppers', 'Onions', 'Mushrooms'],
    //   ['Dairy-Free Cheese (+2.00)', 'Extra Veggies (+2.00)', 'Olives (+1.50)']
    // ),
    // (
    //   l10n.pizzaVegan,
    //   l10n.pizzaVeganDesc,
    //   15.5,
    //   true,
    //   'assets/images/vegan-pizza.jpg',
    //   l10n.pizzaVeganFullDesc,
    //   ['Vegan Cheese', 'Vegan Tomato Sauce', 'Bell Peppers', 'Onions', 'Mushrooms', 'Fresh Basil'],
    //   ['Vegan Pepperoni (+3.00)', 'Pineapple (+2.00)', 'Jalapeños (+1.00)']
    // ),
    // (
    //   l10n.pizzaStuffedCrust,
    //   l10n.pizzaStuffedCrustDesc,
    //   17.0,
    //   false,
    //   'assets/images/stuffed-crust-pizza.jpg',
    //   l10n.pizzaStuffedCrustFullDesc,
    //   ['Stuffed Cheese Crust', 'Pepperoni', 'Mozzarella', 'Tomato Sauce', 'Garlic Butter'],
    //   ['Extra Stuffed Crust (+2.50)', 'Sausage (+3.00)', 'Mushrooms (+1.50)']
    // ),
    // (
    //   l10n.pizzaWhite,
    //   l10n.pizzaWhiteDesc,
    //   15.0,
    //   true,
    //   'assets/images/white-pizza.jpg',
    //   l10n.pizzaWhiteFullDesc,
    //   ['Ricotta Cheese', 'Mozzarella', 'Roasted Garlic', 'Fresh Herbs', 'Extra Virgin Olive Oil'],
    //   ['Truffle Oil (+3.00)', 'Prosciutto (+4.00)', 'Arugula (+2.50)']
    // ),

    // // American Regional Style
    // (
    //   l10n.pizzaNewYorkStyle,
    //   l10n.pizzaNewYorkStyleDesc,
    //   14.0,
    //   false,
    //   'assets/images/new-york-style-pizza.jpg',
    //   l10n.pizzaNewYorkStyleFullDesc,
    //   ['Thin Crust', 'House Tomato Sauce', 'Premium Pepperoni', 'Mozzarella', 'Oregano'],
    //   ['Extra Pepperoni (+2.50)', 'Mushrooms (+1.50)', 'Sausage (+3.00)']
    // ),
    // (
    //   l10n.pizzaChicagoDeepDish,
    //   l10n.pizzaChicagoDeepDishDesc,
    //   18.0,
    //   false,
    //   'assets/images/chicago-style-pizza.jpg',
    //   l10n.pizzaChicagoDeepDishFullDesc,
    //   ['Buttery Deep Crust', 'Italian Sausage', 'Mozzarella', 'Parmesan', 'Chunky Tomato Sauce'],
    //   ['Extra Sausage (+3.00)', 'Mushrooms (+1.50)', 'Green Peppers (+1.50)']
    // ),
    // (
    //   l10n.pizzaDetroitStyle,
    //   l10n.pizzaDetroitStyleDesc,
    //   17.5,
    //   false,
    //   'assets/images/detroit-style-pizza.jpg',
    //   l10n.pizzaDetroitStyleFullDesc,
    //   ['Brick Cheese', 'Premium Pepperoni', 'Detroit Tomato Sauce', 'Oregano', 'Garlic'],
    //   ['Extra Cheese (+2.00)', 'Hot Honey (+1.50)', 'Jalapeños (+1.00)']
    // ),
    // (
    //   l10n.pizzaCaliforniaStyle,
    //   l10n.pizzaCaliforniaStyleDesc,
    //   15.0,
    //   false,
    //   'assets/images/california-style-pizza.jpg',
    //   l10n.pizzaCaliforniaStyleFullDesc,
    //   ['Goat Cheese', 'Walnuts', 'Fresh Figs', 'Arugula', 'Balsamic Glaze'],
    //   ['Prosciutto (+4.00)', 'Extra Figs (+2.50)', 'Honey Drizzle (+1.50)']
    // ),

    // // Italian Style
    // (
    //   l10n.pizzaNeapolitan,
    //   l10n.pizzaNeapolitanDesc,
    //   15.5,
    //   true,
    //   'assets/images/neapolitan-style-pizza.webp',
    //   l10n.pizzaNeapolitanFullDesc,
    //   ['High-Hydration Dough', 'San Marzano Tomatoes', 'Fresh Mozzarella', 'Basil', 'Sea Salt'],
    //   ['Extra Mozzarella (+2.00)', 'Anchovies (+3.00)', 'Hot Peppers (+1.00)']
    // ),
    // (
    //   l10n.pizzaRomanAlTaglio,
    //   l10n.pizzaRomanAlTaglioDesc,
    //   16.0,
    //   false,
    //   'assets/images/Romanaltaglio-Style-Pizza.webp',
    //   l10n.pizzaRomanAlTaglioFullDesc,
    //   ['Roman Thin Crust', 'Seasonal Toppings', 'Mozzarella', 'Tomato Sauce', 'Fresh Herbs'],
    //   ['Prosciutto (+4.00)', 'Artichokes (+2.50)', 'Buffalo Mozzarella (+3.00)']
    // ),
    // (
    //   l10n.pizzaSicilian,
    //   l10n.pizzaSicilianDesc,
    //   16.5,
    //   false,
    //   'assets/images/Sicilian-Pizza.webp',
    //   l10n.pizzaSicilianFullDesc,
    //   ['Thick Focaccia Crust', 'Sweet Onions', 'Anchovies', 'Tomato Sauce', 'Oregano', 'Caciocavallo Cheese'],
    //   ['Extra Onions (+1.50)', 'Capers (+1.50)', 'Hot Peppers (+1.00)']
    // ),

    // Classic and Widely Sold Pizzas
    // COMMENTED OUT - Not in menu images
    // (
    //   l10n.pizzaMargherita,
    //   l10n.pizzaMargheritaDesc,
    //   12.0,
    //   true,
    //   'assets/images/margherita-pizza.jpg',
    //   l10n.pizzaMargheritaFullDesc,
    //   ['San Marzano Tomatoes', 'Fresh Mozzarella', 'Basil Leaves', 'Extra Virgin Olive Oil', 'Sea Salt'],
    //   ['Truffle Oil Drizzle (+3.00)', 'Arugula (+2.50)', 'Prosciutto (+4.00)']
    // ),
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
      l10n.pizzaSupreme,
      l10n.pizzaSupremeDesc,
      14.5,
      false,
      'assets/images/Supreme-Pizza.jpg',
      l10n.pizzaSupremeFullDesc,
      ['Pepperoni', 'Italian Sausage', 'Bell Peppers', 'Onions', 'Mushrooms', 'Tomato Sauce', 'Mozzarella'],
      ['Extra Pepperoni (+2.50)', 'Extra Sausage (+2.50)', 'Hot Peppers (+1.00)']
    ),
    // COMMENTED OUT - Not in menu images
    // (
    //   l10n.pizzaCheeseClassic,
    //   l10n.pizzaCheeseClassicDesc,
    //   11.0,
    //   true,
    //   'assets/images/Cheese_Classic_Pizza.jpg',
    //   l10n.pizzaCheeseClassicFullDesc,
    //   ['House Tomato Sauce', 'Premium Mozzarella', 'Extra Virgin Olive Oil', 'Fresh Basil'],
    //   ['Extra Cheese (+2.00)', 'Basil (+1.50)', 'Hot Oil (+1.00)']
    // ),
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
    // COMMENTED OUT - Not in menu images
    // (
    //   l10n.pizzaCapreseHitman,
    //   l10n.pizzaCapreseHitmanDesc,
    //   14.0,
    //   true,
    //   'assets/images/caprese-pizza.jpeg',
    //   l10n.pizzaCapreseHitmanFullDesc,
    //   ['Heirloom Tomatoes', 'Fresh Mozzarella', 'Basil', 'Balsamic Reduction', 'Extra Virgin Olive Oil'],
    //   ['Extra Tomatoes (+2.00)', 'Burrata (+3.50)', 'Pine Nuts (+2.50)']
    // ),
    // (
    //   l10n.pizzaTruffleWhiteHit,
    //   l10n.pizzaTruffleWhiteHitDesc,
    //   16.0,
    //   true,
    //   'assets/images/Truffle-White-Pizza.jpg',
    //   l10n.pizzaTruffleWhiteHitFullDesc,
    //   ['Ricotta Cheese', 'Parmesan', 'Black Truffle', 'Garlic', 'Fresh Herbs', 'Mozzarella'],
    //   ['Extra Truffle (+5.00)', 'Prosciutto (+4.00)', 'Arugula (+2.50)']
    // ),
    // (
    //   l10n.pizzaBrickOvenDon,
    //   l10n.pizzaBrickOvenDonDesc,
    //   17.0,
    //   false,
    //   'assets/images/brick-oven-pizza.webp',
    //   l10n.pizzaBrickOvenDonFullDesc,
    //   ['Type 00 Flour Crust', 'San Marzano Tomatoes', 'Fresh Mozzarella', 'Basil Oil', 'Sea Salt'],
    //   ['Extra Basil Oil (+1.50)', 'Anchovies (+3.00)', 'Olives (+1.50)']
    // ),
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
    // COMMENTED OUT - Not in menu images
    // (
    //   l10n.pizzaVelvetPepperoni,
    //   l10n.pizzaVelvetPepperoniDesc,
    //   15.5,
    //   false,
    //   'assets/images/velvet-pepperoni-pizza.jpg',
    //   l10n.pizzaVelvetPepperoniFullDesc,
    //   ['House Tomato Sauce', 'Premium Pepperoni', 'Mozzarella', 'Oregano', 'Garlic'],
    //   ['Extra Pepperoni (+2.50)', 'Hot Honey (+1.50)', 'Red Pepper Flakes (+1.00)']
    // ),
    (
      l10n.pizzaHawaiianBacon,
      l10n.pizzaHawaiianBaconDesc,
      14.5,
      false,
      'assets/images/hawaiin-bacon-pizza.jpg',
      l10n.pizzaHawaiianBaconFullDesc,
      ['Diced Ham', 'Crispy Bacon', 'Pineapple', 'Green Onions', 'Mozzarella', 'Tomato Sauce'],
      ['Extra Bacon (+2.50)', 'Extra Pineapple (+2.00)', 'Jalapeños (+1.00)']
    ),
    (
      l10n.pizzaMeatLover,
      l10n.pizzaMeatLoverDesc,
      16.0,
      false,
      'assets/images/meat-lovers-pizza.jpg',
      l10n.pizzaMeatLoverFullDesc,
      ['Premium Pepperoni', 'Italian Sausage', 'Crispy Bacon', 'Diced Ham', 'Mozzarella', 'Tomato Sauce'],
      ['Extra Pepperoni (+2.50)', 'Extra Sausage (+2.50)', 'Extra Bacon (+2.50)']
    ),
    (
      l10n.pizzaMexicali,
      l10n.pizzaMexicaliDesc,
      15.5,
      false,
      'assets/images/mexicalli-pizza.jpg',
      l10n.pizzaMexicaliFullDesc,
      ['Spicy Ground Beef', 'Jalapeños', 'Bell Peppers', 'Red Onions', 'Mexican Cheese Blend', 'Tomato Sauce'],
      ['Extra Jalapeños (+1.00)', 'Sour Cream (+1.50)', 'Cilantro (+1.00)']
    ),
    (
      l10n.pizzaChickenTikkaMasala,
      l10n.pizzaChickenTikkaMasalaDesc,
      16.5,
      false,
      'assets/images/Chicken-Tikka-Masala-Pizza.jpg',
      l10n.pizzaChickenTikkaMasalaFullDesc,
      ['Marinated Chicken Tikka', 'Creamy Masala Sauce', 'Red Onions', 'Fresh Cilantro', 'Mozzarella', 'Garam Masala'],
      ['Extra Chicken (+3.00)', 'Mango Chutney (+1.50)', 'Yogurt Sauce (+1.00)']
    ),
    (
      l10n.pizzaAlfredoChicken,
      l10n.pizzaAlfredoChickenDesc,
      16.0,
      false,
      'assets/images/Chicken-Alfredo-Pizza.jpg',
      l10n.pizzaAlfredoChickenFullDesc,
      ['Grilled Chicken Breast', 'Creamy Alfredo Sauce', 'Mozzarella', 'Parmesan Cheese', 'Fresh Parsley', 'Garlic'],
      ['Extra Chicken (+4.00)', 'Mushrooms (+2.00)', 'Broccoli (+2.00)']
    ),

    // Combos / Deals
    (
      l10n.combo2SlicesDrink,
      l10n.combo2SlicesDrinkDesc,
      15.99,
      false,
      'assets/images/combo-1-img.jpg',
      l10n.combo2SlicesDrinkFullDesc,
      ['2 Pizza Slices', '1 Drink'],
      []
    ),
    (
      l10n.comboSliceDrink,
      l10n.comboSliceDrinkDesc,
      11.99, // Updated from 10.99 to match menu
      false,
      'assets/images/combo-1-img.jpg',
      l10n.comboSliceDrinkFullDesc,
      ['1 Pizza Slice', '1 Drink'],
      []
    ),
    (
      l10n.comboSliceWingsSoda,
      l10n.comboSliceWingsSodaDesc,
      18.99, // Updated from 16.99 to match menu
      false,
      'assets/images/combo-3.jpg',
      l10n.comboSliceWingsSodaFullDesc,
      ['1 Pizza Slice', 'Wings', '1 Soda'],
      []
    ),
    (
      l10n.combo10WingsDrink,
      l10n.combo10WingsDrinkDesc,
      19.99,
      false,
      'assets/images/combo-4.jpg',
      l10n.combo10WingsDrinkFullDesc,
      ['10 Wings', '1 Drink'],
      []
    ),

    // Wings / Boneless
    (
      l10n.wingsBuffalo,
      l10n.wingsBuffaloDesc,
      12.99,
      false,
      'assets/images/buffalo-wings.jpg',
      l10n.wingsBuffaloFullDesc,
      ['Chicken Wings', 'Buffalo Sauce', 'Butter', 'Vinegar', 'Hot Sauce'],
      ['Extra Hot Sauce (+1.00)', 'Ranch Dressing (+0.50)', 'Blue Cheese (+0.50)']
    ),
    (
      l10n.wingsGarlicParmesan,
      l10n.wingsGarlicParmesanDesc,
      13.99,
      false,
      'assets/images/garlic-parmesan-wings.jpg',
      l10n.wingsGarlicParmesanFullDesc,
      ['Chicken Wings', 'Garlic', 'Parmesan Cheese', 'Butter', 'Parsley'],
      ['Extra Parmesan (+1.00)', 'Lemon Wedges (+0.50)', 'Hot Sauce (+0.50)']
    ),
    (
      l10n.wingsBBQ,
      l10n.wingsBBQDesc,
      12.99,
      false,
      'assets/images/bbq-wings.jpg',
      l10n.wingsBBQFullDesc,
      ['Chicken Wings', 'BBQ Sauce', 'Brown Sugar', 'Garlic', 'Smoked Paprika'],
      ['Extra BBQ Sauce (+1.00)', 'Pickles (+0.50)', 'Onions (+0.50)']
    ),
    (
      l10n.wingsMangoHabanero,
      l10n.wingsMangoHabaneroDesc,
      13.99,
      false,
      'assets/images/Mango-Habanero-Hot-Wings.jpg',
      l10n.wingsMangoHabaneroFullDesc,
      ['Chicken Wings', 'Mango Puree', 'Habanero Peppers', 'Honey', 'Lime'],
      ['Extra Spicy (+1.00)', 'Cooling Ranch (+0.50)', 'Lime Wedges (+0.50)']
    ),
    (
      l10n.wingsLemonPepper,
      l10n.wingsLemonPepperDesc,
      12.99,
      false,
      'assets/images/lemon-pepper-wings.jpg',
      l10n.wingsLemonPepperFullDesc,
      ['Chicken Wings', 'Lemon Zest', 'Black Pepper', 'Garlic', 'Butter'],
      ['Extra Lemon (+0.50)', 'Garlic Butter (+1.00)', 'Hot Sauce (+0.50)']
    ),
    (
      l10n.wingsHotHoney,
      l10n.wingsHotHoneyDesc,
      13.99,
      false,
      'assets/images/hot-honey-wings.jpg',
      l10n.wingsHotHoneyFullDesc,
      ['Chicken Wings', 'Honey', 'Hot Sauce', 'Butter', 'Red Pepper Flakes'],
      ['Extra Hot Honey (+1.00)', 'Ranch Dressing (+0.50)', 'Blue Cheese (+0.50)']
    ),

    // Dips
    (
      l10n.dipHoneyMustard,
      l10n.dipHoneyMustardDesc,
      2.99,
      true,
      'assets/images/honey-mustard.jpg',
      l10n.dipHoneyMustardFullDesc,
      ['Honey', 'Dijon Mustard', 'Mayonnaise', 'Vinegar', 'Spices'],
      []
    ),
    (
      l10n.dipGarlic,
      l10n.dipGarlicDesc,
      2.99,
      true,
      'assets/images/garlic-dip.webp',
      l10n.dipGarlicFullDesc,
      ['Fresh Garlic', 'Sour Cream', 'Mayonnaise', 'Herbs', 'Lemon Juice'],
      []
    ),
    (
      l10n.dipParmesan,
      l10n.dipParmesanDesc,
      3.49,
      true,
      'assets/images/parmesan-dip.jpg',
      l10n.dipParmesanFullDesc,
      ['Parmesan Cheese', 'Cream Cheese', 'Mayonnaise', 'Garlic', 'Herbs'],
      []
    ),
    (
      l10n.dipItalianDressing,
      l10n.dipItalianDressingDesc,
      2.99,
      true,
      'assets/images/Italian-dressing.jpg',
      l10n.dipItalianDressingFullDesc,
      ['Olive Oil', 'Vinegar', 'Italian Herbs', 'Garlic', 'Spices'],
      []
    ),
    (
      l10n.dipRanch,
      l10n.dipRanchDesc,
      2.99,
      true,
      'assets/images/ranch-dip.jpg',
      l10n.dipRanchFullDesc,
      ['Mayonnaise', 'Sour Cream', 'Buttermilk', 'Fresh Herbs', 'Garlic', 'Onion Powder'],
      []
    ),
    (
      l10n.dipBlueCheese,
      l10n.dipBlueCheeseDesc,
      2.99,
      true,
      'assets/images/spinach-blue-cheese-dip.jpg',
      l10n.dipBlueCheeseFullDesc,
      ['Blue Cheese', 'Cream Cheese', 'Sour Cream', 'Spinach', 'Garlic', 'Herbs'],
      []
    ),

    // Fries
    (
      l10n.friesGarlic,
      l10n.friesGarlicDesc,
      7.99,
      true,
      'assets/images/garlic-fries.jpg',
      l10n.friesGarlicFullDesc,
      ['Potatoes', 'Fresh Garlic', 'Parsley', 'Parmesan Cheese', 'Olive Oil'],
      ['Extra Garlic (+1.00)', 'Add Cheese (+2.00)', 'Bacon Bits (+2.50)']
    ),
    (
      l10n.friesPlain,
      l10n.friesPlainDesc,
      7.99,
      true,
      'assets/images/plain-fries.jpg',
      l10n.friesPlainFullDesc,
      ['Potatoes', 'Salt', 'Vegetable Oil'],
      ['Cheese Sauce (+1.50)', 'Gravy (+1.50)', 'Ketchup (Free)']
    ),

    // Salads
    (
      l10n.saladCaesar,
      l10n.saladCaesarDesc,
      13.0, // Updated from 7.99 to match menu
      true,
      'assets/images/Caesar-Salad.jpg',
      l10n.saladCaesarFullDesc,
      ['Romaine Lettuce', 'Caesar Dressing', 'Parmesan Cheese', 'Croutons', 'Black Pepper'],
      ['Extra Dressing (+0.50)', 'Grilled Chicken (+4.00)', 'Anchovies (+2.00)']
    ),
    // COMMENTED OUT - Not in menu images
    // (
    //   l10n.saladGreen,
    //   l10n.saladGreenDesc,
    //   7.99,
    //   true,
    //   'assets/images/green-salad.jpg',
    //   l10n.saladGreenFullDesc,
    //   ['Mixed Greens', 'Cherry Tomatoes', 'Cucumbers', 'Carrots', 'House Dressing'],
    //   ['Extra Dressing (+0.50)', 'Grilled Chicken (+4.00)', 'Avocado (+2.50)']
    // ),

    // Pasta
    (
      l10n.pastaChickenAlfredo,
      l10n.pastaChickenAlfredoDesc,
      18.0, // Updated from 15.99 to match menu
      false,
      'assets/images/Chicken-Alfredo-pasta.webp',
      l10n.pastaChickenAlfredoFullDesc,
      ['Fettuccine Pasta', 'Grilled Chicken', 'Alfredo Sauce', 'Parmesan Cheese', 'Parsley'],
      ['Extra Chicken (+4.00)', 'Mushrooms (+2.00)', 'Broccoli (+2.00)']
    ),

    // Desserts
    (
      l10n.dessertChocolateChipCookiePizza,
      l10n.dessertChocolateChipCookiePizzaDesc,
      7.99,
      true,
      'assets/images/chocolate-chip-cookie-pizza.jpg',
      l10n.dessertChocolateChipCookiePizzaFullDesc,
      ['Cookie Dough', 'Chocolate Chips', 'Butter', 'Brown Sugar', 'Vanilla'],
      ['Ice Cream (+2.00)', 'Caramel Drizzle (+1.50)', 'Whipped Cream (+1.00)']
    ),
    (
      l10n.dessertChocolateChurros,
      l10n.dessertChocolateChurrosDesc,
      7.0, // Updated from 7.99 to match menu
      true,
      'assets/images/choc-churros.jpg',
      l10n.dessertChocolateChurrosFullDesc,
      ['Choux Pastry', 'Cinnamon Sugar', 'Dark Chocolate Sauce', 'Vegetable Oil'],
      ['Extra Chocolate (+1.00)', 'Caramel Sauce (+1.50)', 'Strawberries (+2.00)']
    ),
    (
      l10n.dessertCheesecake,
      l10n.dessertCheesecakeDesc,
      8.0, // Updated from 7.99 to match menu
      true,
      'assets/images/Cherry-Cheesecake.jpg',
      l10n.dessertCheesecakeFullDesc,
      ['Cream Cheese', 'Graham Cracker Crust', 'Sugar', 'Vanilla', 'Eggs'],
      ['Strawberry Topping (+2.00)', 'Caramel Sauce (+1.50)', 'Cherry Topping (+1.50)']
    ),
    (
      l10n.dessertFreshCannoli,
      l10n.dessertFreshCannoliDesc,
      7.0,
      true,
      'assets/images/fresh-canoli.jpg',
      l10n.dessertFreshCannoliFullDesc,
      ['Crispy Shell', 'Sweet Ricotta Cheese', 'Chocolate Chips', 'Powdered Sugar', 'Vanilla'],
      ['Extra Chocolate Chips (+1.00)', 'Caramel Drizzle (+1.50)', 'Pistachios (+1.50)']
    ),

    // Drinks
    (
      l10n.drink2Liter,
      l10n.drink2LiterDesc,
      5.0, // Updated from 4.99 to match menu
      true,
      'assets/images/2litrre-softdrink.jpg',
      l10n.drink2LiterFullDesc,
      ['Carbonated Water', 'High Fructose Corn Syrup', 'Natural Flavors'],
      []
    ),
    (
      l10n.drink16oz,
      l10n.drink16ozDesc,
      2.99,
      true,
      'assets/images/16oz-drink.jpg',
      l10n.drink16ozFullDesc,
      ['Carbonated Water', 'High Fructose Corn Syrup', 'Natural Flavors'],
      []
    ),
    ];
  }

  double getTotalPrice() {
    final l10n = AppLocalizations.of(context)!;
    final items = _getItems(l10n);
    final effectiveIndex = _actualItemIndex ?? widget.itemIndex;
    final item = effectiveIndex < items.length ? items[effectiveIndex] : items.first;
    
    // Check if it's a pizza (pizzas have 10"/18" sizing)
    final isPizza = !item.$1.toLowerCase().contains('salad') && 
                    !item.$1.toLowerCase().contains('combo') &&
                    !item.$1.toLowerCase().contains('dip') &&
                    !item.$1.toLowerCase().contains('fries') &&
                    !item.$1.toLowerCase().contains('pasta') &&
                    !item.$1.toLowerCase().contains('dessert') &&
                    !item.$1.toLowerCase().contains('drink');

    double basePrice = item.$3;
    double sizeMultiplier = 1.0;

    // Size multiplier ONLY for pizzas
    if (isPizza) {
      // Pizzas: 10" = base price, 18" = $21.99 / $11.99 ≈ 1.84x
      if (selectedSize == '18"') {
        sizeMultiplier = 21.99 / 11.99; // ≈ 1.83
      } else {
        sizeMultiplier = 1.0; // 10" is default/base
      }
    }
    // For all other items (salads, dips, drinks, desserts, fries, pasta, combos), no size multiplier

    // Toppings cost - $4.50 per extra topping after first 2 included
    double toppingsCost = 0.0;
    final includedToppings = isPizza ? 2 : 0; // 2 toppings included for pizzas
    final extraToppingsCount = selectedToppings.length > includedToppings 
        ? selectedToppings.length - includedToppings 
        : 0;
    
    if (isPizza && extraToppingsCount > 0) {
      // For pizzas, charge $4.50 per extra topping
      toppingsCost = extraToppingsCount * 4.50;
    } else {
      // For other items, use the price from topping string
      for (String topping in selectedToppings) {
        RegExp priceRegex = RegExp(r'\(\+\$?(\d+\.?\d*)\)');
        Match? match = priceRegex.firstMatch(topping);
        if (match != null) {
          toppingsCost += double.parse(match.group(1)!);
        }
      }
    }

    return (basePrice * sizeMultiplier) + toppingsCost;
  }

  Future<void> _addToCart(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final items = _getItems(l10n);
    final effectiveIndex = _actualItemIndex ?? widget.itemIndex;
    final item = effectiveIndex < items.length ? items[effectiveIndex] : items.first;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    // Check if it's a pizza (only pizzas have size options)
    final isPizza = !item.$1.toLowerCase().contains('salad') && 
                    !item.$1.toLowerCase().contains('combo') &&
                    !item.$1.toLowerCase().contains('dip') &&
                    !item.$1.toLowerCase().contains('fries') &&
                    !item.$1.toLowerCase().contains('pasta') &&
                    !item.$1.toLowerCase().contains('dessert') &&
                    !item.$1.toLowerCase().contains('drink');

    // For combos with slices, include selected pizza names in description
    String description = item.$2;
    if (isComboWithSlices(item.$1, l10n) && selectedPizzaSlices.isNotEmpty) {
      description = '$description\nSelected slices: ${selectedPizzaSlices.join(', ')}';
    }

    // Only use selectedSize for pizzas, otherwise use empty string
    final sizeForCart = isPizza ? selectedSize : '';

    final cartItem = CartItem(
      id: widget.cartItemForEdit?.id ?? '${item.$1}_${DateTime.now().millisecondsSinceEpoch}',
      name: item.$1,
      description: description,
      basePrice: item.$3,
      isVegetarian: item.$4,
      imagePath: item.$5,
      selectedSize: sizeForCart,
      selectedToppings: selectedToppings.toList(),
      quantity: widget.cartItemForEdit?.quantity ?? 1, // Preserve quantity when editing
    );

    // If editing, update the cart item; otherwise add new item
    if (widget.cartItemForEdit != null) {
      await cartProvider.updateCartItem(widget.cartItemForEdit!.id, cartItem);
    } else {
      await cartProvider.addItem(cartItem);
    }

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
                      widget.cartItemForEdit != null 
                          ? 'Item Updated'
                          : l10n.addedToCart,
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
    final effectiveIndex = _actualItemIndex ?? widget.itemIndex;
    final item = effectiveIndex < items.length ? items[effectiveIndex] : items.first;
    
    // Initialize size ONLY for pizzas (10" default)
    final isPizza = !item.$1.toLowerCase().contains('salad') && 
                    !item.$1.toLowerCase().contains('combo') &&
                    !item.$1.toLowerCase().contains('dip') &&
                    !item.$1.toLowerCase().contains('fries') &&
                    !item.$1.toLowerCase().contains('pasta') &&
                    !item.$1.toLowerCase().contains('dessert') &&
                    !item.$1.toLowerCase().contains('drink');
    
    // Only initialize size for pizzas
    if (isPizza && selectedSize != '10"' && selectedSize != '18"') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            selectedSize = '10"';
          });
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.$1.toUpperCase(),
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 1.0,
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFC6A667).withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.5),
                  child: SizedBox(
                    height: 200,
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
              const SizedBox(height: 14),

              // Spice Level Indicator
              Builder(
                builder: (context) {
                  final spiceLevel = getSpiceLevel(item.$1, item.$2);
                  if (spiceLevel.isEmpty) return const SizedBox.shrink();
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7A1F1F).withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFC6A667).withValues(alpha: 0.7),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
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
                            fontSize: 11,
                            color: const Color(0xFFC6A667),
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          spiceLevel,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFF5E8C7),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Detailed Description Section
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F0F).withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFF878787).withValues(alpha: 0.5),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Builder(
                  builder: (context) {
                    // Dynamic title based on item type
                    final isWings = item.$1.toLowerCase().contains('wings');
                    final isPizza = !item.$1.toLowerCase().contains('salad') && 
                                    !item.$1.toLowerCase().contains('combo') &&
                                    !item.$1.toLowerCase().contains('dip') &&
                                    !item.$1.toLowerCase().contains('fries') &&
                                    !item.$1.toLowerCase().contains('pasta') &&
                                    !item.$1.toLowerCase().contains('dessert') &&
                                    !item.$1.toLowerCase().contains('drink') &&
                                    !item.$1.toLowerCase().contains('wings');
                    
                    final sectionTitle = isWings 
                        ? l10n.aboutTheseWings 
                        : isPizza 
                        ? l10n.aboutThisPizza 
                        : l10n.aboutThisItem;
                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          sectionTitle,
                          style: GoogleFonts.cinzel(
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                            color: const Color(0xFFD4AF7A),
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.$6,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFFFF8E1),
                            fontSize: 13,
                            fontFamily: 'Lato',
                            height: 1.5,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Pizza Slice Selection for Combos
              Builder(
                builder: (context) {
                  final isCombo = isComboWithSlices(item.$1, l10n);
                  if (!isCombo) {
                    return const SizedBox.shrink();
                  }
                  
                  final requiredSlices = getRequiredSliceCount(item.$1, l10n);
                  final availablePizzas = getAvailableSlicePizzas(l10n);
                  
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F0F0F).withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFC6A667).withValues(alpha: 0.7),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.selectPizzaSlice,
                          style: GoogleFonts.cinzel(
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                            color: const Color(0xFFD4AF7A),
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${l10n.chooseFromOptions} (${l10n.slice} $requiredSlices)',
                          style: TextStyle(
                            color: const Color(0xFFC6A667).withValues(alpha: 0.9),
                            fontSize: 11,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...availablePizzas.asMap().entries.map((entry) {
                          final pizzaName = entry.value;
                          final isSelected = selectedPizzaSlices.contains(pizzaName);
                          
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedPizzaSlices.remove(pizzaName);
                                  } else {
                                    if (selectedPizzaSlices.length < requiredSlices) {
                                      selectedPizzaSlices.add(pizzaName);
                                    } else {
                                      // Replace first selected if max reached
                                      selectedPizzaSlices.removeAt(0);
                                      selectedPizzaSlices.add(pizzaName);
                                    }
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFFC6A667)
                                      : const Color(0xFF1C1512).withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFFC6A667)
                                        : const Color(0xFF878787).withValues(alpha: 0.5),
                                    width: isSelected ? 1.5 : 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        pizzaName,
                                        style: TextStyle(
                                          color: isSelected
                                              ? const Color(0xFF000000)
                                              : const Color(0xFFF5E8C7),
                                          fontSize: 12,
                                          fontFamily: 'Lato',
                                          fontWeight: isSelected
                                              ? FontWeight.w700
                                              : FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      const Icon(
                                        Icons.check_circle,
                                        color: Color(0xFF000000),
                                        size: 18,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                        if (selectedPizzaSlices.length < requiredSlices && selectedPizzaSlices.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Select ${requiredSlices - selectedPizzaSlices.length} more ${requiredSlices - selectedPizzaSlices.length == 1 ? l10n.slice.toLowerCase() : '${l10n.slice.toLowerCase()}s'}',
                              style: TextStyle(
                                color: const Color(0xFFFF6B6B),
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Ingredients Section (skip for combos)
              Builder(
                builder: (context) {
                  final isCombo = isComboWithSlices(item.$1, l10n);
                  if (isCombo) {
                    return const SizedBox.shrink();
                  }
                  return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFF878787).withValues(alpha: 0.5),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
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
                        fontSize: 13,
                        color: const Color(0xFF000000),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: item.$7.map<Widget>((ingredient) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC6A667).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFC6A667).withValues(alpha: 0.4),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          ingredient,
                          style: const TextStyle(
                            color: Color(0xFF1C1512),
                            fontSize: 11,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Special Toppings Section (only for pizzas, salads, fries, pasta - skip combos, dips, drinks, desserts)
              Builder(
                builder: (context) {
                  if (!shouldShowSpecialToppings(item.$1, l10n, item.$8)) {
                    return const SizedBox.shrink();
                  }
                  return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F0F).withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFF878787).withValues(alpha: 0.5),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Builder(
                  builder: (context) {
                    // Calculate variables here so they're in scope
                    final includedToppingsCalc = isPizza ? 2 : 0;
                    final extraToppingsCount = selectedToppings.length > includedToppingsCalc 
                        ? selectedToppings.length - includedToppingsCalc 
                        : 0;
                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              l10n.specialToppings,
                              style: GoogleFonts.cinzel(
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                                color: const Color(0xFFD4AF7A),
                                letterSpacing: 1.2,
                              ),
                            ),
                            if (isPizza) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00E676).withValues(alpha: 0.25),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: const Color(0xFF00E676).withValues(alpha: 0.8),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  l10n.twoToppingsIncluded,
                                  style: const TextStyle(
                                    color: Color(0xFF00E676),
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Cinzel',
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (isPizza && extraToppingsCount > 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 6, bottom: 3),
                            child: Text(
                              '${l10n.extraToppings}: ${extraToppingsCount}x \$${4.50 * extraToppingsCount}',
                              style: TextStyle(
                                color: const Color(0xFFC6A667).withValues(alpha: 0.9),
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),
                        ...item.$8.map<Widget>((topping) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: selectedToppings.contains(topping) ?
                            const Color(0xFFC6A667) :
                            const Color(0xFF1C1512).withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: selectedToppings.contains(topping) ?
                              const Color(0xFFC6A667) :
                              const Color(0xFF878787).withValues(alpha: 0.5),
                            width: selectedToppings.contains(topping) ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    topping.replaceAll(RegExp(r'\s*\(\+\$?[\d.]*\)'), ''), // Remove price from name for pizzas
                                    style: TextStyle(
                                      color: selectedToppings.contains(topping) ?
                                        const Color(0xFF000000) :
                                        const Color(0xFFF5E8C7),
                                      fontSize: 12,
                                      fontFamily: 'Lato',
                                      fontWeight: selectedToppings.contains(topping) ?
                                        FontWeight.w700 : FontWeight.w400,
                                    ),
                                  ),
                                    if (isPizza && selectedToppings.length > 2 && selectedToppings.contains(topping))
                                      Text(
                                        '\$${(4.50).toStringAsFixed(2)} ${l10n.perTopping}',
                                        style: TextStyle(
                                          color: const Color(0xFF000000).withValues(alpha: 0.6),
                                          fontSize: 9,
                                          fontFamily: 'Inter',
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                ],
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
                    );
                  },
                ),
              );
                },
              ),
              const SizedBox(height: 12),

              // Size Options and Action Buttons (ONLY for pizzas)
              Builder(
                builder: (context) {
                  // Only show size options for pizzas
                  if (!shouldShowSizeOptions(item.$1, l10n, item.$8)) {
                    return const SizedBox.shrink();
                  }
                  
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7A1F1F).withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFC6A667).withValues(alpha: 0.7),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
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
                            fontSize: 13,
                            color: const Color(0xFFD4AF7A),
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Builder(
                          builder: (context) {
                            final l10n = AppLocalizations.of(context)!;
                            
                            final sizeOptions = [
                              (l10n.pizza10Inch, '10"'),
                              (l10n.pizza18Inch, '18"'),
                            ];
                        
                        return Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          children: sizeOptions
                              .map<Widget>((size) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSize = size.$2;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                                  decoration: BoxDecoration(
                                    color: size.$2 == selectedSize ? const Color(0xFFC6A667) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(0xFFC6A667).withValues(alpha: 0.8),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Text(
                                    size.$1.toUpperCase(),
                                    style: TextStyle(
                                      color: size.$2 == selectedSize ? const Color(0xFF0F0F0F) : const Color(0xFFF5E8C7),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 11,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                ),
                              ))
                              .toList(),
                          );
                        },
                      ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Action Buttons and Info
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F0F).withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFF878787).withValues(alpha: 0.5),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Builder(
                      builder: (context) {
                        final isCombo = isComboWithSlices(item.$1, l10n);
                        final requiredSlices = isCombo ? getRequiredSliceCount(item.$1, l10n) : 0;
                        final canAddToCart = !isCombo || selectedPizzaSlices.length == requiredSlices;
                        
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: canAddToCart ? () => _addToCart(context) : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: canAddToCart ? const Color(0xFFC6A667) : const Color(0xFF878787),
                              foregroundColor: const Color(0xFF0F0F0F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 1,
                              shadowColor: Colors.black.withValues(alpha: 0.25),
                              minimumSize: const Size(double.infinity, 46),
                            ),
                            child: Text(
                              widget.cartItemForEdit != null 
                                  ? 'Save Changes'
                                  : l10n.addToCartButton,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1512).withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF878787).withValues(alpha: 0.4),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: const Color(0xFFC6A667).withValues(alpha: 0.9),
                            size: 14,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${l10n.houseNotes} ${item.$2.split('.').first}. ${l10n.addTruffleDrizzle}',
                              style: TextStyle(
                                color: const Color(0xFFC6A667).withValues(alpha: 0.85),
                                fontSize: 11,
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
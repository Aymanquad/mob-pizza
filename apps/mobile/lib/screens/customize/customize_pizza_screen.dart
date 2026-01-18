import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mob_pizza_mobile/providers/cart_provider.dart';
import 'package:mob_pizza_mobile/models/cart_item.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';

class CustomizePizzaScreen extends StatefulWidget {
  final CartItem? cartItemForEdit;
  const CustomizePizzaScreen({super.key, this.cartItemForEdit});

  @override
  State<CustomizePizzaScreen> createState() => _CustomizePizzaScreenState();
}

class _CustomizePizzaScreenState extends State<CustomizePizzaScreen> {
  Set<String> selectedBaseItems = {};
  Set<String> selectedToppings = {};
  Set<String> selectedDips = {};
  String selectedSize = '10"';
  
  @override
  void initState() {
    super.initState();
    // If editing a cart item, restore the selections
    if (widget.cartItemForEdit != null) {
      _restoreFromCartItem(widget.cartItemForEdit!);
    }
  }
  
  void _restoreFromCartItem(CartItem cartItem) {
    // Restore size
    selectedSize = cartItem.selectedSize.isNotEmpty ? cartItem.selectedSize : '10"';
    
    // Parse description to restore base items, toppings, and dips
    final description = cartItem.description;
    
    // Extract base items from description
    final baseMatch = RegExp(r'Base:\s*(.+?)(?:\s*\||$)').firstMatch(description);
    if (baseMatch != null) {
      final baseText = baseMatch.group(1) ?? '';
      selectedBaseItems = baseText.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toSet();
    }
    
    // Extract toppings from description
    final toppingsMatch = RegExp(r'Toppings:\s*(.+?)(?:\s*\||$)').firstMatch(description);
    if (toppingsMatch != null) {
      final toppingsText = toppingsMatch.group(1) ?? '';
      selectedToppings = toppingsText.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toSet();
    }
    
    // Extract dips from description
    final dipsMatch = RegExp(r'Dips:\s*(.+?)(?:\s*\||$)').firstMatch(description);
    if (dipsMatch != null) {
      final dipsText = dipsMatch.group(1) ?? '';
      // Remove price tags from dip names
      selectedDips = dipsText.split(',').map((s) => s.trim().replaceAll(RegExp(r'\s*\(\+\$?[\d.]*\)'), '')).where((s) => s.isNotEmpty).toSet();
    }
    
    // Also check selectedToppings from cart item for dips (they might be stored there)
    for (String topping in cartItem.selectedToppings) {
      // Check if it's a dip (has (+1.50) price tag)
      if (topping.contains('(+1.50)')) {
        final dipName = topping.replaceAll(RegExp(r'\s*\(\+1\.50\)'), '');
        selectedDips.add(dipName);
      } else if (!selectedToppings.contains(topping)) {
        // It's a regular topping
        selectedToppings.add(topping);
      }
    }
  }
  
  // Base items (cheese and sauce options only - no vegetables)
  List<String> getBaseItems(AppLocalizations l10n) {
    return [
      'Extra Cheese',
      'Extra Sauce',
      'Mozzarella Cheese',
      'Tomato Sauce',
    ];
  }
  
  // Available toppings (around 10 popular options)
  List<String> getAvailableToppings(AppLocalizations l10n) {
    return [
      'Extra Pepperoni (+2.50)',
      'Extra Sausage (+2.50)',
      'Hot Peppers (+1.00)',
      'Red Onions (+1.00)',
      'Extra Cheese (+2.00)',
      'Feta Cheese (+2.50)',
      'Mushrooms (+1.50)',
      'Olives (+1.50)',
      'Jalapeños (+1.00)',
      'Pineapple (+2.00)',
    ];
  }
  
  // Available dips (all dips from menu)
  List<String> getAvailableDips(AppLocalizations l10n) {
    return [
      l10n.dipHoneyMustard,
      l10n.dipGarlic,
      l10n.dipParmesan,
      l10n.dipItalianDressing,
      l10n.dipRanch,
      l10n.dipBlueCheese,
    ];
  }
  
  double getBasePrice() {
    // Base price for custom pizza: $12.00
    return 12.0;
  }
  
  double getToppingsPrice() {
    double total = 0.0;
    for (String topping in selectedToppings) {
      RegExp priceRegex = RegExp(r'\(\+(\d+\.?\d*)\)');
      Match? match = priceRegex.firstMatch(topping);
      if (match != null) {
        total += double.parse(match.group(1)!);
      }
    }
    return total;
  }
  
  double getDipsPrice() {
    // Each dip costs $1.50
    return selectedDips.length * 1.50;
  }
  
  double getTotalPrice() {
    double base = getBasePrice();
    double sizeMultiplier = selectedSize == '10"' ? 1.0 : 1.83; // 18" is ~1.83x the price
    double toppings = getToppingsPrice();
    double dips = getDipsPrice();
    
    return (base * sizeMultiplier) + toppings + dips;
  }
  
  String buildDescription() {
    List<String> parts = [];
    
    // Base items
    if (selectedBaseItems.isNotEmpty) {
      parts.add('Base: ${selectedBaseItems.join(', ')}');
    }
    
    // Size
    parts.add('Size: $selectedSize');
    
    // Toppings
    if (selectedToppings.isNotEmpty) {
      parts.add('Toppings: ${selectedToppings.join(', ')}');
    }
    
    // Dips
    if (selectedDips.isNotEmpty) {
      parts.add('Dips: ${selectedDips.join(', ')}');
    }
    
    return parts.join(' | ');
  }
  
  Future<void> _addToCart() async {
    if (selectedBaseItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one base item'),
          backgroundColor: Color(0xFF7A1F1F),
        ),
      );
      return;
    }
    
    final l10n = AppLocalizations.of(context)!;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    
    final customPizza = CartItem(
      id: widget.cartItemForEdit?.id ?? 'custom-pizza-${DateTime.now().millisecondsSinceEpoch}',
      name: l10n.customPizza,
      description: buildDescription(),
      basePrice: getBasePrice(),
      isVegetarian: selectedBaseItems.every((item) => 
        !item.toLowerCase().contains('pepperoni') && 
        !item.toLowerCase().contains('sausage')
      ),
      imagePath: 'assets/images/margherita-pizza.jpg', // Default pizza image
      selectedSize: selectedSize,
      selectedToppings: [
        ...selectedToppings.toList(),
        ...selectedDips.map((dip) => '$dip (+1.50)').toList(),
      ],
      quantity: widget.cartItemForEdit?.quantity ?? 1, // Preserve quantity when editing
    );
    
    // If editing, update the cart item; otherwise add new item
    if (widget.cartItemForEdit != null) {
      await cartProvider.updateCartItem(widget.cartItemForEdit!.id, customPizza);
    } else {
      await cartProvider.addItem(customPizza);
    }
    
    // Show snackbar with cart info (same style as menu items)
    if (mounted) {
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
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFC6A667)),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        title: Text(
          l10n.customizePizza,
          style: GoogleFonts.cinzel(
            color: const Color(0xFFC6A667),
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          // Base Items Section
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1512),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF878787)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.selectBaseItems,
                  style: GoogleFonts.cinzel(
                    color: const Color(0xFFC6A667),
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.selectBaseItemsDesc,
                  style: const TextStyle(
                    color: Color(0xFF878787),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: getBaseItems(l10n).map((item) {
                    final isSelected = selectedBaseItems.contains(item);
                    return FilterChip(
                      label: Text(item),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            if (selectedBaseItems.length < 3) {
                              selectedBaseItems.add(item);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Maximum 3 base items allowed'),
                                  backgroundColor: Color(0xFF7A1F1F),
                                ),
                              );
                            }
                          } else {
                            selectedBaseItems.remove(item);
                          }
                        });
                      },
                      selectedColor: const Color(0xFF7A1F1F),
                      checkmarkColor: const Color(0xFFC6A667),
                      labelStyle: TextStyle(
                        color: isSelected ? const Color(0xFFC6A667) : const Color(0xFFF5E8C7),
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                      ),
                      side: BorderSide(
                        color: isSelected ? const Color(0xFFC6A667) : const Color(0xFF878787),
                      ),
                    );
                  }).toList(),
                ),
                if (selectedBaseItems.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    '${l10n.selectedItems}: ${selectedBaseItems.join(', ')}',
                    style: const TextStyle(
                      color: Color(0xFFC6A667),
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Size Selection
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1512),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF878787)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Size',
                  style: GoogleFonts.cinzel(
                    color: const Color(0xFFC6A667),
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = '10"';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: selectedSize == '10"' ? const Color(0xFF7A1F1F) : const Color(0xFF0F0F0F),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedSize == '10"' ? const Color(0xFFC6A667) : const Color(0xFF878787),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '10"',
                                style: TextStyle(
                                  color: selectedSize == '10"' ? const Color(0xFFC6A667) : const Color(0xFF878787),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${getBasePrice().toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: selectedSize == '10"' ? const Color(0xFFC6A667) : const Color(0xFF878787),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = '18"';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: selectedSize == '18"' ? const Color(0xFF7A1F1F) : const Color(0xFF0F0F0F),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedSize == '18"' ? const Color(0xFFC6A667) : const Color(0xFF878787),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '18"',
                                style: TextStyle(
                                  color: selectedSize == '18"' ? const Color(0xFFC6A667) : const Color(0xFF878787),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${(getBasePrice() * 1.83).toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: selectedSize == '18"' ? const Color(0xFFC6A667) : const Color(0xFF878787),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Toppings Section
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1512),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF878787)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.selectToppings,
                  style: GoogleFonts.cinzel(
                    color: const Color(0xFFC6A667),
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: getAvailableToppings(l10n).map((topping) {
                    final isSelected = selectedToppings.contains(topping);
                    return FilterChip(
                      label: Text(topping),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedToppings.add(topping);
                          } else {
                            selectedToppings.remove(topping);
                          }
                        });
                      },
                      selectedColor: const Color(0xFF7A1F1F),
                      checkmarkColor: const Color(0xFFC6A667),
                      labelStyle: TextStyle(
                        color: isSelected ? const Color(0xFFC6A667) : const Color(0xFFF5E8C7),
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                        fontSize: 12,
                      ),
                      side: BorderSide(
                        color: isSelected ? const Color(0xFFC6A667) : const Color(0xFF878787),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Dips Section
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1512),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF878787)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.selectDips,
                  style: GoogleFonts.cinzel(
                    color: const Color(0xFFC6A667),
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Each dip: \$1.50',
                  style: TextStyle(
                    color: Color(0xFF878787),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: getAvailableDips(l10n).map((dip) {
                    final isSelected = selectedDips.contains(dip);
                    return FilterChip(
                      label: Text(dip),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedDips.add(dip);
                          } else {
                            selectedDips.remove(dip);
                          }
                        });
                      },
                      selectedColor: const Color(0xFF7A1F1F),
                      checkmarkColor: const Color(0xFFC6A667),
                      labelStyle: TextStyle(
                        color: isSelected ? const Color(0xFFC6A667) : const Color(0xFFF5E8C7),
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                      ),
                      side: BorderSide(
                        color: isSelected ? const Color(0xFFC6A667) : const Color(0xFF878787),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Price Summary
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF7A1F1F),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFC6A667)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.basePrice,
                      style: const TextStyle(color: Color(0xFFF5E8C7), fontSize: 14),
                    ),
                    Text(
                      '\$${getBasePrice().toStringAsFixed(2)}',
                      style: const TextStyle(color: Color(0xFFC6A667), fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                if (selectedToppings.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.toppingsPrice,
                        style: const TextStyle(color: Color(0xFFF5E8C7), fontSize: 14),
                      ),
                      Text(
                        '\$${getToppingsPrice().toStringAsFixed(2)}',
                        style: const TextStyle(color: Color(0xFFC6A667), fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
                if (selectedDips.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.dipsPrice,
                        style: const TextStyle(color: Color(0xFFF5E8C7), fontSize: 14),
                      ),
                      Text(
                        '\$${getDipsPrice().toStringAsFixed(2)}',
                        style: const TextStyle(color: Color(0xFFC6A667), fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
                if (selectedSize == '18"') ...[
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Size Upgrade (18")',
                        style: TextStyle(color: Color(0xFFF5E8C7), fontSize: 14),
                      ),
                      Text(
                        '\$${((getBasePrice() * 1.83) - getBasePrice()).toStringAsFixed(2)}',
                        style: const TextStyle(color: Color(0xFFC6A667), fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
                const Divider(color: Color(0xFFC6A667), height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: GoogleFonts.cinzel(
                        color: const Color(0xFFC6A667),
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '\$${getTotalPrice().toStringAsFixed(2)}',
                      style: GoogleFonts.cinzel(
                        color: const Color(0xFFC6A667),
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Add to Cart Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _addToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC6A667),
                foregroundColor: const Color(0xFF0F0F0F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                widget.cartItemForEdit != null ? 'Save Changes' : 'Add to Cart',
                style: GoogleFonts.cinzel(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}


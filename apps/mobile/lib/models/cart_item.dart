class CartItem {
  final String id;
  final String name;
  final String description;
  final double basePrice;
  final bool isVegetarian;
  final String imagePath;
  final String selectedSize;
  final List<String> selectedToppings;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.isVegetarian,
    required this.imagePath,
    required this.selectedSize,
    required this.selectedToppings,
    this.quantity = 1,
  });

  // Convert CartItem to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'basePrice': basePrice,
      'isVegetarian': isVegetarian,
      'imagePath': imagePath,
      'selectedSize': selectedSize,
      'selectedToppings': selectedToppings,
      'quantity': quantity,
    };
  }

  // Create CartItem from JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      basePrice: (json['basePrice'] as num).toDouble(),
      isVegetarian: json['isVegetarian'] as bool,
      imagePath: json['imagePath'] as String,
      selectedSize: json['selectedSize'] as String,
      selectedToppings: List<String>.from(json['selectedToppings'] as List),
      quantity: json['quantity'] as int? ?? 1,
    );
  }

  double get totalPrice {
    // Size multiplier
    double sizeMultiplier = selectedSize == 'Solo' ? 1.0 :
                           selectedSize == 'Crew' ? 1.5 : 2.0;

    // Toppings cost
    double toppingsCost = 0.0;
    for (String topping in selectedToppings) {
      RegExp priceRegex = RegExp(r'\(\+\$(\d+\.?\d*)\)');
      Match? match = priceRegex.firstMatch(topping);
      if (match != null) {
        toppingsCost += double.parse(match.group(1)!);
      }
    }

    return ((basePrice * sizeMultiplier) + toppingsCost) * quantity;
  }

  CartItem copyWith({
    String? id,
    String? name,
    String? description,
    double? basePrice,
    bool? isVegetarian,
    String? imagePath,
    String? selectedSize,
    List<String>? selectedToppings,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      basePrice: basePrice ?? this.basePrice,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      imagePath: imagePath ?? this.imagePath,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedToppings: selectedToppings ?? this.selectedToppings,
      quantity: quantity ?? this.quantity,
    );
  }
}


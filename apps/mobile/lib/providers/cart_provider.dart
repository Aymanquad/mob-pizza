import 'package:flutter/foundation.dart';
import 'package:mob_pizza_mobile/models/cart_item.dart';
import 'package:mob_pizza_mobile/config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  bool _isLoading = false;

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  int get totalQuantity => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  bool get isLoading => _isLoading;

  // Load cart from SharedPreferences
  Future<void> loadCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString(PrefKeys.cartItems);

      if (cartJson != null) {
        final List<dynamic> cartData = json.decode(cartJson);
        _items = cartData.map((json) => CartItem.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        _items = [];
      }
    } catch (e) {
      debugPrint('[CartProvider] Error loading cart: $e');
      _items = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Save cart to SharedPreferences
  Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = json.encode(_items.map((item) => item.toJson()).toList());
      await prefs.setString(PrefKeys.cartItems, cartJson);
      debugPrint('[CartProvider] Cart saved to storage (${_items.length} items)');
    } catch (e) {
      debugPrint('[CartProvider] Error saving cart: $e');
    }
  }

  Future<void> addItem(CartItem item) async {
    // Check if item with same configuration already exists
    final existingIndex = _items.indexWhere((cartItem) =>
        cartItem.name == item.name &&
        cartItem.selectedSize == item.selectedSize &&
        listEquals(cartItem.selectedToppings, item.selectedToppings));

    if (existingIndex >= 0) {
      // Update quantity if same item exists
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + 1,
      );
    } else {
      // Add new item
      _items.add(item);
    }

    notifyListeners();
    await _saveCart();
  }

  Future<void> removeItem(String id) async {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
    await _saveCart();
  }

  Future<void> updateQuantity(String id, int quantity) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = _items[index].copyWith(quantity: quantity);
      }
      notifyListeners();
      await _saveCart();
    }
  }

  Future<void> clearCart() async {
    _items.clear();
    notifyListeners();
    await _saveCart();
  }
}


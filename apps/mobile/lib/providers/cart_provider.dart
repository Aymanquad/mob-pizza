import 'package:flutter/foundation.dart';
import 'package:mob_pizza_mobile/models/cart_item.dart';
import 'package:mob_pizza_mobile/config/constants.dart';
import 'package:mob_pizza_mobile/services/cart_service.dart';
import 'package:mob_pizza_mobile/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  bool _isLoading = false;
  final CartService _cartService = CartService();

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  int get totalQuantity => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  bool get isLoading => _isLoading;

  // Load cart from API (with SharedPreferences fallback)
  Future<void> loadCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      final identifier = await AuthService.getUserIdentifier();
      
      if (identifier.isEmpty) {
        // No identifier = not onboarded, load from local storage
        await _loadFromLocalStorage();
        return;
      }

      try {
        // Try to load from API
        _items = await _cartService.getCart(identifier);
        // Sync to local storage as cache
        await _saveToLocalStorage();
        debugPrint('[CartProvider] Cart loaded from API (${_items.length} items)');
      } catch (e) {
        debugPrint('[CartProvider] API error, loading from cache: $e');
        // Fallback to local storage if API fails
        await _loadFromLocalStorage();
      }
    } catch (e) {
      debugPrint('[CartProvider] Error loading cart: $e');
      await _loadFromLocalStorage();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load from local storage (fallback)
  Future<void> _loadFromLocalStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString(PrefKeys.cartItems);

      if (cartJson != null) {
        final List<dynamic> cartData = json.decode(cartJson);
        _items = cartData.map((json) => CartItem.fromJson(json as Map<String, dynamic>)).toList();
        debugPrint('[CartProvider] Cart loaded from cache (${_items.length} items)');
      } else {
        _items = [];
      }
    } catch (e) {
      debugPrint('[CartProvider] Error loading from cache: $e');
      _items = [];
    }
  }

  // Save to local storage (cache)
  Future<void> _saveToLocalStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = json.encode(_items.map((item) => item.toJson()).toList());
      await prefs.setString(PrefKeys.cartItems, cartJson);
    } catch (e) {
      debugPrint('[CartProvider] Error saving to cache: $e');
    }
  }

  Future<void> addItem(CartItem item) async {
    final identifier = await AuthService.getUserIdentifier();
    
    try {
      if (identifier.isNotEmpty) {
        // Try to sync with API
        try {
          _items = await _cartService.addItem(identifier, item);
          await _saveToLocalStorage();
          debugPrint('[CartProvider] Item added via API');
        } catch (e) {
          debugPrint('[CartProvider] API error, adding locally: $e');
          // Fallback to local logic
          _addItemLocally(item);
          await _saveToLocalStorage();
        }
      } else {
        // No phone = not onboarded, use local only
        _addItemLocally(item);
        await _saveToLocalStorage();
      }
    } catch (e) {
      debugPrint('[CartProvider] Error adding item: $e');
      _addItemLocally(item);
      await _saveToLocalStorage();
    }
    
    notifyListeners();
  }

  void _addItemLocally(CartItem item) {
    final existingIndex = _items.indexWhere((cartItem) =>
        cartItem.name == item.name &&
        cartItem.selectedSize == item.selectedSize &&
        listEquals(cartItem.selectedToppings, item.selectedToppings));

    if (existingIndex >= 0) {
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + 1,
      );
    } else {
      _items.add(item);
    }
  }

  Future<void> removeItem(String id) async {
    final identifier = await AuthService.getUserIdentifier();
    
    try {
      if (identifier.isNotEmpty) {
        try {
          _items = await _cartService.removeItem(identifier, id);
          await _saveToLocalStorage();
          debugPrint('[CartProvider] Item removed via API');
        } catch (e) {
          debugPrint('[CartProvider] API error, removing locally: $e');
          _items.removeWhere((item) => item.id == id);
          await _saveToLocalStorage();
        }
      } else {
        _items.removeWhere((item) => item.id == id);
        await _saveToLocalStorage();
      }
    } catch (e) {
      debugPrint('[CartProvider] Error removing item: $e');
      _items.removeWhere((item) => item.id == id);
      await _saveToLocalStorage();
    }
    
    notifyListeners();
  }

  Future<void> updateQuantity(String id, int quantity) async {
    final identifier = await AuthService.getUserIdentifier();
    
    try {
      if (identifier.isNotEmpty) {
        try {
          if (quantity <= 0) {
            _items = await _cartService.removeItem(identifier, id);
          } else {
            _items = await _cartService.updateQuantity(identifier, id, quantity);
          }
          await _saveToLocalStorage();
          debugPrint('[CartProvider] Quantity updated via API');
        } catch (e) {
          debugPrint('[CartProvider] API error, updating locally: $e');
          _updateQuantityLocally(id, quantity);
          await _saveToLocalStorage();
        }
      } else {
        _updateQuantityLocally(id, quantity);
        await _saveToLocalStorage();
      }
    } catch (e) {
      debugPrint('[CartProvider] Error updating quantity: $e');
      _updateQuantityLocally(id, quantity);
      await _saveToLocalStorage();
    }
    
    notifyListeners();
  }

  void _updateQuantityLocally(String id, int quantity) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = _items[index].copyWith(quantity: quantity);
      }
    }
  }

  Future<void> clearCart() async {
    final phone = await AuthService.getCurrentUserPhone();
    
    try {
      if (phone.isNotEmpty) {
        try {
          await _cartService.clearCart(phone);
          _items = [];
          await _saveToLocalStorage();
          debugPrint('[CartProvider] Cart cleared via API');
        } catch (e) {
          debugPrint('[CartProvider] API error, clearing locally: $e');
          _items.clear();
          await _saveToLocalStorage();
        }
      } else {
        _items.clear();
        await _saveToLocalStorage();
      }
    } catch (e) {
      debugPrint('[CartProvider] Error clearing cart: $e');
      _items.clear();
      await _saveToLocalStorage();
    }
    
    notifyListeners();
  }
}


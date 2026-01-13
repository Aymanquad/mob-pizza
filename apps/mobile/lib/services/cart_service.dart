import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mob_pizza_mobile/config/constants.dart';
import 'package:mob_pizza_mobile/models/cart_item.dart';

class CartService {
  final String baseUrl;

  CartService({String? baseUrl}) : baseUrl = baseUrl ?? apiBaseUrl;

  /// Fetch user's cart from API
  Future<List<CartItem>> getCart(String phone) async {
    final url = '$baseUrl/cart/$phone';
    debugPrint('[cart_service] GET $url');

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      debugPrint('[cart_service] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List<dynamic> cartData = data['data'] as List<dynamic>;
          return cartData
              .map((json) => CartItem.fromJson(json as Map<String, dynamic>))
              .toList();
        }
      }
      throw Exception('Failed to fetch cart: ${response.statusCode}');
    } catch (e) {
      debugPrint('[cart_service] error fetching cart: $e');
      rethrow;
    }
  }

  /// Add item to cart
  Future<List<CartItem>> addItem(String phone, CartItem item) async {
    final url = '$baseUrl/cart/$phone';
    debugPrint('[cart_service] POST $url with: ${item.toJson()}');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(item.toJson()),
      ).timeout(const Duration(seconds: 10));

      debugPrint('[cart_service] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List<dynamic> cartData = data['data'] as List<dynamic>;
          return cartData
              .map((json) => CartItem.fromJson(json as Map<String, dynamic>))
              .toList();
        }
      }
      throw Exception('Failed to add item to cart: ${response.statusCode}');
    } catch (e) {
      debugPrint('[cart_service] error adding item: $e');
      rethrow;
    }
  }

  /// Update cart item quantity
  Future<List<CartItem>> updateQuantity(String phone, String itemId, int quantity) async {
    final url = '$baseUrl/cart/$phone/$itemId';
    debugPrint('[cart_service] PUT $url with quantity: $quantity');

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'quantity': quantity}),
      ).timeout(const Duration(seconds: 10));

      debugPrint('[cart_service] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List<dynamic> cartData = data['data'] as List<dynamic>;
          return cartData
              .map((json) => CartItem.fromJson(json as Map<String, dynamic>))
              .toList();
        }
      }
      throw Exception('Failed to update cart item: ${response.statusCode}');
    } catch (e) {
      debugPrint('[cart_service] error updating item: $e');
      rethrow;
    }
  }

  /// Update entire cart item (toppings, size, etc.)
  Future<List<CartItem>> updateItem(String phone, String itemId, CartItem updatedItem) async {
    final url = '$baseUrl/cart/$phone/$itemId';
    debugPrint('[cart_service] PUT $url with updated item: ${updatedItem.toJson()}');

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedItem.toJson()),
      ).timeout(const Duration(seconds: 10));

      debugPrint('[cart_service] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List<dynamic> cartData = data['data'] as List<dynamic>;
          return cartData
              .map((json) => CartItem.fromJson(json as Map<String, dynamic>))
              .toList();
        }
      }
      throw Exception('Failed to update cart item: ${response.statusCode}');
    } catch (e) {
      debugPrint('[cart_service] error updating item: $e');
      rethrow;
    }
  }

  /// Remove item from cart
  Future<List<CartItem>> removeItem(String phone, String itemId) async {
    final url = '$baseUrl/cart/$phone/$itemId';
    debugPrint('[cart_service] DELETE $url');

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      debugPrint('[cart_service] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List<dynamic> cartData = data['data'] as List<dynamic>;
          return cartData
              .map((json) => CartItem.fromJson(json as Map<String, dynamic>))
              .toList();
        }
      }
      throw Exception('Failed to remove cart item: ${response.statusCode}');
    } catch (e) {
      debugPrint('[cart_service] error removing item: $e');
      rethrow;
    }
  }

  /// Clear cart
  Future<void> clearCart(String phone) async {
    final url = '$baseUrl/cart/$phone';
    debugPrint('[cart_service] DELETE $url (clear)');

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      debugPrint('[cart_service] status=${response.statusCode} body=${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to clear cart: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('[cart_service] error clearing cart: $e');
      rethrow;
    }
  }
}


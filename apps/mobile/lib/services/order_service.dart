import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mob_pizza_mobile/config/constants.dart';
import 'package:mob_pizza_mobile/models/cart_item.dart';

class OrderService {
  final String baseUrl;

  OrderService({String? baseUrl}) : baseUrl = baseUrl ?? apiBaseUrl;

  /// Create new order
  Future<Map<String, dynamic>> createOrder(String phone, {
    required List<CartItem> items,
    required String customerName,
    required String phoneNumber,
    required String deliveryAddress,
    required String paymentMethod,
    required double totalPrice,
    String? promoCode,
    double? deliveryCharges,
    double? tax,
    double? discount,
    String? customerNotes,
    DateTime? estimatedDelivery,
  }) async {
    final url = '$baseUrl/orders/$phone';
    debugPrint('[order_service] POST $url');

    final orderData = {
      'items': items.map((item) => {
        'id': item.id,
        'name': item.name,
        'description': item.description,
        'basePrice': item.basePrice,
        'isVegetarian': item.isVegetarian,
        'imagePath': item.imagePath,
        'selectedSize': item.selectedSize,
        'selectedToppings': item.selectedToppings,
        'quantity': item.quantity,
      }).toList(),
      'orderType': 'delivery',
      'customerName': customerName,
      'phoneNumber': phoneNumber,
      'deliveryAddress': deliveryAddress,
      'paymentMethod': paymentMethod == 'cash_on_delivery' ? 'cash' : paymentMethod,
      'totalPrice': totalPrice,
      'promoCode': promoCode,
      'deliveryCharges': deliveryCharges ?? 0,
      'tax': tax ?? (totalPrice * 0.1),
      'discount': discount ?? 0,
      'customerNotes': customerNotes,
      'estimatedDelivery': estimatedDelivery?.toIso8601String(),
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(orderData),
      ).timeout(const Duration(seconds: 15));

      debugPrint('[order_service] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data'] as Map<String, dynamic>;
        }
      }
      throw Exception('Failed to create order: ${response.statusCode}');
    } catch (e) {
      debugPrint('[order_service] error creating order: $e');
      rethrow;
    }
  }

  /// Get user's orders (or all orders if user is admin/host)
  /// The backend automatically returns all orders if user role is admin/delivery
  Future<List<Map<String, dynamic>>> getOrders(String phone, {String? status}) async {
    final url = status != null
        ? '$baseUrl/orders/$phone?status=$status'
        : '$baseUrl/orders/$phone';
    debugPrint('[order_service] GET $url');

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      debugPrint('[order_service] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List<dynamic> ordersData = data['data'] as List<dynamic>;
          return ordersData.cast<Map<String, dynamic>>();
        }
      }
      throw Exception('Failed to fetch orders: ${response.statusCode}');
    } catch (e) {
      debugPrint('[order_service] error fetching orders: $e');
      rethrow;
    }
  }

  /// Get single order
  Future<Map<String, dynamic>> getOrder(String phone, String orderId) async {
    final url = '$baseUrl/orders/$phone/$orderId';
    debugPrint('[order_service] GET $url');

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      debugPrint('[order_service] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data'] as Map<String, dynamic>;
        }
      }
      throw Exception('Failed to fetch order: ${response.statusCode}');
    } catch (e) {
      debugPrint('[order_service] error fetching order: $e');
      rethrow;
    }
  }

  /// Update order status
  Future<Map<String, dynamic>> updateOrderStatus(
    String phone,
    String orderId,
    String status,
  ) async {
    final url = '$baseUrl/orders/$phone/$orderId/status';
    debugPrint('[order_service] PUT $url with status: $status');

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'status': status}),
      ).timeout(const Duration(seconds: 10));

      debugPrint('[order_service] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data'] as Map<String, dynamic>;
        }
      }
      throw Exception('Failed to update order status: ${response.statusCode}');
    } catch (e) {
      debugPrint('[order_service] error updating order status: $e');
      rethrow;
    }
  }
}


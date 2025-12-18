import 'package:flutter/foundation.dart';
import 'package:mob_pizza_mobile/models/order.dart';
import 'package:mob_pizza_mobile/config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  bool _isLoading = false;

  List<Order> get orders => List.unmodifiable(_orders.reversed); // Most recent first

  List<Order> get pendingOrders => _orders.where((o) => 
    o.status != OrderStatus.delivered && o.status != OrderStatus.cancelled
  ).toList();

  int get orderCount => _orders.length;

  bool get isLoading => _isLoading;

  // Load orders from SharedPreferences
  Future<void> loadOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersJson = prefs.getString(PrefKeys.orders);

      if (ordersJson != null) {
        final List<dynamic> ordersData = json.decode(ordersJson);
        _orders = ordersData.map((json) => Order.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        _orders = [];
      }
    } catch (e) {
      debugPrint('[OrderProvider] Error loading orders: $e');
      _orders = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Save orders to SharedPreferences
  Future<void> _saveOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersJson = json.encode(_orders.map((order) => order.toJson()).toList());
      await prefs.setString(PrefKeys.orders, ordersJson);
      debugPrint('[OrderProvider] Orders saved to storage (${_orders.length} orders)');
    } catch (e) {
      debugPrint('[OrderProvider] Error saving orders: $e');
    }
  }

  // Add new order
  Future<void> addOrder(Order order) async {
    _orders.add(order);
    notifyListeners();
    await _saveOrders();
  }

  // Update order status
  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index >= 0) {
      final updatedOrder = Order(
        id: _orders[index].id,
        orderNumber: _orders[index].orderNumber,
        items: _orders[index].items,
        customerName: _orders[index].customerName,
        phoneNumber: _orders[index].phoneNumber,
        deliveryAddress: _orders[index].deliveryAddress,
        paymentMethod: _orders[index].paymentMethod,
        totalPrice: _orders[index].totalPrice,
        status: newStatus,
        createdAt: _orders[index].createdAt,
        estimatedDelivery: _orders[index].estimatedDelivery,
      );
      _orders[index] = updatedOrder;
      notifyListeners();
      await _saveOrders();
    }
  }

  // Get order by ID
  Order? getOrderById(String orderId) {
    try {
      return _orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }
}


import 'package:flutter/foundation.dart';
import 'package:mob_pizza_mobile/models/order.dart';
import 'package:mob_pizza_mobile/models/cart_item.dart';
import 'package:mob_pizza_mobile/config/constants.dart';
import 'package:mob_pizza_mobile/services/order_service.dart';
import 'package:mob_pizza_mobile/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  bool _isLoading = false;
  DateTime? _lastLoadTime;
  final OrderService _orderService = OrderService();

  List<Order> get orders => List.unmodifiable(_orders.reversed); // Most recent first

  List<Order> get pendingOrders => _orders.where((o) => 
    o.status != OrderStatus.delivered && o.status != OrderStatus.cancelled
  ).toList();

  int get orderCount => _orders.length;

  bool get isLoading => _isLoading;

  // Load orders from API (with SharedPreferences fallback)
  // If user is admin/host, backend returns ALL orders automatically
  Future<void> loadOrders({bool forceReload = false}) async {
    // Prevent duplicate calls - if already loading and not forced, skip
    if (_isLoading && !forceReload) {
      debugPrint('[OrderProvider] Already loading orders, skipping duplicate call');
      return;
    }
    
    // Prevent rapid successive calls (debounce)
    final now = DateTime.now();
    if (_lastLoadTime != null && !forceReload) {
      final timeSinceLastLoad = now.difference(_lastLoadTime!);
      if (timeSinceLastLoad.inSeconds < 2) {
        debugPrint('[OrderProvider] Too soon since last load (${timeSinceLastLoad.inSeconds}s), skipping');
        return;
      }
    }
    
    _isLoading = true;
    _lastLoadTime = now;
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
        // Backend automatically returns all orders if user is admin/host
        debugPrint('[OrderProvider] Fetching orders from API for identifier: $identifier');
        final ordersData = await _orderService.getOrders(identifier);
        debugPrint('[OrderProvider] Received ${ordersData.length} orders from API');
        
        // Check if user is host/admin - if not, filter to only their orders
        final isHost = await AuthService.isHost();
        final userPhone = await AuthService.getCurrentUserPhone();
        final prefs = await SharedPreferences.getInstance();
        final userEmail = prefs.getString(PrefKeys.email) ?? '';
        
        List<Map<String, dynamic>> filteredOrders = ordersData;
        
        // If not a host, filter orders to only show user's own orders
        if (!isHost) {
          filteredOrders = ordersData.where((json) {
            // Check if order belongs to current user
            final customer = json['customer'] as Map<String, dynamic>?;
            if (customer != null) {
              final customerPhone = customer['phone'] as String? ?? '';
              final customerEmail = customer['email'] as String? ?? '';
              
              // Match by phone or email
              final matchesPhone = userPhone.isNotEmpty && customerPhone == userPhone;
              final matchesEmail = userEmail.isNotEmpty && customerEmail.toLowerCase() == userEmail.toLowerCase();
              
              return matchesPhone || matchesEmail;
            }
            // Fallback: check phoneNumber field directly
            final orderPhone = json['phoneNumber'] as String? ?? '';
            return userPhone.isNotEmpty && orderPhone == userPhone;
          }).toList();
          
          debugPrint('[OrderProvider] Filtered to ${filteredOrders.length} orders for regular user');
        } else {
          debugPrint('[OrderProvider] Showing all ${filteredOrders.length} orders for host/admin');
        }
        
        _orders = filteredOrders.map((json) {
          try {
            return _orderFromApi(json);
          } catch (e) {
            debugPrint('[OrderProvider] Error converting order: $e, json: $json');
            rethrow;
          }
        }).toList();
        // Sync to local storage as cache
        await _saveToLocalStorage();
        debugPrint('[OrderProvider] Orders loaded from API (${_orders.length} orders)');
      } catch (e) {
        debugPrint('[OrderProvider] API error, loading from cache: $e');
        // Fallback to local storage if API fails
        await _loadFromLocalStorage();
      }
    } catch (e) {
      debugPrint('[OrderProvider] Error loading orders: $e');
      await _loadFromLocalStorage();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Convert API order format to Order model
  Order _orderFromApi(Map<String, dynamic> json) {
    // Map API status to OrderStatus enum
    OrderStatus status = OrderStatus.pending;
    final statusStr = json['orderStatus'] as String? ?? 'pending';
    switch (statusStr) {
      case 'pending':
        status = OrderStatus.pending;
        break;
      case 'confirmed':
        status = OrderStatus.confirmed;
        break;
      case 'preparing':
        status = OrderStatus.preparing;
        break;
      case 'onTheWay':
      case 'ready':
        status = OrderStatus.onTheWay;
        break;
      case 'delivered':
        status = OrderStatus.delivered;
        break;
      case 'cancelled':
        status = OrderStatus.cancelled;
        break;
    }

    // Convert items from API format to CartItem format
    final List<CartItem> items = (json['items'] as List<dynamic>? ?? []).map((itemJson) {
      return CartItem(
        id: itemJson['menuItem']?.toString() ?? itemJson['_id']?.toString() ?? '',
        name: itemJson['name'] ?? 'Unknown Item',
        description: itemJson['description'] ?? '',
        basePrice: (itemJson['pricePerUnit'] as num?)?.toDouble() ?? 0.0,
        isVegetarian: false, // API doesn't provide this
        imagePath: itemJson['image'] ?? '',
        selectedSize: _mapSizeFromApi(itemJson['size'] as String? ?? 'medium'),
        selectedToppings: (itemJson['addOns'] as List<dynamic>? ?? [])
            .map((addon) => addon['name'] as String? ?? '')
            .where((name) => name.isNotEmpty)
            .toList(),
        quantity: itemJson['quantity'] as int? ?? 1,
      );
    }).toList();

    // Extract customer name - handle both populated customer object and direct fields
    String customerName = '';
    if (json['customer'] != null) {
      if (json['customer'] is Map) {
        // Customer is populated object
        final customer = json['customer'] as Map<String, dynamic>;
        final firstName = customer['firstName'] as String? ?? '';
        final lastName = customer['lastName'] as String? ?? '';
        customerName = '$firstName $lastName'.trim();
      } else {
        // Customer is just an ID
        customerName = json['customerName'] as String? ?? '';
      }
    } else {
      customerName = json['customerName'] as String? ?? '';
    }

    // Extract phone number
    String phoneNumber = '';
    if (json['customer'] != null && json['customer'] is Map) {
      phoneNumber = json['customer']?['phone'] as String? ?? '';
    }
    if (phoneNumber.isEmpty) {
      phoneNumber = json['phoneNumber'] as String? ?? '';
    }

    return Order(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      orderNumber: json['orderId'] as String? ?? json['orderNumber'] as String? ?? '',
      items: items,
      customerName: customerName,
      phoneNumber: phoneNumber,
      deliveryAddress: json['deliveryAddress']?.toString() ?? json['deliveryAddress'] as String? ?? '',
      paymentMethod: json['paymentMethod'] as String? ?? 'cash_on_delivery',
      totalPrice: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      status: status,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      estimatedDelivery: json['estimatedDeliveryTime'] != null
          ? DateTime.parse(json['estimatedDeliveryTime'] as String)
          : null,
    );
  }

  String _mapSizeFromApi(String apiSize) {
    switch (apiSize.toLowerCase()) {
      case 'small':
        return 'Solo';
      case 'medium':
        return 'Crew';
      case 'large':
      case 'extra-large':
        return 'Family';
      default:
        return 'Crew';
    }
  }

  // Load from local storage (fallback)
  Future<void> _loadFromLocalStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersJson = prefs.getString(PrefKeys.orders);

      if (ordersJson != null) {
        final List<dynamic> ordersData = json.decode(ordersJson);
        _orders = ordersData.map((json) => Order.fromJson(json as Map<String, dynamic>)).toList();
        debugPrint('[OrderProvider] Orders loaded from cache (${_orders.length} orders)');
      } else {
        _orders = [];
      }
    } catch (e) {
      debugPrint('[OrderProvider] Error loading from cache: $e');
      _orders = [];
    }
  }

  // Save to local storage (cache)
  Future<void> _saveToLocalStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersJson = json.encode(_orders.map((order) => order.toJson()).toList());
      await prefs.setString(PrefKeys.orders, ordersJson);
    } catch (e) {
      debugPrint('[OrderProvider] Error saving to cache: $e');
    }
  }

  // Add new order (create via API)
  Future<void> addOrder(Order order) async {
    final identifier = await AuthService.getUserIdentifier();
    
    if (identifier.isEmpty) {
      // No identifier = not onboarded, save locally only
      _orders.add(order);
      await _saveToLocalStorage();
      notifyListeners();
      return;
    }

    try {
      // Create order via API
      debugPrint('[OrderProvider] Creating order via API with identifier: $identifier');
      final orderData = await _orderService.createOrder(
        identifier,
        items: order.items,
        customerName: order.customerName,
        phoneNumber: order.phoneNumber,
        deliveryAddress: order.deliveryAddress,
        paymentMethod: order.paymentMethod,
        totalPrice: order.totalPrice,
        estimatedDelivery: order.estimatedDelivery,
      );

      // Convert API response to Order and add to list
      final newOrder = _orderFromApi(orderData);
      _orders.add(newOrder);
      await _saveToLocalStorage();
      debugPrint('[OrderProvider] Order created successfully via API, orderId: ${newOrder.id}');
    } catch (e) {
      debugPrint('[OrderProvider] API error creating order: $e');
      // Don't save locally if API fails - this ensures orders are only in DB
      // Re-throw the error so the UI can show it
      rethrow;
    }
    
    notifyListeners();
  }

  // Update order status
  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    final identifier = await AuthService.getUserIdentifier();
    
    // Map OrderStatus to API status string
    String apiStatus = 'pending';
    switch (newStatus) {
      case OrderStatus.pending:
        apiStatus = 'pending';
        break;
      case OrderStatus.confirmed:
        apiStatus = 'confirmed';
        break;
      case OrderStatus.preparing:
        apiStatus = 'preparing';
        break;
      case OrderStatus.onTheWay:
        apiStatus = 'ready';
        break;
      case OrderStatus.delivered:
        apiStatus = 'delivered';
        break;
      case OrderStatus.cancelled:
        apiStatus = 'cancelled';
        break;
    }

    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index < 0) {
      debugPrint('[OrderProvider] Order not found: $orderId');
      return;
    }

    try {
      if (identifier.isNotEmpty) {
        try {
          // Update via API
          final updatedData = await _orderService.updateOrderStatus(identifier, orderId, apiStatus);
          final updatedOrder = _orderFromApi(updatedData);
          _orders[index] = updatedOrder;
          await _saveToLocalStorage();
          debugPrint('[OrderProvider] Order status updated via API');
        } catch (e) {
          debugPrint('[OrderProvider] API error, updating locally: $e');
          // Fallback: update locally
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
          await _saveToLocalStorage();
        }
      } else {
        // No phone, update locally only
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
        await _saveToLocalStorage();
      }
    } catch (e) {
      debugPrint('[OrderProvider] Error updating order status: $e');
    }
    
    notifyListeners();
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


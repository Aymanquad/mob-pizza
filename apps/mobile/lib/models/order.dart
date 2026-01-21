import 'package:mob_pizza_mobile/models/cart_item.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  onTheWay,
  delivered,
  cancelled,
}

extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.preparing:
        return 'Kitchen in Motion';
      case OrderStatus.onTheWay:
        return 'On the Streets';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class Order {
  final String id;
  final String orderNumber;
  final List<CartItem> items;
  final String customerName;
  final String phoneNumber;
  final String deliveryAddress;
  final String paymentMethod; // 'cash_on_delivery' or 'stripe'
  final String paymentStatus; // 'pending', 'completed', 'failed', 'refunded'
  final double totalPrice;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? estimatedDelivery;

  Order({
    required this.id,
    required this.orderNumber,
    required this.items,
    required this.customerName,
    required this.phoneNumber,
    required this.deliveryAddress,
    required this.paymentMethod,
    this.paymentStatus = 'pending',
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    this.estimatedDelivery,
  });

  // Convert Order to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'items': items.map((item) => item.toJson()).toList(),
      'customerName': customerName,
      'phoneNumber': phoneNumber,
      'deliveryAddress': deliveryAddress,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'totalPrice': totalPrice,
      'status': status.index,
      'createdAt': createdAt.toIso8601String(),
      'estimatedDelivery': estimatedDelivery?.toIso8601String(),
    };
  }

  // Create Order from JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      orderNumber: json['orderNumber'] as String,
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      customerName: json['customerName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      deliveryAddress: json['deliveryAddress'] as String,
      paymentMethod: json['paymentMethod'] as String,
      paymentStatus: json['paymentStatus'] as String? ?? 'pending',
      totalPrice: (json['totalPrice'] as num).toDouble(),
      status: OrderStatus.values[json['status'] as int],
      createdAt: DateTime.parse(json['createdAt'] as String),
      estimatedDelivery: json['estimatedDelivery'] != null
          ? DateTime.parse(json['estimatedDelivery'] as String)
          : null,
    );
  }
}


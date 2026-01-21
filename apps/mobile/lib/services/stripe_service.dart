import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mob_pizza_mobile/config/constants.dart';

class StripeService {
  final String baseUrl;

  StripeService({String? baseUrl}) : baseUrl = baseUrl ?? apiBaseUrl;

  /// Create a Stripe payment intent on the backend
  Future<Map<String, dynamic>> createPaymentIntent({
    required String orderId,
    required double amount,
    required String currency,
  }) async {
    final url = '$baseUrl/payment/stripe/create-intent';
    debugPrint('[stripe_service] POST $url');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'orderId': orderId,
          'amount': (amount * 100).toInt(), // Convert to cents
          'currency': currency.toLowerCase(),
        }),
      ).timeout(const Duration(seconds: 15));

      debugPrint('[stripe_service] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data'] as Map<String, dynamic>;
        }
        throw Exception('Failed to create payment intent: ${data['message'] ?? 'Unknown error'}');
      }

      try {
        final errorData = jsonDecode(response.body);
        throw Exception('Failed to create payment intent: ${errorData['message'] ?? 'Unknown error'} (${response.statusCode})');
      } catch (_) {
        throw Exception('Failed to create payment intent: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      debugPrint('[stripe_service] error creating payment intent: $e');
      rethrow;
    }
  }

  /// Confirm payment after Stripe payment is successful
  Future<Map<String, dynamic>> confirmPayment({
    required String orderId,
    required String paymentIntentId,
    required String paymentMethodId,
  }) async {
    final url = '$baseUrl/payment/stripe/confirm';
    debugPrint('[stripe_service] POST $url');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'orderId': orderId,
          'paymentIntentId': paymentIntentId,
          'paymentMethodId': paymentMethodId,
        }),
      ).timeout(const Duration(seconds: 15));

      debugPrint('[stripe_service] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data'] as Map<String, dynamic>;
        }
        throw Exception('Failed to confirm payment: ${data['message'] ?? 'Unknown error'}');
      }

      try {
        final errorData = jsonDecode(response.body);
        throw Exception('Failed to confirm payment: ${errorData['message'] ?? 'Unknown error'} (${response.statusCode})');
      } catch (_) {
        throw Exception('Failed to confirm payment: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      debugPrint('[stripe_service] error confirming payment: $e');
      rethrow;
    }
  }
}


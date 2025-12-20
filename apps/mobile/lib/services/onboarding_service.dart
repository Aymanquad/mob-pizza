import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mob_pizza_mobile/config/constants.dart';

class OnboardingService {
  Future<Map<String, dynamic>> submitOnboarding({
    String? phone,
    String? email,
    String? googleId,
    String? firstName,
    String? lastName,
    required String locale,
    required bool allowLocation,
    required bool allowNotifications,
  }) async {
    final uri = Uri.parse('$apiBaseUrl/onboarding');
    final payload = <String, dynamic>{
      'locale': locale,
      'allowLocation': allowLocation,
      'allowNotifications': allowNotifications,
    };
    
    // Add phone if provided
    if (phone != null && phone.isNotEmpty) {
      payload['phone'] = phone;
    }
    
    // Add OAuth fields if provided
    if (email != null && email.isNotEmpty && googleId != null && googleId.isNotEmpty) {
      payload['email'] = email;
      payload['googleId'] = googleId;
      if (firstName != null && firstName.isNotEmpty) {
        payload['firstName'] = firstName;
      }
      // Only include lastName if it's not null and not empty
      if (lastName != null && lastName.isNotEmpty) {
        payload['lastName'] = lastName;
      }
      // If lastName is null or empty, backend will use default 'User'
    }
    
    debugPrint('[onboarding] POST $uri payload=$payload');
    final resp = await http
        .post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(payload),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('[onboarding] status=${resp.statusCode} body=${resp.body}');

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      try {
        final data = jsonDecode(resp.body);
        if (data is Map && data['data'] is Map) {
          return Map<String, dynamic>.from(data['data'] as Map);
        }
      } catch (_) {}
      return {};
    }

    String msg = 'Onboarding failed (${resp.statusCode})';
    try {
      final data = jsonDecode(resp.body);
      if (data is Map && data['message'] is String) {
        msg = data['message'] as String;
      }
    } catch (_) {}

    throw Exception(msg);
  }
}


import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mob_pizza_mobile/config/constants.dart';

class UserService {
  final String baseUrl;

  UserService({String? baseUrl})
      : baseUrl = baseUrl ?? apiBaseUrl;

  /// Fetch user profile by phone
  Future<Map<String, dynamic>> getProfile(String phone) async {
    final url = '$baseUrl/users/$phone';
    debugPrint('[user_service] GET $url');

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      debugPrint('[user_service] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data'] as Map<String, dynamic>;
        }
      }
      throw Exception('Failed to fetch profile: ${response.statusCode}');
    } catch (e) {
      debugPrint('[user_service] error fetching profile: $e');
      rethrow;
    }
  }

  /// Update user profile
  Future<Map<String, dynamic>> updateProfile(String phone, Map<String, dynamic> updates) async {
    final url = '$baseUrl/users/$phone';
    debugPrint('[user_service] PUT $url with: $updates');

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updates),
      ).timeout(const Duration(seconds: 10));

      debugPrint('[user_service] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data'] as Map<String, dynamic>;
        }
      }
      throw Exception('Failed to update profile: ${response.statusCode}');
    } catch (e) {
      debugPrint('[user_service] error updating profile: $e');
      rethrow;
    }
  }
}


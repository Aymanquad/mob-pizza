import 'package:shared_preferences/shared_preferences.dart';
import 'package:mob_pizza_mobile/config/constants.dart';
import 'package:mob_pizza_mobile/services/user_service.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  // Host phone numbers - these are the Mob Pizza staff numbers (fallback)
  static const List<String> hostPhoneNumbers = [
    '1234567890',
    '0987654321',
    '+919876543212', // Admin user from seeders
    '+919876543213', // Delivery user from seeders
  ];

  // Check if current user is a host/admin
  // Uses getUserIdentifier to support both phone and email
  static Future<bool> isHost() async {
    try {
      final identifier = await getUserIdentifier();
      
      if (identifier.isEmpty) {
        debugPrint('[AuthService] No identifier found, not a host');
        return false;
      }

      // Try to get user role from backend using identifier
      try {
        final userService = UserService();
        final userData = await userService.getProfile(identifier);
        final role = userData['role'] as String? ?? 'customer';
        
        debugPrint('[AuthService] User role from backend: $role (identifier: $identifier)');
        
        // Admin and delivery roles are considered hosts
        if (role == 'admin' || role == 'delivery') {
          return true;
        }
        
        // If role is customer, definitely not a host
        return false;
      } catch (e) {
        debugPrint('[AuthService] Error fetching user role: $e');
        // If we can't fetch role, assume not a host for security
        return false;
      }
    } catch (e) {
      debugPrint('[AuthService] Error checking host status: $e');
      return false;
    }
  }

  // Get current user phone
  static Future<String> getCurrentUserPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefKeys.phone) ?? '';
  }

  // Get user identifier (phone OR email) for API calls
  // Returns phone if available, otherwise email (for OAuth users)
  static Future<String> getUserIdentifier() async {
    final prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString(PrefKeys.phone) ?? '';
    if (phone.isNotEmpty) {
      return phone;
    }
    // For OAuth users, use email as identifier
    final email = prefs.getString(PrefKeys.email) ?? '';
    return email;
  }
}


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
  // First checks user role from backend, falls back to phone number check
  static Future<bool> isHost() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final phone = prefs.getString(PrefKeys.phone) ?? '';
      
      if (phone.isEmpty) return false;

      // Normalize phone number (remove +, spaces, etc.)
      final normalizedPhone = phone.replaceAll(RegExp(r'[\s+\-()]'), '');

      // Try to get user role from backend
      try {
        final userService = UserService();
        final userData = await userService.getProfile(phone);
        final role = userData['role'] as String? ?? 'customer';
        
        debugPrint('[AuthService] User role from backend: $role');
        
        // Admin and delivery roles are considered hosts
        if (role == 'admin' || role == 'delivery') {
          return true;
        }
      } catch (e) {
        debugPrint('[AuthService] Error fetching user role, using phone fallback: $e');
      }

      // Fallback to phone number check if API fails or role is customer
      // Check both original and normalized phone numbers
      final isHostPhone = hostPhoneNumbers.any((hostPhone) {
        final normalizedHostPhone = hostPhone.replaceAll(RegExp(r'[\s+\-()]'), '');
        return phone == hostPhone || 
               normalizedPhone == normalizedHostPhone ||
               phone.endsWith(hostPhone) ||
               normalizedPhone.endsWith(normalizedHostPhone);
      });

      debugPrint('[AuthService] Phone check result: $isHostPhone (phone: $phone, normalized: $normalizedPhone)');
      return isHostPhone;
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
}


import 'package:shared_preferences/shared_preferences.dart';
import 'package:mob_pizza_mobile/config/constants.dart';

class AuthService {
  // Host phone numbers - these are the Mob Pizza staff numbers
  static const List<String> hostPhoneNumbers = [
    '1234567890',
    '0987654321',
  ];

  // Check if current user is a host/admin
  static Future<bool> isHost() async {
    final prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString(PrefKeys.phone) ?? '';
    return hostPhoneNumbers.contains(phone);
  }

  // Get current user phone
  static Future<String> getCurrentUserPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefKeys.phone) ?? '';
  }
}


const String apiBaseUrl =
    String.fromEnvironment('API_BASE_URL', defaultValue: 'http://10.0.2.2:5000/api/v1');

class PrefKeys {
  static const onboardingCompleted = 'onboardingCompleted';
  static const localeCode = 'localeCode';
  static const phone = 'onboardingPhone';
  static const allowLocation = 'onboardingAllowLocation';
  static const allowNotifications = 'onboardingAllowNotifications';
  static const firstName = 'firstName';
  static const lastName = 'lastName';
  static const address = 'address';
  static const cartItems = 'cartItems';
  static const orders = 'orders';
}


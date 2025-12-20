const String apiBaseUrl =
    String.fromEnvironment('API_BASE_URL', defaultValue: 'https://mob-pizza.onrender.com/api/v1');

class PrefKeys {
  static const onboardingCompleted = 'onboardingCompleted';
  static const localeCode = 'localeCode';
  static const phone = 'onboardingPhone';
  static const email = 'userEmail';
  static const googleId = 'userGoogleId';
  static const allowLocation = 'onboardingAllowLocation';
  static const allowNotifications = 'onboardingAllowNotifications';
  static const firstName = 'firstName';
  static const lastName = 'lastName';
  static const address = 'address';
  static const cartItems = 'cartItems';
  static const orders = 'orders';
}


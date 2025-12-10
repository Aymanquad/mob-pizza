# MOB PIZZA - Flutter Migration & Implementation Guide

## 🎯 FLUTTER VS EXPO COMPARISON

### Why Flutter Over Expo?

| Feature | Expo | Flutter | Winner |
|---------|------|---------|--------|
| **Build Limit** | 5/month free | Unlimited | ✅ Flutter |
| **Build Time** | 15-20 minutes | 5-10 minutes | ✅ Flutter (2-4x faster) |
| **Build Queue** | Yes (waiting) | No | ✅ Flutter |
| **Free CI/CD** | ❌ No | ✅ GitHub Actions | ✅ Flutter |
| **Monthly Cost** | $348+/month | $0/month | ✅ Flutter ($4,176/year save) |
| **App Size** | 120-150 MB | 50-80 MB | ✅ Flutter (30% smaller) |
| **Performance** | Good | Excellent | ✅ Flutter |
| **Language** | JavaScript | Dart | Tie |
| **Ecosystem** | Medium | Growing | Flutter |
| **Job Market** | Declining | Growing | ✅ Flutter |
| **Long-term** | Uncertain | Backed by Google | ✅ Flutter |

---

## 💰 COST ANALYSIS: EXPO VS FLUTTER

### Annual Costs Breakdown

```
EXPO PATH (Original)
├── EAS Build Credits: $348/month × 12 = $4,176/year
├── App Store: $99/year
├── Play Store: $25/year
└── TOTAL: $4,300/year

FLUTTER PATH (New) ⭐ SAVINGS!
├── GitHub Actions: $0/month (2,000 min free)
├── App Store: $99/year
├── Play Store: $25/year
└── TOTAL: $124/year

SAVINGS: $4,176/year ✅
```

### Build Speed Comparison

```
Task                    Expo        Flutter     Time Saved
───────────────────────────────────────────────────────────
Cold Build Start        20-25 min   8-12 min    ✅ 8-17 min
Warm Rebuild            15-20 min   5-8 min     ✅ 7-15 min
Hot Reload              Available   Available   Tie
APK Generation          5 min       2 min       ✅ 3 min
IPA Generation          10 min      5 min       ✅ 5 min
Deployment              3-5 min     2 min       ✅ 1-3 min
───────────────────────────────────────────────────────────
TOTAL PER BUILD         20-25 min   5-10 min    ✅ 50-80% faster
```

---

## 📱 FLUTTER PROJECT STRUCTURE

### Complete Folder Structure (Mobile App)

```
mob-pizza-flutter/
│
├── lib/                                # Main Dart code
│   ├── main.dart                       # Entry point, app setup
│   │
│   ├── config/
│   │   ├── constants.dart              # App constants
│   │   ├── theme.dart                  # Material Design 3 theme
│   │   └── app_router.dart             # Go Router configuration
│   │
│   ├── models/
│   │   ├── user_model.dart             # User data class
│   │   ├── menu_item_model.dart        # MenuItem data class
│   │   ├── order_model.dart            # Order data class
│   │   ├── address_model.dart          # Address data class
│   │   ├── review_model.dart           # Review data class
│   │   └── promo_model.dart            # Promo data class
│   │
│   ├── providers/                      # Riverpod state management
│   │   ├── auth_provider.dart          # Authentication state
│   │   ├── menu_provider.dart          # Menu state
│   │   ├── cart_provider.dart          # Shopping cart state
│   │   ├── order_provider.dart         # Orders state
│   │   ├── user_provider.dart          # User profile state
│   │   └── ui_provider.dart            # UI state (theme, language)
│   │
│   ├── services/                       # Business logic & API calls
│   │   ├── api_service.dart            # API client setup (Dio)
│   │   ├── auth_service.dart           # Auth logic
│   │   ├── menu_service.dart           # Menu API calls
│   │   ├── order_service.dart          # Order API calls
│   │   ├── payment_service.dart        # Razorpay integration
│   │   ├── location_service.dart       # Google Maps integration
│   │   ├── notification_service.dart   # Firebase FCM setup
│   │   ├── storage_service.dart        # Local storage (Hive)
│   │   ├── image_service.dart          # Image upload/cache
│   │   └── socket_service.dart         # WebSocket (optional)
│   │
│   ├── screens/                        # UI screens (35+ screens)
│   │   │
│   │   ├── auth/
│   │   │   ├── splash_screen.dart
│   │   │   ├── sign_in_screen.dart
│   │   │   ├── sign_up_screen.dart
│   │   │   ├── forgot_password_screen.dart
│   │   │   └── otp_screen.dart
│   │   │
│   │   ├── home/
│   │   │   ├── home_screen.dart        # Main home page
│   │   │   ├── search_screen.dart      # Search items
│   │   │   └── filters_screen.dart     # Filter options
│   │   │
│   │   ├── menu/
│   │   │   ├── menu_list_screen.dart   # Category menu
│   │   │   ├── item_detail_screen.dart # Item with customization
│   │   │   ├── reviews_screen.dart     # Item reviews
│   │   │   └── customization_bottom_sheet.dart
│   │   │
│   │   ├── cart/
│   │   │   └── cart_screen.dart        # Shopping cart
│   │   │
│   │   ├── checkout/
│   │   │   ├── checkout_screen.dart
│   │   │   ├── address_selection_screen.dart
│   │   │   ├── address_entry_screen.dart
│   │   │   ├── payment_screen.dart
│   │   │   └── order_confirmation_screen.dart
│   │   │
│   │   ├── orders/
│   │   │   ├── orders_list_screen.dart
│   │   │   ├── order_detail_screen.dart
│   │   │   ├── order_tracking_screen.dart
│   │   │   └── delivery_tracking_map.dart
│   │   │
│   │   └── profile/
│   │       ├── profile_screen.dart
│   │       ├── edit_profile_screen.dart
│   │       ├── addresses_screen.dart
│   │       ├── address_form_screen.dart
│   │       ├── payment_methods_screen.dart
│   │       ├── settings_screen.dart
│   │       ├── loyalty_screen.dart
│   │       ├── favorites_screen.dart
│   │       └── help_screen.dart
│   │
│   ├── widgets/                        # Reusable components
│   │   │
│   │   ├── common/
│   │   │   ├── custom_button.dart
│   │   │   ├── custom_text_field.dart
│   │   │   ├── custom_card.dart
│   │   │   ├── custom_loader.dart
│   │   │   ├── custom_app_bar.dart
│   │   │   ├── custom_bottom_nav.dart
│   │   │   ├── empty_state_widget.dart
│   │   │   ├── error_widget.dart
│   │   │   ├── network_image_widget.dart
│   │   │   └── shimmer_loading.dart
│   │   │
│   │   ├── home/
│   │   │   ├── promo_carousel.dart
│   │   │   ├── category_chip.dart
│   │   │   ├── item_card.dart
│   │   │   └── recent_order_card.dart
│   │   │
│   │   ├── menu/
│   │   │   ├── menu_category_tab.dart
│   │   │   ├── item_list_tile.dart
│   │   │   ├── size_selector.dart
│   │   │   ├── topping_selector.dart
│   │   │   └── quantity_selector.dart
│   │   │
│   │   └── order/
│   │       ├── order_status_widget.dart
│   │       ├── order_tracking_widget.dart
│   │       ├── driver_info_card.dart
│   │       └── order_summary_card.dart
│   │
│   ├── utils/
│   │   ├── validators.dart             # Form validation
│   │   ├── formatters.dart             # Date, currency formatting
│   │   ├── logger.dart                 # Debug logging
│   │   ├── extensions.dart             # String, DateTime extensions
│   │   └── constants.dart              # String constants
│   │
│   └── exceptions/
│       ├── api_exception.dart
│       ├── app_exception.dart
│       └── cache_exception.dart
│
├── assets/
│   ├── images/                         # Food images, illustrations
│   ├── icons/                          # Custom icons (SVG/PNG)
│   ├── fonts/                          # Custom fonts (if needed)
│   └── json/                           # Mock data for testing
│
├── test/
│   ├── unit/                           # Unit tests
│   ├── widget/                         # Widget tests
│   └── integration/                    # Integration tests
│
├── android/                            # Android-specific code
│   ├── app/
│   │   ├── src/main/AndroidManifest.xml
│   │   ├── build.gradle
│   │   └── src/main/kotlin/
│   └── build.gradle
│
├── ios/                                # iOS-specific code
│   ├── Runner.xcodeproj
│   ├── Podfile
│   └── Runner/
│
├── web/                                # Web build files (optional)
│
├── .env                                # Environment variables
├── .env.example                        # Example env file
├── .gitignore
├── pubspec.yaml                        # Dependencies & configuration
├── pubspec.lock                        # Dependency lock file
├── analysis_options.yaml               # Dart analysis configuration
├── README.md                           # Project README
├── CHANGELOG.md                        # Version history
└── LICENSE                             # MIT/Apache license
```

---

## 📦 PUBSPEC.YAML - COMPLETE DEPENDENCIES

```yaml
name: mob_pizza_flutter
description: Mob Pizza - Multi-platform food ordering app

publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # State Management
  riverpod: ^2.4.0
  flutter_riverpod: ^2.4.0
  riverpod_annotation: ^2.1.0

  # Networking
  dio: ^5.3.0
  http: ^1.1.0

  # Navigation & Routing
  go_router: ^10.0.0

  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  shared_preferences: ^2.2.0
  flutter_secure_storage: ^9.0.0

  # UI Components & Design
  flutter_svg: ^2.0.0
  cached_network_image: ^3.3.0
  shimmer: ^3.0.0
  google_maps_flutter: ^2.5.0
  google_maps_flutter_web: ^0.5.0
  smooth_page_indicator: ^1.1.0

  # Form & Validation
  reactive_forms: ^16.0.0
  validators: ^3.0.0

  # Date & Time
  intl: ^0.19.0

  # Environment & Config
  flutter_dotenv: ^5.1.0

  # Notifications
  firebase_messaging: ^14.6.0
  flutter_local_notifications: ^15.1.0

  # Payment
  razorpay_flutter: ^1.3.0

  # Image Handling
  image_picker: ^1.0.0
  image_cropper: ^5.0.0

  # Logging
  logger: ^2.0.0
  sentry_flutter: ^7.8.0

  # Authentication
  google_sign_in: ^6.1.0

  # Real-time Updates
  web_socket_channel: ^2.4.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  # Code generation
  build_runner: ^2.4.0
  riverpod_generator: ^2.3.0
  hive_generator: ^2.0.0

  # Testing
  mockito: ^5.4.0
  mocktail: ^1.0.0
  integration_test:
    sdk: flutter

  # Linting
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true

  assets:
    - assets/images/
    - assets/icons/
    - assets/json/
    - .env

  fonts:
    - family: Poppins
      fonts:
        - asset: assets/fonts/Poppins-Regular.ttf
        - asset: assets/fonts/Poppins-Bold.ttf
          weight: 700
```

---

## 🔧 FLUTTER SETUP GUIDE

### Prerequisites
```bash
# Install Flutter (if not already installed)
# Download from https://flutter.dev/docs/get-started/install

# Verify installation
flutter --version
flutter doctor

# Make sure all checks pass (at least Android SDK, iOS for Mac)
```

### Project Setup

```bash
# Create new Flutter project
flutter create mob_pizza_flutter
cd mob_pizza_flutter

# Or clone from repo
git clone <repo-url>
cd mob_pizza_flutter

# Install dependencies
flutter pub get

# Install code generation dependencies
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs

# Setup environment
cp .env.example .env
# Edit .env with your API URLs and keys
```

---

## 🏗️ GITHUB ACTIONS CI/CD (FREE BUILDS)

### Create `.github/workflows/flutter_build.yml`

```yaml
name: Flutter Build & Release

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  build_android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.13.0'
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Build APK
        run: flutter build apk --release
      
      - name: Upload APK
        uses: actions/upload-artifact@v3
        with:
          name: app-release.apk
          path: build/app/outputs/flutter-apk/app-release.apk

  build_ios:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.13.0'
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Build IPA
        run: flutter build ios --release --no-codesign
      
      - name: Upload IPA
        uses: actions/upload-artifact@v3
        with:
          name: Runner.ipa
          path: build/ios/iphoneos/Runner.app
```

---

## 🚀 BUILD & DEPLOYMENT COMMANDS

### Development
```bash
# Run on iOS simulator
flutter run -d iPhone

# Run on Android emulator
flutter run -d emulator-5554

# Run with hot reload enabled
flutter run

# Hot restart (full app restart, keeps state)
flutter hot-reload

# Full restart (complete restart)
flutter hot-restart

# Run with specific dart defines
flutter run --dart-define=ENVIRONMENT=dev
```

### Production Build

```bash
# Android APK (Google Play Store)
flutter build apk --release

# Android App Bundle (recommended for Play Store)
flutter build appbundle --release

# iOS IPA (Apple App Store)
flutter build ios --release

# Build for Web (optional)
flutter build web --release
```

---

## 📊 KEY RIVERPOD STATE MANAGEMENT EXAMPLES

### Auth Provider

```dart
// lib/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth state notifier
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.initial());

  Future<void> login(String email, String password) async {
    state = AuthState.loading();
    try {
      final token = await authService.login(email, password);
      state = AuthState.authenticated(token);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> logout() async {
    await authService.logout();
    state = AuthState.initial();
  }
}

// Providers
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);

final isAuthenticatedProvider = Provider<bool>(
  (ref) {
    return ref.watch(authNotifierProvider).maybeWhen(
          authenticated: (_) => true,
          orElse: () => false,
        );
  },
);
```

### Cart Provider

```dart
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(MenuItem item, {required String size}) {
    state = [...state, CartItem(item: item, size: size, quantity: 1)];
  }

  void removeItem(String itemId) {
    state = state.where((item) => item.item.id != itemId).toList();
  }

  void updateQuantity(String itemId, int quantity) {
    state = state.map((item) {
      if (item.item.id == itemId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();
  }

  double getTotal() {
    return state.fold(0, (sum, item) => sum + item.totalPrice);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);
```

---

## 🔌 API INTEGRATION WITH DIO

```dart
// lib/services/api_service.dart
import 'package:dio/dio.dart';

class ApiService {
  late Dio _dio;
  
  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://api.mobpizza.com/api/v1',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: Headers.jsonContentType,
      ),
    );

    // Add token interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storageService.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            // Token expired, refresh or logout
          }
          return handler.next(error);
        },
      ),
    );
  }

  // Example API call
  Future<List<MenuItem>> getMenuItems() async {
    try {
      final response = await _dio.get('/menu/items');
      return (response.data['data']['items'] as List)
          .map((item) => MenuItem.fromJson(item))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // Create order
  Future<Order> createOrder(CreateOrderRequest request) async {
    final response = await _dio.post('/orders', data: request.toJson());
    return Order.fromJson(response.data['data']);
  }
}

// Provider
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());
```

---

## 📲 FIREBASE NOTIFICATIONS SETUP

```dart
// lib/services/notification_service.dart
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permission
    await _messaging.requestPermission();

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
    });

    // Get FCM token for server
    String? token = await _messaging.getToken();
    print('FCM Token: $token');
    // Send this token to backend for push notifications
  }
}

// Background handler (must be top-level)
Future<void> _backgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}
```

---

## 🧪 TESTING FLUTTER APP

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/main_test.dart

# Generate coverage report
flutter test --coverage
lcov --list coverage/lcov.info
```

---

## 📱 PAYMENT INTEGRATION (Razorpay)

```dart
// lib/services/payment_service.dart
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  late Razorpay _razorpay;

  PaymentService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void startPayment(double amount) {
    var options = {
      'key': 'YOUR_RAZORPAY_KEY',
      'amount': (amount * 100).toInt(), // Convert to paise
      'name': 'Mob Pizza',
      'description': 'Order Payment',
      'timeout': 300, // in seconds
      'prefill': {
        'contact': '+919876543210',
        'email': 'user@example.com'
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('SUCCESS: ${response.paymentId}');
    // Verify with backend
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('ERROR: ${response.code} ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('EXTERNAL WALLET: ${response.walletName}');
  }
}
```

---

## 🎁 FINAL BENEFITS SUMMARY

### Cost Savings
✅ **$4,176/year saved** on build costs
✅ **$0/month** for CI/CD (GitHub Actions)
✅ **Unlimited builds** (no queue waiting)

### Performance
✅ **50-80 MB app size** (30% smaller)
✅ **5-10 min builds** (50-80% faster)
✅ **Native Dart performance** (better runtime)

### Development
✅ **Hot reload** (fast feedback)
✅ **Great tooling** (VS Code, Android Studio)
✅ **Excellent documentation** (flutter.dev)

### Future
✅ **Google backing** (long-term support)
✅ **Growing ecosystem** (more packages)
✅ **Job market** (increasing demand)

---

## ✅ NEXT STEPS

1. **Install Flutter SDK** - https://flutter.dev/docs/get-started/install
2. **Create Project** - `flutter create mob_pizza_flutter`
3. **Setup Environment** - Copy `.env.example` to `.env`
4. **Install Dependencies** - `flutter pub get`
5. **Run App** - `flutter run`
6. **Setup GitHub Actions** - Add CI/CD workflow
7. **Start Development** - Follow 16-week timeline

---

**You're all set for Flutter development! 🚀**

**Enjoy building, faster builds, and $4,000/year in savings! 🎉**

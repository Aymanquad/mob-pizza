import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:mob_pizza_mobile/config/theme.dart';
import 'package:mob_pizza_mobile/config/app_router.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';
import 'package:mob_pizza_mobile/providers/locale_provider.dart';
import 'package:mob_pizza_mobile/providers/cart_provider.dart';
import 'package:mob_pizza_mobile/providers/order_provider.dart';
import 'package:mob_pizza_mobile/config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isOnboarded = prefs.getBool(PrefKeys.onboardingCompleted) ?? false;
  final localeCode = prefs.getString(PrefKeys.localeCode) ?? 'en';
  final storedPhone = prefs.getString(PrefKeys.phone) ?? '';
  final storedEmail = prefs.getString(PrefKeys.email) ?? '';
  final storedGoogleId = prefs.getString(PrefKeys.googleId) ?? '';
  // Treat any valid identifier (phone OR email/google) as sufficient for onboarding.
  final hasIdentifier = storedPhone.isNotEmpty || storedEmail.isNotEmpty || storedGoogleId.isNotEmpty;
  final effectiveOnboarded = isOnboarded && hasIdentifier;

  // Create providers and load saved data
  final cartProvider = CartProvider();
  await cartProvider.loadCart();

  final orderProvider = OrderProvider();
  await orderProvider.loadOrders();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: LocaleProvider(initialLocale: Locale(localeCode)),
        ),
        ChangeNotifierProvider.value(
          value: cartProvider,
        ),
        ChangeNotifierProvider.value(
          value: orderProvider,
        ),
      ],
      child: MobPizzaApp(isOnboarded: effectiveOnboarded),
    ),
  );
}

class MobPizzaApp extends StatefulWidget {
  const MobPizzaApp({super.key, required this.isOnboarded});

  final bool isOnboarded;

  @override
  State<MobPizzaApp> createState() => _MobPizzaAppState();
}

class _MobPizzaAppState extends State<MobPizzaApp> {
  late final router = AppRouter.create(isOnboarded: widget.isOnboarded);

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp.router(
      title: 'Mob Pizza',
      theme: buildTheme(),
      routerConfig: router,
      locale: localeProvider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('es', ''), // Spanish
      ],
    );
  }
}


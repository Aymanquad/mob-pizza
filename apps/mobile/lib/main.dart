import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:mob_pizza_mobile/config/theme.dart';
import 'package:mob_pizza_mobile/config/app_router.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';
import 'package:mob_pizza_mobile/providers/locale_provider.dart';
import 'package:mob_pizza_mobile/config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isOnboarded = prefs.getBool(PrefKeys.onboardingCompleted) ?? false;
  final localeCode = prefs.getString(PrefKeys.localeCode) ?? 'en';
  final storedPhone = prefs.getString(PrefKeys.phone) ?? '';
  final effectiveOnboarded = isOnboarded && storedPhone.isNotEmpty;

  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(initialLocale: Locale(localeCode)),
      child: MobPizzaApp(isOnboarded: effectiveOnboarded),
    ),
  );
}

class MobPizzaApp extends StatelessWidget {
  const MobPizzaApp({super.key, required this.isOnboarded});

  final bool isOnboarded;

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.create(isOnboarded: isOnboarded);
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


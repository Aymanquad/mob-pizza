import 'package:flutter/material.dart';
import 'package:mob_pizza_mobile/config/theme.dart';
import 'package:mob_pizza_mobile/config/app_router.dart';

void main() {
  runApp(const MobPizzaApp());
}

class MobPizzaApp extends StatelessWidget {
  const MobPizzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.router;
    return MaterialApp.router(
      title: 'Mob Pizza',
      theme: buildTheme(),
      routerConfig: router,
    );
  }
}


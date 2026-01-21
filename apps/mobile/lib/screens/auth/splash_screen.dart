import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) context.go('/sign-in');
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B0C10), Color(0xFF1C1512)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Further reduced and padded to avoid any zoomed-in feel on launch
              Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  // Use zoomed-out version for splash so it never feels cropped/zoomed.
                  'assets/images/mobpizza_zoomedout_logo.png',
                  height: 120,
                  width: 120,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              Text(l10n.homeScreenSubtitle, style: const TextStyle(color: Color(0xFFC0B8A8), fontSize: 16)),
              const SizedBox(height: 8),
              Text(l10n.cinematicPiesSpeakeasy, style: const TextStyle(color: Color(0xFFC0B8A8), fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}


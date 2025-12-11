import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            children: const [
              Icon(Icons.local_pizza, size: 78, color: Color(0xFFD9A441)),
              SizedBox(height: 12),
              Text('Mob Pizza', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
              SizedBox(height: 6),
              Text('The Family’s Slice Since 1928', style: TextStyle(color: Color(0xFFC0B8A8))),
              SizedBox(height: 8),
              Text('Cinematic pies, speakeasy service.', style: TextStyle(color: Color(0xFFC0B8A8))),
            ],
          ),
        ),
      ),
    );
  }
}


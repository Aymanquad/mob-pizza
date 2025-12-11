import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final headingStyle = GoogleFonts.cinzel(
      textStyle: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFFF5E8C7)),
    );
    final subheadStyle = GoogleFonts.inter(
      textStyle: const TextStyle(color: Color(0xFFC6A667)),
    );
    final fieldStyle = GoogleFonts.inter(
      textStyle: const TextStyle(color: Color(0xFFF5E8C7)),
    );
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFC6A667),
      foregroundColor: const Color(0xFF0F0F0F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: const TextStyle(fontWeight: FontWeight.w800),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Back in the Family')),
      body: Container(
        color: const Color(0xFF0F0F0F),
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text('Sign In', style: headingStyle),
            const SizedBox(height: 6),
            Text('Enter your credentials to get back in. We keep it hush.', style: subheadStyle),
            const SizedBox(height: 20),
            TextField(
              style: fieldStyle,
              decoration: const InputDecoration(labelText: 'Email or Phone', hintText: 'you@example.com'),
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: true,
              style: fieldStyle,
              decoration: const InputDecoration(labelText: 'Password', hintText: '••••••••'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: buttonStyle,
                onPressed: () => context.go('/'),
                child: const Text('Back in the Family'),
              ),
            ),
            TextButton(
              onPressed: () => context.go('/sign-up'),
              child: Text('Join the Family', style: subheadStyle.copyWith(color: const Color(0xFFC6A667))),
            ),
          ],
        ),
      ),
    );
  }
}


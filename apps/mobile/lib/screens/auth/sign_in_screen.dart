import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Back in the Family')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sign In', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            const Text('Enter your credentials to get back in.'),
            const SizedBox(height: 20),
            TextField(decoration: const InputDecoration(labelText: 'Email or Phone', hintText: 'you@example.com')),
            const SizedBox(height: 12),
            TextField(obscureText: true, decoration: const InputDecoration(labelText: 'Password', hintText: '••••••••')),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Back in the Family'),
              ),
            ),
            TextButton(onPressed: () => context.go('/sign-up'), child: const Text('Join the Family')),
          ],
        ),
      ),
    );
  }
}


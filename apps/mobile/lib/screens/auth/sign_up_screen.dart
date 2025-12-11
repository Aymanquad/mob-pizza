import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Join the Family')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text('Create Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            const Text('We keep it hush. Only the family knows. Your credentials stay in the vault.'),
            const SizedBox(height: 20),
            TextField(decoration: const InputDecoration(labelText: 'Name')),
            const SizedBox(height: 12),
            TextField(decoration: const InputDecoration(labelText: 'Email', hintText: 'you@example.com')),
            const SizedBox(height: 12),
            TextField(decoration: const InputDecoration(labelText: 'Phone')),
            const SizedBox(height: 12),
            TextField(obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Join the Family'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


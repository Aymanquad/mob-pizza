import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    final addressCtrl = TextEditingController();

    final headingStyle = GoogleFonts.cinzel(
      textStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFFF5E8C7)),
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
      appBar: AppBar(
        title: Image.asset(
          'assets/images/mobpizza_logo.png',
          height: 32,
          width: 100,
          fit: BoxFit.contain,
        ),
        backgroundColor: const Color(0xFF1C1512),
        foregroundColor: const Color(0xFFF5E8C7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF5E8C7)),
          onPressed: () => context.go('/sign-in'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/mobpizza_logo.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              Text(l10n.createAccount, style: headingStyle),
              const SizedBox(height: 6),
              Text('We keep it hush. Only the family knows. Your credentials stay in the vault.', style: subheadStyle),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameCtrl,
                style: fieldStyle,
                decoration: InputDecoration(labelText: l10n.fullName),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Name is required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailCtrl,
                style: fieldStyle,
                decoration: InputDecoration(labelText: l10n.email, hintText: 'you@example.com'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Email is required';
                  if (!RegExp(r'^[^@\\s]+@[^@\\s]+\\.[^@\\s]+\$').hasMatch(v.trim())) return 'Enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: phoneCtrl,
                style: fieldStyle,
                decoration: InputDecoration(labelText: l10n.phoneNumber, hintText: '+19998887777'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Phone is required';
                  if (!RegExp(r'^\\+\\d{8,15}\$').hasMatch(v.trim())) return 'Use E.164 phone format';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: addressCtrl,
                style: fieldStyle,
                decoration: const InputDecoration(labelText: 'Location / Address', hintText: 'Street, City, Zip'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Address is required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: passCtrl,
                obscureText: true,
                style: fieldStyle,
                decoration: InputDecoration(labelText: l10n.password, hintText: 'Min 8 chars, 1 upper, 1 number'),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Password is required';
                  if (v.length < 8) return 'At least 8 characters';
                  if (!RegExp(r'[A-Z]').hasMatch(v)) return 'Add at least one uppercase letter';
                  if (!RegExp(r'\\d').hasMatch(v)) return 'Add at least one number';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      // TODO: call register API with name, email, phone, address, password
                      context.go('/');
                    }
                  },
                  child: Text(l10n.signUp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


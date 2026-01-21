import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';
import 'package:mob_pizza_mobile/screens/onboarding/onboarding_data.dart';

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _submitting = false;
  bool _signingInWithGoogle = false;
  
  // Configure Google Sign-In with proper scopes
  final _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _signingInWithGoogle = true);
    try {
      // Sign out first to force account selection and clear any cached account
      await _googleSignIn.signOut();
      
      // Clear any old phone number from previous sessions
      _phoneController.clear();
      
      // Now sign in - this will show account picker
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled sign-in
        setState(() => _signingInWithGoogle = false);
        return;
      }
      
      // Extract user info
      final email = googleUser.email;
      final googleId = googleUser.id;
      
      // Validate required OAuth fields
      if (email.isEmpty || googleId.isEmpty) {
        throw Exception('Google Sign-In did not provide required information (email or ID)');
      }
      
      final displayName = googleUser.displayName ?? '';
      final nameParts = displayName.trim().split(' ').where((part) => part.isNotEmpty).toList();
      final firstName = nameParts.isNotEmpty ? nameParts.first : 'User';
      final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      // Navigate to screen 2 with Google data
      final phone = _phoneController.text.trim().isNotEmpty ? _phoneController.text.trim() : null;
      final data = OnboardingData(
        phone: phone,
        email: email,
        googleId: googleId,
        firstName: firstName,
        lastName: lastName.isEmpty ? null : lastName,
      );
      
      if (mounted) {
        context.go('/onboarding/personalize', extra: data);
      }
    } catch (e) {
      debugPrint('[onboarding_1] Google sign-in error: $e');
      if (mounted) {
        String errorMessage = 'Google Sign-In failed';
        String details = '';
        
        if (e.toString().contains('ApiException: 10') || 
            e.toString().contains('sign_In_falled')) {
          errorMessage = 'Google Sign-In Configuration Error';
          details = 'The app needs to be configured in Google Cloud Console. '
              'Please check:\n'
              '1. Package name: com.mobpizza.app\n'
              '2. SHA-1 fingerprint is added\n'
              '3. OAuth client ID is configured';
        } else if (e.toString().contains('12500')) {
          errorMessage = 'Sign-In Cancelled';
          details = 'You cancelled the sign-in process';
        } else {
          details = e.toString();
        }
        
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(errorMessage),
            content: SingleChildScrollView(
              child: Text(details),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _signingInWithGoogle = false);
    }
  }

  void _continue() {
    final phone = _phoneController.text.trim();
    
    // Validate phone format if provided
    if (!(_formKey.currentState?.validate() ?? false)) return;
    
    // Phone is required if not signing in with Google
    if (phone.isEmpty && !_signingInWithGoogle) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a phone number or sign in with Google'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    // Navigate to screen 2 with phone data
    final data = OnboardingData(
      phone: phone.isNotEmpty ? phone : null,
    );
    
    context.go('/onboarding/personalize', extra: data);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Logo
                Center(
                  child: Image.asset(
                    'assets/images/mobpizza_logo.jpg',
                    height: 80,
                    width: 80,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  l10n.joinTheFamily,
                  style: const TextStyle(
                    color: Color(0xFFF5E8C7),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Fast, secure & personalized experience',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                // Google Sign-In Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: (_signingInWithGoogle || _submitting) ? null : _signInWithGoogle,
                    icon: _signingInWithGoogle
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFD9A441)),
                          )
                        : Image.asset(
                            'assets/icons/google_logo.png',
                            height: 20,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.login,
                              color: Color(0xFFD9A441),
                            ),
                          ),
                    label: Text(
                      _signingInWithGoogle ? 'Signing in...' : 'Continue with Google',
                      style: const TextStyle(color: Color(0xFFD9A441)),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFD9A441)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Divider with "OR"
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[800])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[800])),
                  ],
                ),
                const SizedBox(height: 16),
                // Phone Number Field
                Text(
                  l10n.phoneNumber,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                    LengthLimitingTextInputFormatter(15),
                  ],
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF5E8C7),
                    hintText: '+1',
                    hintStyle: const TextStyle(color: Colors.black54),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFD9A441)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFD9A441), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    // Phone is optional, but if provided, validate it
                    if (v.isNotEmpty) {
                      final regex = RegExp(r'^\+?[0-9]{10,15}$');
                      if (!regex.hasMatch(v)) return l10n.enterValidPhone;
                    }
                    return null;
                  },
                ),
                const Spacer(),
                // Privacy text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.lock_outline,
                      color: Color(0xFFD9A441),
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'We never share your data',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Continue Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (_submitting || _signingInWithGoogle) ? null : _continue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD9A441),
                      foregroundColor: const Color(0xFF0B0C10),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _submitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF0B0C10)),
                          )
                        : const Text('Continue'),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


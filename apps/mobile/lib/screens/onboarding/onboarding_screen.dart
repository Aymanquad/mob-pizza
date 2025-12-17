import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mob_pizza_mobile/config/constants.dart';
import 'package:mob_pizza_mobile/providers/locale_provider.dart';
import 'package:mob_pizza_mobile/services/onboarding_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  String _locale = 'en';
  bool _allowLocation = false;
  bool _allowNotifications = false;
  bool _submitting = false;
  final _service = OnboardingService();
  String? _lastError;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    final locStatus = await Permission.location.request();
    final notifStatus = await Permission.notification.request();
    if (!mounted) return;
    setState(() {
      _allowLocation = locStatus.isGranted;
      _allowNotifications = notifStatus.isGranted;
    });
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _submitting = true);
    try {
      debugPrint('[onboarding_ui] submitting...');
      await _service.submitOnboarding(
        phone: _phoneController.text.trim(),
        locale: _locale,
        allowLocation: _allowLocation,
        allowNotifications: _allowNotifications,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(PrefKeys.onboardingCompleted, true);
      await prefs.setString(PrefKeys.localeCode, _locale);
      await prefs.setString(PrefKeys.phone, _phoneController.text.trim());
      await prefs.setBool(PrefKeys.allowLocation, _allowLocation);
      await prefs.setBool(PrefKeys.allowNotifications, _allowNotifications);

      debugPrint('[onboarding_ui] saved locally, navigating home');
      if (mounted) {
        context.read<LocaleProvider>().setLocale(Locale(_locale));
        context.go('/');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Onboarding saved')),
        );
      }
    } catch (e) {
      _lastError = e.toString();
      debugPrint('[onboarding_ui] error: $_lastError');
      if (!mounted) return;
      final proceed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Network issue'),
          content: Text(
            'Could not reach the server. Continue offline? (Data will be stored locally and will sync when online.)\n\nDetails: $_lastError',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Continue offline'),
            ),
          ],
        ),
      );

      if (proceed != true) {
        setState(() => _submitting = false);
        return;
      }

      // Offline fallback: mark onboarding locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(PrefKeys.onboardingCompleted, true);
      await prefs.setString(PrefKeys.localeCode, _locale);
      await prefs.setString(PrefKeys.phone, _phoneController.text.trim());
      await prefs.setBool(PrefKeys.allowLocation, _allowLocation);
      await prefs.setBool(PrefKeys.allowNotifications, _allowNotifications);

      debugPrint('[onboarding_ui] offline path saved, navigating home');
      if (mounted) {
        context.read<LocaleProvider>().setLocale(Locale(_locale));
        context.go('/');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Onboarding saved (offline)')),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                const Text(
                  'Join the Family',
                  style: TextStyle(
                    color: Color(0xFFF5E8C7),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
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
                    labelText: 'Phone Number',
                    labelStyle: const TextStyle(color: Colors.black87),
                    hintText: '+15551234567 or 9876543210',
                    hintStyle: const TextStyle(color: Colors.black54),
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
                    final regex = RegExp(r'^\+?[0-9]{10,15}$');
                    if (v.isEmpty) return 'Phone is required';
                    if (!regex.hasMatch(v)) return 'Enter valid phone';
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField<String>(
                  value: _locale,
                  dropdownColor: const Color(0xFF1C1512),
                  decoration: const InputDecoration(
                    labelText: 'Language',
                    labelStyle: TextStyle(color: Color(0xFF919F89)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3A3A3A)),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text('English', style: TextStyle(color: Colors.white)),
                    ),
                    DropdownMenuItem(
                      value: 'es',
                      child: Text('Español', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _locale = value ?? 'en';
                    });
                  },
                ),
                const SizedBox(height: 24),
                SwitchListTile(
                  value: _allowLocation,
                  onChanged: (val) => setState(() => _allowLocation = val),
                  title: const Text('Allow Location', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('Helps confirm delivery area', style: TextStyle(color: Color(0xFF919F89))),
                  activeColor: const Color(0xFFD9A441),
                ),
                SwitchListTile(
                  value: _allowNotifications,
                  onChanged: (val) => setState(() => _allowNotifications = val),
                  title: const Text('Allow Notifications', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('Order updates & offers', style: TextStyle(color: Color(0xFF919F89))),
                  activeColor: const Color(0xFFD9A441),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: _requestPermissions,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFD9A441),
                    side: const BorderSide(color: Color(0xFFD9A441)),
                  ),
                  child: const Text('Request Permissions'),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitting ? null : _submit,
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


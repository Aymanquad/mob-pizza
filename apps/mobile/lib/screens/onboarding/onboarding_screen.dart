import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mob_pizza_mobile/config/constants.dart';
import 'package:mob_pizza_mobile/providers/locale_provider.dart';
import 'package:mob_pizza_mobile/services/onboarding_service.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
  bool _testingConnection = false;
  final _service = OnboardingService();
  String? _lastError;
  String? _connectionStatus;

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

  Future<void> _testConnection() async {
    setState(() {
      _testingConnection = true;
      _connectionStatus = null;
    });

    try {
      // Try to reach the backend by making a simple request
      // We'll try to get a user profile with a test phone number
      final testUrl = '$apiBaseUrl/users/test123';
      debugPrint('[onboarding] Testing connection to: $testUrl');
      
      final response = await http.get(
        Uri.parse(testUrl),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 5));

      if (mounted) {
        setState(() {
          _testingConnection = false;
          if (response.statusCode == 200 || response.statusCode == 404) {
            // 200 = success, 404 = backend is reachable but user not found (which is fine)
            _connectionStatus = '✅ Connected! Backend is reachable.';
          } else {
            _connectionStatus = '⚠️ Backend responded with status: ${response.statusCode}';
          }
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_connectionStatus!),
            backgroundColor: response.statusCode == 200 || response.statusCode == 404
                ? Colors.green
                : Colors.orange,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _testingConnection = false;
          _connectionStatus = '❌ Connection failed: ${e.toString()}';
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Cannot reach backend: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
      debugPrint('[onboarding] Connection test failed: $e');
    }
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
        context.go('/');
        // Apply locale after navigation so onboarding screen doesn't change language
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            context.read<LocaleProvider>().setLocale(Locale(_locale));
            final l10n = AppLocalizations.of(context)!;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.onboardingSuccess)),
            );
          }
        });
      }
    } catch (e) {
      _lastError = e.toString();
      debugPrint('[onboarding_ui] error: $_lastError');
      if (!mounted) return;
      final proceed = await showDialog<bool>(
        context: context,
        builder: (ctx) {
          final ctxL10n = AppLocalizations.of(ctx)!;
          return AlertDialog(
            title: Text(ctxL10n.networkIssue),
            content: Text(
              '${ctxL10n.networkIssueMessage}\n\nDetails: $_lastError',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text(ctxL10n.cancel),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text(ctxL10n.continueOffline),
              ),
            ],
          );
        },
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
        context.go('/');
        // Apply locale after navigation so onboarding screen doesn't change language
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            context.read<LocaleProvider>().setLocale(Locale(_locale));
            final l10n = AppLocalizations.of(context)!;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.onboardingSuccessOffline)),
            );
          }
        });
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
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
                Text(
                  l10n.joinTheFamily,
                  style: const TextStyle(
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
                    labelText: l10n.phoneNumber,
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
                    if (v.isEmpty) return l10n.phoneRequired;
                    if (!regex.hasMatch(v)) return l10n.enterValidPhone;
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField<String>(
                  value: _locale,
                  dropdownColor: const Color(0xFF1C1512),
                  decoration: InputDecoration(
                    labelText: l10n.language,
                    labelStyle: const TextStyle(color: Color(0xFF919F89)),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3A3A3A)),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text(l10n.english, style: const TextStyle(color: Colors.white)),
                    ),
                    DropdownMenuItem(
                      value: 'es',
                      child: Text(l10n.spanish, style: const TextStyle(color: Colors.white)),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _locale = value ?? 'en';
                    });
                    // Locale will be applied when user clicks Continue and onboarding is saved
                  },
                ),
                const SizedBox(height: 24),
                SwitchListTile(
                  value: _allowLocation,
                  onChanged: (val) => setState(() => _allowLocation = val),
                  title: Text(l10n.allowLocation, style: const TextStyle(color: Colors.white)),
                  subtitle: Text(l10n.locationHelps, style: const TextStyle(color: Color(0xFF919F89))),
                  activeColor: const Color(0xFFD9A441),
                ),
                SwitchListTile(
                  value: _allowNotifications,
                  onChanged: (val) => setState(() => _allowNotifications = val),
                  title: Text(l10n.allowNotifications, style: const TextStyle(color: Colors.white)),
                  subtitle: Text(l10n.notificationsHelps, style: const TextStyle(color: Color(0xFF919F89))),
                  activeColor: const Color(0xFFD9A441),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _requestPermissions,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFD9A441),
                          side: const BorderSide(color: Color(0xFFD9A441)),
                        ),
                        child: Text(l10n.requestPermissions),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _testingConnection ? null : _testConnection,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFD9A441),
                          side: const BorderSide(color: Color(0xFFD9A441)),
                        ),
                        child: _testingConnection
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xFFD9A441),
                                ),
                              )
                            : const Text('Test Connection'),
                      ),
                    ),
                  ],
                ),
                if (_connectionStatus != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _connectionStatus!,
                    style: TextStyle(
                      color: _connectionStatus!.startsWith('✅')
                          ? Colors.green
                          : _connectionStatus!.startsWith('⚠️')
                              ? Colors.orange
                              : Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
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
                        : Text(l10n.continueButton),
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


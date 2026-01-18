import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:mob_pizza_mobile/config/constants.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';
import 'package:mob_pizza_mobile/providers/locale_provider.dart';
import 'package:mob_pizza_mobile/screens/onboarding/onboarding_data.dart';
import 'package:mob_pizza_mobile/services/onboarding_service.dart';
import 'package:mob_pizza_mobile/providers/order_provider.dart';
import 'package:mob_pizza_mobile/providers/cart_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen2 extends StatefulWidget {
  const OnboardingScreen2({super.key});

  @override
  State<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2> {
  String _locale = 'en';
  bool _allowLocation = false;
  bool _allowNotifications = false;
  bool _submitting = false;
  bool _testingConnection = false;
  final _service = OnboardingService();
  String? _lastError;
  String? _connectionStatus;
  OnboardingData? _userData;

  @override
  void initState() {
    super.initState();
    // Get data passed from screen 1 - read it in the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final state = GoRouterState.of(context);
        final data = state.extra as OnboardingData?;
        if (data != null && _userData == null) {
          setState(() {
            _userData = data;
          });
        }
      }
    });
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
      // Try the health endpoint first (at root, not under /api/v1)
      final baseUrl = apiBaseUrl.replaceAll('/api/v1', '');
      final healthUrl = '$baseUrl/health';
      debugPrint('[onboarding_2] Testing connection to: $healthUrl');
      
      final response = await http.get(
        Uri.parse(healthUrl),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (mounted) {
        setState(() {
          _testingConnection = false;
          if (response.statusCode == 200 || response.statusCode == 404) {
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
          String errorMessage = 'Connection failed';
          
          if (e.toString().contains('Failed host lookup') || 
              e.toString().contains('No address associated with hostname')) {
            errorMessage = '❌ DNS Error: Cannot resolve hostname.\n\n'
                'Possible causes:\n'
                '• No internet connection\n'
                '• Render service may be sleeping (free tier)\n'
                '• DNS server issue\n\n'
                'Try: Check internet connection or wait 30 seconds and retry.';
          } else if (e.toString().contains('timeout')) {
            errorMessage = '❌ Timeout: Backend took too long to respond.\n\n'
                'The server may be starting up (free tier takes ~30 seconds).';
          } else {
            errorMessage = '❌ Error: ${e.toString()}';
          }
          
          _connectionStatus = errorMessage;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _connectionStatus!,
              style: const TextStyle(fontSize: 12),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 6),
          ),
        );
      }
      debugPrint('[onboarding_2] Connection test failed: $e');
    }
  }

  Future<void> _submitOnboarding() async {
    if (_userData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Missing user data. Please go back and sign in.'),
          backgroundColor: Colors.red,
        ),
      );
      context.go('/onboarding');
      return;
    }

    // Phone or email/googleId is required
    final hasPhone = _userData!.phone != null && _userData!.phone!.isNotEmpty;
    final hasOAuth = _userData!.email != null && _userData!.googleId != null &&
                     _userData!.email!.isNotEmpty && _userData!.googleId!.isNotEmpty;
    
    if (!hasPhone && !hasOAuth) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone number or Google sign-in is required'),
          backgroundColor: Colors.red,
        ),
      );
      context.go('/onboarding');
      return;
    }

    setState(() => _submitting = true);
    try {
      debugPrint('[onboarding_2] submitting...');
      await _service.submitOnboarding(
        phone: _userData!.phone,
        email: _userData!.email,
        googleId: _userData!.googleId,
        firstName: _userData!.firstName,
        lastName: _userData!.lastName,
        locale: _locale,
        allowLocation: _allowLocation,
        allowNotifications: _allowNotifications,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(PrefKeys.onboardingCompleted, true);
      await prefs.setString(PrefKeys.localeCode, _locale);
      if (_userData!.phone != null && _userData!.phone!.isNotEmpty) {
        await prefs.setString(PrefKeys.phone, _userData!.phone!);
      }
      if (_userData!.email != null && _userData!.email!.isNotEmpty) {
        await prefs.setString(PrefKeys.email, _userData!.email!);
      }
      if (_userData!.googleId != null && _userData!.googleId!.isNotEmpty) {
        await prefs.setString(PrefKeys.googleId, _userData!.googleId!);
      }
      if (_userData!.firstName != null && _userData!.firstName!.isNotEmpty) {
        await prefs.setString(PrefKeys.firstName, _userData!.firstName!);
      }
      if (_userData!.lastName != null && _userData!.lastName!.isNotEmpty) {
        await prefs.setString(PrefKeys.lastName, _userData!.lastName!);
      }
      await prefs.setBool(PrefKeys.allowLocation, _allowLocation);
      await prefs.setBool(PrefKeys.allowNotifications, _allowNotifications);

      debugPrint('[onboarding_2] saved locally, navigating home');
      if (mounted) {
        // CRITICAL: Clear orders and cart cache before navigating
        // This ensures new user doesn't see previous user's cached data
        try {
          final orderProvider = Provider.of<OrderProvider>(context, listen: false);
          await orderProvider.clearOrders();
          debugPrint('[onboarding_2] Orders cleared before navigation');
          
          final cartProvider = Provider.of<CartProvider>(context, listen: false);
          await cartProvider.clearCartCache();
          debugPrint('[onboarding_2] Cart cleared before navigation');
        } catch (e) {
          debugPrint('[onboarding_2] Error clearing providers: $e');
        }
        
        context.go('/');
        // Apply locale after navigation so onboarding screen doesn't change language
        // Also force reload orders for the new user
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            context.read<LocaleProvider>().setLocale(Locale(_locale));
            // Force reload orders for the new user
            final orderProvider = Provider.of<OrderProvider>(context, listen: false);
            orderProvider.loadOrders(forceReload: true);
            final l10n = AppLocalizations.of(context)!;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.onboardingSuccess)),
            );
          }
        });
      }
    } catch (e) {
      _lastError = e.toString();
      debugPrint('[onboarding_2] error: $_lastError');
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
        if (mounted) setState(() => _submitting = false);
        return;
      }

      // Offline fallback: mark onboarding locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(PrefKeys.onboardingCompleted, true);
      await prefs.setString(PrefKeys.localeCode, _locale);
      if (_userData!.phone != null && _userData!.phone!.isNotEmpty) {
        await prefs.setString(PrefKeys.phone, _userData!.phone!);
      }
      if (_userData!.email != null && _userData!.email!.isNotEmpty) {
        await prefs.setString(PrefKeys.email, _userData!.email!);
      }
      if (_userData!.googleId != null && _userData!.googleId!.isNotEmpty) {
        await prefs.setString(PrefKeys.googleId, _userData!.googleId!);
      }
      await prefs.setBool(PrefKeys.allowLocation, _allowLocation);
      await prefs.setBool(PrefKeys.allowNotifications, _allowNotifications);

      debugPrint('[onboarding_2] offline path saved, navigating home');
      if (mounted) {
        // CRITICAL: Clear orders and cart cache before navigating
        // This ensures new user doesn't see previous user's cached data
        try {
          final orderProvider = Provider.of<OrderProvider>(context, listen: false);
          await orderProvider.clearOrders();
          debugPrint('[onboarding_2] Orders cleared before navigation (offline)');
          
          final cartProvider = Provider.of<CartProvider>(context, listen: false);
          await cartProvider.clearCartCache();
          debugPrint('[onboarding_2] Cart cleared before navigation (offline)');
        } catch (e) {
          debugPrint('[onboarding_2] Error clearing providers (offline): $e');
        }
        
        context.go('/');
        // Apply locale after navigation so onboarding screen doesn't change language
        // Also force reload orders for the new user
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            context.read<LocaleProvider>().setLocale(Locale(_locale));
            // Force reload orders for the new user
            final orderProvider = Provider.of<OrderProvider>(context, listen: false);
            orderProvider.loadOrders(forceReload: true);
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Logo
                Center(
                  child: Image.asset(
                    'assets/images/mobpizza_logo.png',
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Icon(
                      Icons.tune,
                      color: Color(0xFFD9A441),
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Personalize Your Experience',
                        style: const TextStyle(
                          color: Color(0xFFF5E8C7),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 8),
              Text(
                'You\'re always in control',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              // Language Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1512),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF3A3A3A)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.language,
                      style: const TextStyle(
                        color: Color(0xFF919F89),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _locale,
                      dropdownColor: const Color(0xFF1C1512),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF5E8C7),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFFD9A441)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFFD9A441), width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'en',
                          child: Text(l10n.english, style: const TextStyle(color: Colors.black)),
                        ),
                        DropdownMenuItem(
                          value: 'es',
                          child: Text(l10n.spanish, style: const TextStyle(color: Colors.black)),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _locale = value ?? 'en';
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Location Access Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1512),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF3A3A3A)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFFD9A441),
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          l10n.allowLocation,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Helps it to Confirm delivery area\n• Show nearby services',
                      style: const TextStyle(
                        color: Color(0xFF919F89),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _requestPermissions,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD9A441),
                          foregroundColor: const Color(0xFF0B0C10),
                        ),
                        child: const Text('Allow Location'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Notifications Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1512),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF3A3A3A)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.notifications_outlined,
                          color: Color(0xFFD9A441),
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          l10n.allowNotifications,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Order updates\n• Exclusive offers',
                      style: const TextStyle(
                        color: Color(0xFF919F89),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _requestPermissions,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD9A441),
                          foregroundColor: const Color(0xFF0B0C10),
                        ),
                        child: const Text('Enable Notifications'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
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
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitting ? null : _submitOnboarding,
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
                      : const Text('Request Permissions'),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: _submitting ? null : _submitOnboarding,
                  child: Text(
                    'Skip for now',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                  ),
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


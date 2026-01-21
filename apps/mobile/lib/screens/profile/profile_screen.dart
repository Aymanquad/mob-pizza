import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_pizza_mobile/config/constants.dart';
import 'package:mob_pizza_mobile/services/user_service.dart';
import 'package:mob_pizza_mobile/services/auth_service.dart';
import 'package:mob_pizza_mobile/providers/locale_provider.dart';
import 'package:mob_pizza_mobile/providers/order_provider.dart';
import 'package:mob_pizza_mobile/providers/cart_provider.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  
  final _userService = UserService();
  bool _isLoading = false;
  bool _isEditing = false;
  String _phone = '';
  String _email = '';
  String _locale = 'en';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);
    
    try {
      final prefs = await SharedPreferences.getInstance();
      _phone = prefs.getString(PrefKeys.phone) ?? '';
      _email = prefs.getString(PrefKeys.email) ?? '';
      
      // Sync with LocaleProvider's current locale first
      final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
      _locale = localeProvider.locale.languageCode;

      // Try to fetch from backend FIRST (source of truth)
      final identifier = await AuthService.getUserIdentifier();
      if (identifier.isNotEmpty) {
        try {
          final userData = await _userService.getProfile(identifier);
          debugPrint('[profile] Loaded from backend: firstName=${userData['firstName']}, lastName=${userData['lastName']}, locale=${userData['locale']}');
          
          // Load from backend data (source of truth)
          _firstNameController.text = userData['firstName'] ?? '';
          _lastNameController.text = userData['lastName'] ?? '';
          
          // Update email from backend if available
          if (userData['email'] != null) {
            _email = userData['email'] as String;
            await prefs.setString(PrefKeys.email, _email);
          }
          
          // Update phone from backend if available
          if (userData['phone'] != null) {
            _phone = userData['phone'] as String;
            await prefs.setString(PrefKeys.phone, _phone);
          }
          
          // Get first address if exists
          final addresses = userData['addresses'] as List?;
          if (addresses != null && addresses.isNotEmpty) {
            final addr = addresses[0];
            _addressController.text = addr['street'] ?? '';
            // Sync address to local prefs
            await prefs.setString(PrefKeys.address, _addressController.text);
          } else {
            _addressController.text = '';
          }
          
          // Update locale from backend if available
          final backendLocale = userData['locale'] ?? _locale;
          _locale = backendLocale;
          
          // CRITICAL: Sync all backend data to local prefs so it persists after logout/login
          await prefs.setString(PrefKeys.firstName, _firstNameController.text);
          await prefs.setString(PrefKeys.lastName, _lastNameController.text);
          await prefs.setString(PrefKeys.localeCode, _locale);
          
          // Update LocaleProvider to match backend locale
          Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale(_locale));
        } catch (e) {
          debugPrint('[profile] Could not fetch from backend: $e, falling back to local prefs');
          // Fallback to local prefs only if backend fetch fails
          _firstNameController.text = prefs.getString(PrefKeys.firstName) ?? '';
          _lastNameController.text = prefs.getString(PrefKeys.lastName) ?? '';
          _addressController.text = prefs.getString(PrefKeys.address) ?? '';
        }
      } else {
        // No identifier - load from local prefs only
        _firstNameController.text = prefs.getString(PrefKeys.firstName) ?? '';
        _lastNameController.text = prefs.getString(PrefKeys.lastName) ?? '';
        _addressController.text = prefs.getString(PrefKeys.address) ?? '';
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Update backend FIRST (source of truth)
      // Only save to local prefs if backend update succeeds
      final identifier = await AuthService.getUserIdentifier();
      if (identifier.isEmpty) {
        throw Exception('No user identifier found. Please complete onboarding.');
      }
      
      final addressText = _addressController.text.trim();
      
      final updates = <String, dynamic>{
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'locale': _locale,
      };

      // Save address to MongoDB if provided
      if (addressText.isNotEmpty) {
        // Create or update the default address
        // Note: coordinates are optional, so we don't include them if not available
        updates['addresses'] = [
          {
            'label': 'home',
            'street': addressText,
            'city': '', // Optional, can be filled later
            'state': '', // Optional, can be filled later
            'zipCode': '', // Optional, can be filled later
            'isDefault': true,
            // Don't include coordinates if not available - backend will handle it
          }
        ];
      }

      // Update backend and get response
      final updatedUserData = await _userService.updateProfile(identifier, updates);
      debugPrint('[profile] Backend update response: $updatedUserData');
      
      // CRITICAL: Only sync to local prefs AFTER backend update succeeds
      // This ensures data consistency - if backend fails, local prefs aren't updated
      await prefs.setString(PrefKeys.firstName, updatedUserData['firstName'] ?? _firstNameController.text.trim());
      await prefs.setString(PrefKeys.lastName, updatedUserData['lastName'] ?? _lastNameController.text.trim());
      await prefs.setString(PrefKeys.localeCode, updatedUserData['locale'] ?? _locale);
      
      // Update address from backend response if available
      final addresses = updatedUserData['addresses'] as List?;
      if (addresses != null && addresses.isNotEmpty) {
        final addr = addresses[0];
        final street = addr['street'] ?? '';
        _addressController.text = street;
        await prefs.setString(PrefKeys.address, street);
      } else {
        await prefs.setString(PrefKeys.address, _addressController.text.trim());
      }
      
      // Update locale from backend response
      _locale = updatedUserData['locale'] ?? _locale;
      
      // Reload profile to ensure UI is in sync
      await _loadProfile();

      // Update LocaleProvider AFTER saving to persist the change
      if (mounted) {
        Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale(_locale));
        setState(() => _isEditing = false);
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.profileUpdated),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.profileUpdateFailed}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleLanguage() async {
    final newLocale = _locale == 'en' ? 'es' : 'en';
    setState(() => _locale = newLocale);
    // Don't update LocaleProvider here - only update when saving
  }

  Future<void> _logout(BuildContext context) async {
    // CRITICAL: Clear providers first to remove cached data
    try {
      // Clear OrderProvider cache
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      await orderProvider.clearOrders();
      debugPrint('[profile] Orders cleared from OrderProvider');
      
      // Clear CartProvider cache
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      await cartProvider.clearCartCache();
      debugPrint('[profile] Cart cleared from CartProvider');
    } catch (e) {
      debugPrint('[profile] Error clearing providers: $e');
    }

    // Clear SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(PrefKeys.onboardingCompleted);
    await prefs.remove(PrefKeys.localeCode);
    await prefs.remove(PrefKeys.phone);
    await prefs.remove(PrefKeys.email);
    await prefs.remove(PrefKeys.googleId);
    await prefs.remove(PrefKeys.allowLocation);
    await prefs.remove(PrefKeys.allowNotifications);
    await prefs.remove(PrefKeys.firstName);
    await prefs.remove(PrefKeys.lastName);
    await prefs.remove(PrefKeys.address);
    
    // CRITICAL: Clear orders and cart from SharedPreferences cache
    await prefs.remove(PrefKeys.orders);
    await prefs.remove(PrefKeys.cartItems);
    debugPrint('[profile] Orders and cart cleared from SharedPreferences');
    
    // Also sign out from Google
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
    } catch (e) {
      debugPrint('[profile] Error signing out from Google: $e');
    }

    if (context.mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.loggedOut)),
      );
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to LocaleProvider changes so the screen rebuilds when locale changes
    // This ensures the screen updates when locale changes (after save)
    Provider.of<LocaleProvider>(context);
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Container(
        color: const Color(0xFF1C1512),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Color(0xFFC6A667)))
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.profile,
                            style: GoogleFonts.cinzel(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFF5E8C7),
                            ),
                          ),
                          if (!_isEditing)
                            IconButton(
                              icon: const Icon(Icons.edit, color: Color(0xFFC6A667)),
                              onPressed: () => setState(() => _isEditing = true),
                            )
                          else
                            TextButton(
                              onPressed: () {
                                setState(() => _isEditing = false);
                                _loadProfile(); // Reload original values
                              },
                              child: Text(l10n.cancel, style: const TextStyle(color: Color(0xFFC6A667))),
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Name Fields
                      _buildSectionTitle(l10n.name),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _firstNameController,
                        enabled: _isEditing,
                        style: const TextStyle(color: Color(0xFFF5E8C7)),
                        decoration: _inputDecoration(l10n.firstName),
                        validator: (v) => (v?.trim().isEmpty ?? true) ? l10n.required : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _lastNameController,
                        enabled: _isEditing,
                        style: const TextStyle(color: Color(0xFFF5E8C7)),
                        decoration: _inputDecoration(l10n.lastName),
                        validator: (v) => (v?.trim().isEmpty ?? true) ? l10n.required : null,
                      ),
                      const SizedBox(height: 24),

                      // Address
                      _buildSectionTitle(l10n.address),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _addressController,
                        enabled: _isEditing,
                        style: const TextStyle(color: Color(0xFFF5E8C7)),
                        decoration: _inputDecoration(l10n.streetAddress),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 24),

                      // Language Toggle
                      _buildSectionTitle(l10n.language),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F0F0F),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF878787), width: 1.5),
                        ),
                        child: ListTile(
                          title: Text(
                            _locale == 'en' ? l10n.english : l10n.spanish,
                            style: const TextStyle(color: Color(0xFFF5E8C7)),
                          ),
                          trailing: Switch(
                            value: _locale == 'es',
                            activeColor: const Color(0xFFC6A667),
                            onChanged: _isEditing ? (_) => _toggleLanguage() : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Contact Info (Read-only)
                      _buildSectionTitle(l10n.contact),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F0F0F),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF878787), width: 1.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_email.isNotEmpty) ...[
                              Row(
                                children: [
                                  const Icon(Icons.email, color: Color(0xFF878787), size: 16),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _email,
                                      style: const TextStyle(color: Color(0xFFF5E8C7)),
                                    ),
                                  ),
                                ],
                              ),
                              if (_phone.isNotEmpty) const SizedBox(height: 12),
                            ],
                            if (_phone.isNotEmpty)
                              Row(
                                children: [
                                  const Icon(Icons.phone, color: Color(0xFF878787), size: 16),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _phone,
                                      style: const TextStyle(color: Color(0xFF878787)),
                                    ),
                                  ),
                                ],
                              ),
                            if (_phone.isEmpty && _email.isEmpty)
                              Text(
                                'No contact information',
                                style: const TextStyle(color: Color(0xFF878787)),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Save Button (visible when editing)
                      if (_isEditing) ...[
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD9A441),
                              foregroundColor: const Color(0xFF1C1512),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: _saveProfile,
                            child: Text(l10n.saveChanges),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Logout Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFFC6A667),
                            side: const BorderSide(color: Color(0xFFC6A667)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            textStyle: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          onPressed: () => _logout(context),
                          child: Text(l10n.logout),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.libreBaskerville(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: const Color(0xFFF5E8C7),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF878787)),
      filled: true,
      fillColor: const Color(0xFF0F0F0F),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF878787), width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF878787), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFC6A667), width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF878787), width: 1),
      ),
    );
  }
}

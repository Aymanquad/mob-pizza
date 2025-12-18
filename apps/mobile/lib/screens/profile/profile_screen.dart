import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_pizza_mobile/config/constants.dart';
import 'package:mob_pizza_mobile/services/user_service.dart';
import 'package:mob_pizza_mobile/providers/locale_provider.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

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
      
      // Sync with LocaleProvider's current locale first
      final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
      _locale = localeProvider.locale.languageCode;

      // Load from local prefs
      _firstNameController.text = prefs.getString(PrefKeys.firstName) ?? '';
      _lastNameController.text = prefs.getString(PrefKeys.lastName) ?? '';
      _addressController.text = prefs.getString(PrefKeys.address) ?? '';

      // Try to fetch from backend if phone exists
      if (_phone.isNotEmpty) {
        try {
          final userData = await _userService.getProfile(_phone);
          _firstNameController.text = userData['firstName'] ?? '';
          _lastNameController.text = userData['lastName'] ?? '';
          
          // Get first address if exists
          final addresses = userData['addresses'] as List?;
          if (addresses != null && addresses.isNotEmpty) {
            final addr = addresses[0];
            _addressController.text = addr['street'] ?? '';
          }
          // Update locale from backend if available
          final backendLocale = userData['locale'] ?? _locale;
          _locale = backendLocale;
        } catch (e) {
          debugPrint('[profile] Could not fetch from backend: $e');
        }
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
      
      // Save to local prefs
      await prefs.setString(PrefKeys.firstName, _firstNameController.text.trim());
      await prefs.setString(PrefKeys.lastName, _lastNameController.text.trim());
      await prefs.setString(PrefKeys.address, _addressController.text.trim());
      await prefs.setString(PrefKeys.localeCode, _locale);

      // Update backend
      if (_phone.isNotEmpty) {
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

        await _userService.updateProfile(_phone, updates);
      }

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
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(PrefKeys.onboardingCompleted);
    await prefs.remove(PrefKeys.localeCode);
    await prefs.remove(PrefKeys.phone);
    await prefs.remove(PrefKeys.allowLocation);
    await prefs.remove(PrefKeys.allowNotifications);
    await prefs.remove(PrefKeys.firstName);
    await prefs.remove(PrefKeys.lastName);
    await prefs.remove(PrefKeys.address);

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
                            Text(
                              '${l10n.phone}: $_phone',
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

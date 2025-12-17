import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_pizza_mobile/config/constants.dart';
import 'package:mob_pizza_mobile/services/user_service.dart';
import 'package:mob_pizza_mobile/providers/locale_provider.dart';
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
      _locale = prefs.getString(PrefKeys.localeCode) ?? 'en';

      // Load from local prefs first
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
          _locale = userData['locale'] ?? 'en';
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
        final updates = <String, dynamic>{
          'firstName': _firstNameController.text.trim(),
          'lastName': _lastNameController.text.trim(),
          'locale': _locale,
        };

        // Note: Address is only saved locally for now
        // Full address (city, state, zip) will be added during checkout

        await _userService.updateProfile(_phone, updates);
      }

      if (mounted) {
        setState(() => _isEditing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile: $e'),
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
    
    // Update provider
    if (mounted) {
      Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale(newLocale));
    }
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged out')),
      );
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            'Profile',
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
                              child: const Text('Cancel', style: TextStyle(color: Color(0xFFC6A667))),
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Name Fields
                      _buildSectionTitle('Name'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _firstNameController,
                        enabled: _isEditing,
                        style: const TextStyle(color: Color(0xFFF5E8C7)),
                        decoration: _inputDecoration('First Name'),
                        validator: (v) => (v?.trim().isEmpty ?? true) ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _lastNameController,
                        enabled: _isEditing,
                        style: const TextStyle(color: Color(0xFFF5E8C7)),
                        decoration: _inputDecoration('Last Name'),
                        validator: (v) => (v?.trim().isEmpty ?? true) ? 'Required' : null,
                      ),
                      const SizedBox(height: 24),

                      // Address
                      _buildSectionTitle('Address'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _addressController,
                        enabled: _isEditing,
                        style: const TextStyle(color: Color(0xFFF5E8C7)),
                        decoration: _inputDecoration('Street Address'),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 24),

                      // Language Toggle
                      _buildSectionTitle('Language'),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F0F0F),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF878787), width: 1.5),
                        ),
                        child: ListTile(
                          title: Text(
                            _locale == 'en' ? 'English' : 'Spanish',
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
                      _buildSectionTitle('Contact'),
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
                              'Phone: $_phone',
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
                            child: const Text('Save Changes'),
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
                          child: const Text('Log out'),
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

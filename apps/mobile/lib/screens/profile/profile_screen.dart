import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_pizza_mobile/config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<Map<String, dynamic>> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'phone': prefs.getString(PrefKeys.phone) ?? '',
      'locale': prefs.getString(PrefKeys.localeCode) ?? 'en',
      'allowLocation': prefs.getBool(PrefKeys.allowLocation) ?? false,
      'allowNotifications': prefs.getBool(PrefKeys.allowNotifications) ?? false,
    };
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(PrefKeys.onboardingCompleted);
    await prefs.remove(PrefKeys.localeCode);
    await prefs.remove(PrefKeys.phone);
    await prefs.remove(PrefKeys.allowLocation);
    await prefs.remove(PrefKeys.allowNotifications);

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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<Map<String, dynamic>>(
            future: _loadProfile(),
            builder: (context, snapshot) {
              final data = snapshot.data ?? {};
              final phone = (data['phone'] as String? ?? '').isEmpty ? 'Not set' : data['phone'] as String;
              final locale = data['locale'] as String? ?? 'en';
              final allowLoc = data['allowLocation'] as bool? ?? false;
              final allowNotif = data['allowNotifications'] as bool? ?? false;

              return ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F0F0F),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF878787), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0x4D),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                        BoxShadow(
                          color: const Color(0xFFC6A667).withValues(alpha: 0x19),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        'Guest',
                        style: GoogleFonts.cinzel(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFF5E8C7),
                        ),
                      ),
                      subtitle: Text(
                        'Phone: $phone • Locale: $locale',
                        style: const TextStyle(color: Color(0xFF878787)),
                      ),
                      trailing: const Icon(
                        Icons.edit,
                        color: Color(0xFFC6A667),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F0F0F),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF878787), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0x4D),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                        BoxShadow(
                          color: const Color(0xFFC6A667).withValues(alpha: 0x19),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Permissions',
                            style: GoogleFonts.libreBaskerville(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFF5E8C7),
                            ),
                          ),
                          subtitle: Text(
                            'Location: ${allowLoc ? 'Allowed' : 'Not allowed'} • Notifications: ${allowNotif ? 'Allowed' : 'Not allowed'}',
                            style: const TextStyle(color: Color(0xFF878787)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F0F0F),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF878787), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0x4D),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                        BoxShadow(
                          color: const Color(0xFFC6A667).withValues(alpha: 0x19),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        'House Secrets',
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFF5E8C7),
                        ),
                      ),
                      subtitle: const Text(
                        'Boss Picks • Under-the-Table Deals • Family Combos',
                        style: TextStyle(color: Color(0xFF878787)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
              );
            },
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Container(
        color: const Color(0xFF1C1512),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
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
                    'John Doe',
                    style: GoogleFonts.cinzel(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFF5E8C7),
                    ),
                  ),
                  subtitle: const Text(
                    'john@example.com • +91 98765 43210',
                    style: TextStyle(color: Color(0xFF878787)),
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
                        'Safehouses',
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFF5E8C7),
                        ),
                      ),
                      subtitle: const Text(
                        'Home Base, Office Front',
                        style: TextStyle(color: Color(0xFF878787)),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Color(0xFFC6A667),
                      ),
                    ),
                    const Divider(color: Color(0xFF878787)),
                    ListTile(
                      title: Text(
                        'Family Loyalty',
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFF5E8C7),
                        ),
                      ),
                      subtitle: const Text(
                        'Capo • 1,240 Family Points',
                        style: TextStyle(color: Color(0xFFC6A667)),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Color(0xFFC6A667),
                      ),
                    ),
                    const Divider(color: Color(0xFF878787)),
                    ListTile(
                      title: Text(
                        'Notifications',
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFF5E8C7),
                        ),
                      ),
                      subtitle: const Text(
                        'Push • Email',
                        style: TextStyle(color: Color(0xFF878787)),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Color(0xFFC6A667),
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
            ],
          ),
        ),
      ),
    );
  }
}


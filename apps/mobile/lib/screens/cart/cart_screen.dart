import 'package:flutter/material.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Container(
        color: const Color(0xFF1C1512),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
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
                    'Margherita – The Mistress',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFF5E8C7),
                    ),
                  ),
                  subtitle: const Text(
                    'Solo · Extra cheese',
                    style: TextStyle(color: Color(0xFF878787)),
                  ),
                  trailing: Text(
                    '\$12.00',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFC6A667),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFC6A667),
                        side: const BorderSide(color: Color(0xFFC6A667)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () => context.go('/menu'),
                      child: Text(AppLocalizations.of(context)!.menu),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC6A667),
                        foregroundColor: const Color(0xFF0F0F0F),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () => context.go('/checkout'),
                      child: const Text('Proceed to The Deal'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


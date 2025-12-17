import 'package:flutter/material.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final orders = [
      ('ORD-001', 'On the Streets', '18 mins'),
      ('ORD-000', 'Delivered', 'Completed'),
    ];
    return SafeArea(
      child: Container(
        color: const Color(0xFF1C1512),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final o = orders[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
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
                  o.$1,
                  style: GoogleFonts.cinzel(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFF5E8C7),
                  ),
                ),
                subtitle: Text(
                  '${AppLocalizations.of(context)!.status}: ${o.$2} · ${AppLocalizations.of(context)!.eta}: ${o.$3}',
                  style: const TextStyle(color: Color(0xFF878787)),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Color(0xFFC6A667),
                ),
                onTap: () => context.go('/orders/${o.$1}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
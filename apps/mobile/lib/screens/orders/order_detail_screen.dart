import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Order $orderId'),
        backgroundColor: const Color(0xFF1C1512),
        foregroundColor: const Color(0xFFF5E8C7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF5E8C7)),
          onPressed: () => context.go('/orders'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.kitchenInMotion, style: TextStyle(fontWeight: FontWeight.w700)),
            SizedBox(height: 12),
            Text(l10n.items),
            ListTile(
              title: Text('Margherita – The Mistress'),
              subtitle: Text('Solo · Extra cheese'),
              trailing: Text('\$12.00', style: TextStyle(fontWeight: FontWeight.w800)),
            ),
            Spacer(),
            Text('${l10n.runner}: Tony • ${l10n.eta} 18 mins', style: TextStyle(color: Color(0xFFC0B8A8))),
            SizedBox(height: 6),
            Text('${l10n.familyTip} ${l10n.keepLineOpen}', style: TextStyle(color: Color(0xFFC0B8A8))),
          ],
        ),
      ),
    );
  }
}


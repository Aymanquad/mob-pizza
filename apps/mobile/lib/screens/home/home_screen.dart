import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';
import 'package:mob_pizza_mobile/providers/locale_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey _familyBulletinKey = GlobalKey();

  void _scrollToFamilyBulletin() {
    final context = _familyBulletinKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeProvider = Provider.of<LocaleProvider>(context);
    final isSpanish = localeProvider.locale.languageCode == 'es';

    final cards = [
      (l10n.theHitList, l10n.theHitListDesc, '/menu'),
      (isSpanish ? l10n.languageToggleSpanish : l10n.languageToggle, l10n.languageToggleDesc, ''),
      (l10n.pastOrders, l10n.pastOrdersDesc, '/orders'),
      (l10n.yourFile, l10n.yourFileDesc, '/profile'),
    ];
    final featured = [
      (l10n.bossPick, l10n.margheritaBoss, '\$12', 'Solo • Extra cheese', 0), // Item ID 0
      (l10n.houseSecret, l10n.smokyCapo, '\$15', 'Brick oven • Sweet heat', 1), // Item ID 1
      (l10n.familyCombo, l10n.crewFeast, '\$29', '2 pies • Sides • Liquid alibi', 2), // Item ID 2
    ];

    final stats = [
      (l10n.ordersClosed, '124'),
      (l10n.familyPoints, '1,240'),
      (l10n.safehouses, '3'),
    ];

    return SafeArea(
      child: Container(
        color: const Color(0xFF0F0F0F),
        child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                colors: [Color(0xFF7A1F1F), Color(0xFF0F0F0F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: const Color(0xFFC6A667)),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.25,
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(Color(0x990F0F0F), BlendMode.darken),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1521017432531-fbd92d768814?auto=format&fit=crop&w=1200&q=80&sat=-100',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(color: const Color(0x550F0F0F)),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/icons/filigree_top.svg', width: 140, colorFilter: const ColorFilter.mode(Color(0xFFC6A667), BlendMode.srcIn)),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0x73),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Text(l10n.homeScreenTitle, style: const TextStyle(fontSize: 12, letterSpacing: 1, fontWeight: FontWeight.w700, color: Color(0xFFF5E8C7))),
                    ),
                    const SizedBox(height: 10),
                    Text(l10n.homeScreenSubtitle, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFFC6A667))),
                    const SizedBox(height: 4),
                    Text(l10n.homeScreenDescription, style: const TextStyle(color: Color(0xFFF5E8C7))),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC6A667),
                            foregroundColor: const Color(0xFF0F0F0F),
                          ),
                          onPressed: () => context.go('/menu'),
                          child: Text(l10n.orderNow),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFFC6A667),
                            side: const BorderSide(color: Color(0xFFC6A667)),
                          ),
                          onPressed: () => context.go('/orders'),
                          child: Text(l10n.trackOrders),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SvgPicture.asset('assets/icons/filigree_bottom.svg', width: 140, colorFilter: const ColorFilter.mode(Color(0xFFC6A667), BlendMode.srcIn)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        ActionChip(
                          label: Text(l10n.bossPicks),
                          onPressed: _scrollToFamilyBulletin,
                        ),
                        ActionChip(
                          label: Text(l10n.underTheTableDeals),
                          onPressed: _scrollToFamilyBulletin,
                        ),
                        ActionChip(
                          label: Text(l10n.familyCombos),
                          onPressed: _scrollToFamilyBulletin,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF7A1F1F),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFC6A667)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: stats
                  .map(
                    (s) => Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            s.$1.toUpperCase(),
                            style: const TextStyle(color: Color(0xFF878787), fontWeight: FontWeight.w700, letterSpacing: 0.5, fontSize: 12),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            s.$2,
                            style: const TextStyle(color: Color(0xFFC6A667), fontWeight: FontWeight.w900, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          Text(l10n.familyShortcuts, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFFC6A667))),
          const SizedBox(height: 10),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: cards
                .map(
                  (c) => c.$3 == '' // Language toggle button
                    ? GestureDetector(
                        onTap: () => localeProvider.toggleLocale(),
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 64) / 2,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F0F0F),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFC6A667)),
                            boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, 6))],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFC6A667).withValues(alpha: 0x19),
                                ),
                                child: const Icon(
                                  Icons.language,
                                  color: Color(0xFFC6A667),
                                  size: 32,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(c.$1, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFFF5E8C7))),
                              const SizedBox(height: 4),
                              Text(c.$2, style: const TextStyle(color: Color(0xFFC6A667))),
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () => context.go(c.$3),
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 64) / 2,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F0F0F),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFF878787)),
                            boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, 6))],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                    image: NetworkImage('https://images.unsplash.com/photo-1521017432531-fbd92d768814?auto=format&fit=crop&w=800&q=80&sat=-100'),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(Color(0x880F0F0F), BlendMode.darken),
                                  ),
                                ),
                                foregroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black.withValues(alpha: 0x05),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(c.$1, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFFF5E8C7))),
                              const SizedBox(height: 4),
                              Text(c.$2, style: const TextStyle(color: Color(0xFFC6A667))),
                            ],
                          ),
                        ),
                      ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Container(
            key: _familyBulletinKey,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF0F0F0F),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF878787)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.familyBulletin, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFFC6A667))),
                const SizedBox(height: 8),
                ...featured.map(
                  (f) => GestureDetector(
                    onTap: () => context.go('/menu/${f.$5}'),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1512),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF878787).withValues(alpha: 0x4D)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(f.$1, style: const TextStyle(color: Color(0xFFC6A667), fontWeight: FontWeight.w700, fontSize: 12)),
                                const SizedBox(height: 4),
                                Text(f.$2, style: const TextStyle(color: Color(0xFFF5E8C7), fontWeight: FontWeight.w800, fontSize: 16)),
                                const SizedBox(height: 4),
                                Text(f.$4, style: const TextStyle(color: Color(0xFF878787), fontSize: 12)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            children: [
                              Text(f.$3, style: const TextStyle(color: Color(0xFFC6A667), fontWeight: FontWeight.w800, fontSize: 18)),
                              const SizedBox(height: 4),
                              const Icon(Icons.arrow_forward_ios, color: Color(0xFF878787), size: 16),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF7A1F1F),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFC6A667)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.houseSecrets, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFFF5E8C7))),
                const SizedBox(height: 8),
                Text(l10n.houseSecretsDesc, style: const TextStyle(color: Color(0xFFF5E8C7))),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}


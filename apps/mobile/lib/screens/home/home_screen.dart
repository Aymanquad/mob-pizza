import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';
import 'package:mob_pizza_mobile/providers/order_provider.dart';
import 'package:mob_pizza_mobile/services/user_service.dart';
import 'package:mob_pizza_mobile/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey _familyBulletinKey = GlobalKey();
  final UserService _userService = UserService();
  int _addressCount = 0;
  bool _isLoadingStats = true;

  @override
  void initState() {
    super.initState();
    _loadUserStats();
  }

  Future<void> _loadUserStats() async {
    try {
      final identifier = await AuthService.getUserIdentifier();
      if (identifier.isNotEmpty) {
        final userData = await _userService.getProfile(identifier);
        final addresses = userData['addresses'] as List?;
        setState(() {
          _addressCount = addresses?.length ?? 0;
          _isLoadingStats = false;
        });
      } else {
        setState(() {
          _isLoadingStats = false;
        });
      }
    } catch (e) {
      debugPrint('[home] Error loading user stats: $e');
      setState(() {
        _isLoadingStats = false;
      });
    }
  }

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
    final orderProvider = Provider.of<OrderProvider>(context);
    final orderCount = orderProvider.orderCount;

    final cards = [
      (l10n.theHitList, l10n.theHitListDesc, '/menu', Icons.restaurant_menu),
      (l10n.pastOrders, l10n.pastOrdersDesc, '/orders', Icons.history),
      (l10n.yourFile, l10n.yourFileDesc, '/profile', Icons.person),
      (l10n.customizePizza, l10n.customizePizzaDesc, '/customize-pizza', Icons.build_circle),
    ];
    
    // Updated Family Bulletin with 4 current menu items (1 combo + 3 pizzas)
    // Indices based on item_detail_screen.dart _getItems() method:
    // - Pepperoni Classic: index 0
    // - Supreme: index 1  
    // - Hawaiian Bacon: index 4
    // - 2 Slices + Drink combo: index 9
    final featured = [
      (l10n.bossPick, l10n.pizzaPepperoniClassic, '\$13.00', l10n.pizzaPepperoniClassicDesc, 0),
      (l10n.underTheTableDeals, l10n.pizzaSupreme, '\$14.50', l10n.pizzaSupremeDesc, 1),
      (l10n.bossPick, l10n.pizzaHawaiianBacon, '\$14.50', l10n.pizzaHawaiianBaconDesc, 4),
      (l10n.familyCombo, l10n.combo2SlicesDrink, '\$15.99', l10n.combo2SlicesDrinkDesc, 9),
    ];

    final stats = [
      (l10n.ordersClosed, orderCount.toString()),
      (l10n.safehouses, _isLoadingStats ? '...' : _addressCount.toString()),
    ];

    return SafeArea(
      child: Container(
        color: const Color(0xFF0F0F0F),
        child: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
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
          const SizedBox(height: 12),
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
          const SizedBox(height: 12),
          Text(l10n.familyShortcuts, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFFC6A667))),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: cards
                .map(
                  (c) => GestureDetector(
                    onTap: () => context.go(c.$3),
                    child: SizedBox(
                      width: (MediaQuery.of(context).size.width - 48) / 2,
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Container(
                          padding: const EdgeInsets.all(12),
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
                                  color: const Color(0xFF1C1512),
                                ),
                                child: ColorFiltered(
                                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                  child: Icon(
                                    c.$4,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(c.$1, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFFF5E8C7))),
                                    const SizedBox(height: 4),
                                    Text(c.$2, style: const TextStyle(color: Color(0xFFC6A667), fontSize: 12)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
          Container(
            key: _familyBulletinKey,
            padding: const EdgeInsets.all(12),
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
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(10),
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
                                Text(f.$1, style: const TextStyle(color: Color(0xFFD9A441), fontWeight: FontWeight.w800, fontSize: 11, letterSpacing: 0.5)),
                                const SizedBox(height: 5),
                                Text(f.$2, style: const TextStyle(color: Color(0xFFF5E8C7), fontWeight: FontWeight.w900, fontSize: 16)),
                                const SizedBox(height: 4),
                                Text(f.$4, style: const TextStyle(color: Color(0xFF878787), fontSize: 11)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            children: [
                              Text(f.$3, style: const TextStyle(color: Color(0xFFD9A441), fontWeight: FontWeight.w900, fontSize: 18)),
                              const SizedBox(height: 4),
                              const Icon(Icons.arrow_forward_ios, color: Color(0xFF878787), size: 14),
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
          const SizedBox(height: 12),
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


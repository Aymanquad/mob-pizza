import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mob_pizza_mobile/screens/home/home_screen.dart';
import 'package:mob_pizza_mobile/screens/menu/menu_list_screen.dart';
import 'package:mob_pizza_mobile/screens/menu/item_detail_screen.dart';
import 'package:mob_pizza_mobile/screens/cart/cart_screen.dart';
import 'package:mob_pizza_mobile/screens/orders/orders_screen.dart';
import 'package:mob_pizza_mobile/screens/orders/order_detail_screen.dart';
import 'package:mob_pizza_mobile/screens/profile/profile_screen.dart';
import 'package:mob_pizza_mobile/widgets/bottom_nav_bar.dart';
import 'package:mob_pizza_mobile/screens/onboarding/onboarding_screen.dart';

class AppRouter {
  static GoRouter create({required bool isOnboarded}) {
    return GoRouter(
      initialLocation: isOnboarded ? '/' : '/onboarding',
      // No redirect - let navigation work freely after onboarding completes
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithBottomNavBar(navigationShell: navigationShell);
          },
          branches: [
            // Index 0: Home
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) => const HomeScreen(),
                ),
              ],
            ),
            // Index 1: Menu
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/menu',
                  builder: (context, state) => const MenuListScreen(),
                  routes: [
                    GoRoute(
                      path: ':id',
                      builder: (context, state) {
                        final id = state.pathParameters['id'] ?? '0';
                        return ItemDetailScreen(itemIndex: int.tryParse(id) ?? 0);
                      },
                    ),
                  ],
                ),
              ],
            ),
            // Index 2: Cart
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/cart',
                  builder: (context, state) => const CartScreen(),
                ),
              ],
            ),
            // Index 3: Orders
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/orders',
                  builder: (context, state) => const OrdersScreen(),
                  routes: [
                    GoRoute(
                      path: ':id',
                      builder: (context, state) {
                        final id = state.pathParameters['id'] ?? '';
                        return OrderDetailScreen(orderId: id);
                      },
                    ),
                  ],
                ),
              ],
            ),
            // Index 4: Profile
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/profile',
                  builder: (context, state) => const ProfileScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(child: Text('Route not found: ${state.error}')),
      ),
    );
  }
}

class ScaffoldWithBottomNavBar extends StatelessWidget {
  const ScaffoldWithBottomNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey('ScaffoldWithBottomNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1512),
        elevation: 0,
        leading: navigationShell.currentIndex != 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFFF5E8C7)),
                onPressed: () {
                  // Check if there's a page to pop within the current navigation stack
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    // If no page to pop, go back to home tab
                    navigationShell.goBranch(0);
                  }
                },
                tooltip: 'Back',
              )
            : null,
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/logo_emblem.svg',
              height: 28,
              width: 28,
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              'assets/icons/logo_wordmark.svg',
              height: 24,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined, color: Color(0xFFF5E8C7)),
            onPressed: () => context.go('/'),
            tooltip: 'Go Home',
          ),
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: BottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
      ),
    );
  }
}


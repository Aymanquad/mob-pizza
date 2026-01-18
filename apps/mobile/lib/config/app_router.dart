import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mob_pizza_mobile/screens/home/home_screen.dart';
import 'package:mob_pizza_mobile/screens/menu/menu_list_screen.dart';
import 'package:mob_pizza_mobile/screens/menu/item_detail_screen.dart';
import 'package:mob_pizza_mobile/models/cart_item.dart';
import 'package:mob_pizza_mobile/screens/cart/cart_screen.dart';
import 'package:mob_pizza_mobile/screens/checkout/checkout_screen.dart';
import 'package:mob_pizza_mobile/screens/orders/orders_screen.dart';
import 'package:mob_pizza_mobile/screens/orders/order_detail_screen.dart';
import 'package:mob_pizza_mobile/screens/manage_orders/manage_orders_screen.dart';
import 'package:mob_pizza_mobile/screens/profile/profile_screen.dart';
import 'package:mob_pizza_mobile/screens/customize/customize_pizza_screen.dart';
import 'package:mob_pizza_mobile/services/auth_service.dart';
import 'package:mob_pizza_mobile/widgets/bottom_nav_bar.dart';
import 'package:mob_pizza_mobile/screens/onboarding/onboarding_screen_1.dart';
import 'package:mob_pizza_mobile/screens/onboarding/onboarding_screen_2.dart';

class AppRouter {
  static GoRouter create({required bool isOnboarded}) {
    return GoRouter(
      initialLocation: isOnboarded ? '/' : '/onboarding',
      // No redirect - let navigation work freely after onboarding completes
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen1(),
          routes: [
            GoRoute(
              path: 'personalize',
              builder: (context, state) => const OnboardingScreen2(),
            ),
          ],
        ),
        GoRoute(
          path: '/checkout',
          builder: (context, state) => const CheckoutScreen(),
        ),
        GoRoute(
          path: '/customize-pizza',
          builder: (context, state) {
            final cartItem = state.extra as CartItem?;
            return CustomizePizzaScreen(cartItemForEdit: cartItem);
          },
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
                    GoRoute(
                      path: 'edit/:cartItemId',
                      builder: (context, state) {
                        final cartItem = state.extra as CartItem?;
                        if (cartItem != null) {
                          return ItemDetailScreen(
                            itemIndex: 0, // Will be determined from cart item name
                            cartItemForEdit: cartItem,
                          );
                        }
                        // Fallback if no cart item provided
                        return ItemDetailScreen(itemIndex: 0);
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
            // Index 5: Manage Orders (Host only)
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/manage-orders',
                  builder: (context, state) => const ManageOrdersScreen(),
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

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey('ScaffoldWithBottomNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithBottomNavBar> createState() => _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  bool _isHost = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkHostStatus();
  }

  Future<void> _checkHostStatus() async {
    final isHost = await AuthService.isHost();
    setState(() {
      _isHost = isHost;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1512),
        elevation: 0,
        leading: widget.navigationShell.currentIndex != 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFFF5E8C7)),
                onPressed: () {
                  // Check if there's a page to pop within the current navigation stack
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    // If no page to pop, go back to home tab
                    widget.navigationShell.goBranch(0);
                  }
                },
                tooltip: 'Back',
              )
            : null,
        title: Image.asset(
          'assets/images/mobpizza_logo.png',
          height: 40,
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined, color: Color(0xFFF5E8C7)),
            onPressed: () => context.go('/'),
            tooltip: 'Go Home',
          ),
        ],
      ),
      body: widget.navigationShell,
      bottomNavigationBar: _isLoading
          ? const SizedBox(height: 56)
          : BottomNavBar(
              currentIndex: widget.navigationShell.currentIndex,
              isHost: _isHost,
              onTap: (index) {
                // Navigation mapping:
                // Regular user (5 tabs): 0=Home, 1=Menu, 2=Cart, 3=Orders, 4=Profile
                // Host user (6 tabs): 0=Home, 1=Menu, 2=Cart, 3=Orders, 4=Profile, 5=Manage Orders
                // The BottomNavBar handles the tab count automatically based on isHost
                widget.navigationShell.goBranch(index);
              },
            ),
    );
  }
}


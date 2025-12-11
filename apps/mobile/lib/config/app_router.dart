import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mob_pizza_mobile/screens/auth/sign_in_screen.dart';
import 'package:mob_pizza_mobile/screens/auth/sign_up_screen.dart';
import 'package:mob_pizza_mobile/screens/auth/splash_screen.dart';
import 'package:mob_pizza_mobile/screens/home/home_screen.dart';
import 'package:mob_pizza_mobile/screens/menu/menu_list_screen.dart';
import 'package:mob_pizza_mobile/screens/menu/item_detail_screen.dart';
import 'package:mob_pizza_mobile/screens/cart/cart_screen.dart';
import 'package:mob_pizza_mobile/screens/checkout/checkout_screen.dart';
import 'package:mob_pizza_mobile/screens/orders/orders_screen.dart';
import 'package:mob_pizza_mobile/screens/orders/order_detail_screen.dart';
import 'package:mob_pizza_mobile/screens/profile/profile_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/menu',
        builder: (context, state) => const MenuListScreen(),
      ),
      GoRoute(
        path: '/menu/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return ItemDetailScreen(itemId: id);
        },
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        path: '/orders/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return OrderDetailScreen(orderId: id);
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Route not found: ${state.error}')),
    ),
  );
}


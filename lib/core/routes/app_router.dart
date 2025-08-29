import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/product/presentation/pages/product_list_page.dart';
import '../../features/wishlist/presentation/pages/wishlist_page.dart';

class AppRouter {
  static const String initial = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String products = '/products';

  static const String cart = '/cart';
  static const String wishlist = '/wishlist';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
          settings: const RouteSettings(name: login),
        );
      case login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
          settings: settings,
        );
      case signup:
        return MaterialPageRoute(
          builder: (context) => const SignupPage(),
          settings: settings,
        );
      case products:
        final args = settings.arguments as Map<String, dynamic>?;
        final category = args?['category'] as String?;
        return MaterialPageRoute(
          builder: (context) => ProductListPage(),
          settings: settings,
        );

      case cart:
        return MaterialPageRoute(
          builder: (context) => const CartPage(),
          settings: settings,
        );
      case wishlist:
        return MaterialPageRoute(
          builder: (context) => const WishlistPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
          settings: const RouteSettings(name: login),
        );
    }
  }
}

import 'package:flutter/material.dart';

import '../entities/laams_route.dart';

/// Contains a set of Helper functions makes accessing [LaamsRouterDelegate]
/// easy and conventient.
///
/// For instance if you want to navigate to page by pressing a button
/// you can call any of these methods:
/// ```dart
/// () => LaamsPush.push(context, '/settings');
///
/// // Or:
/// () => LaamsPush.reset(context, '/home');
///
/// // Or:
/// () => LaamsPush.replace(context, '/products');
///
/// // Or:
/// () => LaamsPush.remove(context, '/settings');
///
/// // Or:
/// () => LaamsPush.pop(context);
/// ```
/// or can
/// `
///
class LaamsPushInteractor with ChangeNotifier {
  final String initialRoute;
  final List<String> publicRoutes;
  final List<String> loginRoutes;
  LaamsPushInteractor({
    required this.initialRoute,
    required this.publicRoutes,
    required this.loginRoutes,
  });

  void redirect(LaamsRoute route) {}

  void pushRoute() {}

  void popRoute() {}

  static void push() {}
  static void pop() {}
  static void remove() {}
  static void replace() {}
}

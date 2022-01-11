import 'package:flutter/material.dart';

import 'entities/laams_route.dart';

class LaamsPush extends ChangeNotifier {
  List<LaamsRoute> _routes = <LaamsRoute>[];
  List<LaamsRoute> get routes => List.unmodifiable(_routes);

  void setRoutes(List<LaamsRoute> newRoutes, bool init) {
    _routes = newRoutes;
    if (!init) return notifyListeners();
  }

  void push(LaamsRoute route) {
    _routes.removeWhere((element) => element == route);
    _routes.add(route);
    notifyListeners();
  }

  void replace(LaamsRoute route) {
    if (_routes.isNotEmpty) {
      _routes.removeLast();
      _routes.add(route);
      notifyListeners();
    }
  }

  void replaceAll(List<LaamsRoute> newRoutes) {
    _routes = newRoutes;
    notifyListeners();
  }

  void replaceAllWith(LaamsRoute route) {
    _routes = List<LaamsRoute>.from([route]);
    notifyListeners();
  }

  void pop() {
    if (_routes.isNotEmpty) {
      _routes.removeLast();
    }
  }

  static void pushRoute(BuildContext context) {}
}

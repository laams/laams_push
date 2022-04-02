import 'package:flutter/material.dart';

import '../entities/laams_route.dart';
import 'route_authenticator.dart';

/// Keeps the state of the navigator stack.
/// However you usually do not have to interact with it directly.
class LaamsPushState extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  final List<LaamsRoute> _routes = <LaamsRoute>[];
  List<LaamsRoute> get routes => List.unmodifiable(_routes);
  final RouteAuthenticator _auth;
  LaamsPushState(
    bool isSignedIn,
    RouteAuthenticator auth,
  )   : _isSignedIn = isSignedIn,
        _auth = auth;

  /// This should be connected to Users Authenticaton status bloc:
  void setIsSignedIn(bool value) {
    _isSignedIn = value;
    if (_routes.isEmpty) _routes.add(const LaamsRoute('/'));
    final authenticated = _auth.authIsSignedIn(value, _routes.last);
    _routes.clear();
    _routes.add(authenticated);
    notifyListeners();
  }

  void onResetRoutes(LaamsRoute newRoute, {bool isInitial = false}) {
    if (_routes.isEmpty) _routes.add(const LaamsRoute('/'));
    final authenticated = _auth.authenticateRoute(
      isSignedIn: _isSignedIn,
      currentRoute: _routes.last,
      newRoute: newRoute,
    );
    _routes.clear();
    _routes.add(authenticated);
    if (!isInitial) return notifyListeners();
  }

  /// Helps add a new route on top of an existing route.
  /// it `should` only be called programmatically.
  void onPushRoute(LaamsRoute newRoute) {
    final authenticated = _auth.authenticateRoute(
      isSignedIn: _isSignedIn,
      currentRoute: _routes.last,
      newRoute: newRoute,
    );
    _routes.removeWhere((element) => element == authenticated);
    _routes.add(authenticated);
    notifyListeners();
  }

  /// Replaces the current route with a new route, instead of pushing on top.
  void onReplaceRoute(LaamsRoute newRoute) {
    final authenticated = _auth.authenticateRoute(
      isSignedIn: _isSignedIn,
      currentRoute: _routes.last,
      newRoute: newRoute,
    );
    if (_routes.isNotEmpty) {
      _routes.removeLast();
      _routes.add(authenticated);
      notifyListeners();
    }
  }

  /// Replaces the current route with a new route, instead of pushing on top.
  void onRemoveRoute(LaamsRoute newRoute) {
    if (_routes.isNotEmpty && _routes.length > 1) {
      _routes.removeWhere((e) => e.path == newRoute.path);
    }
  }

  void onPopRoute() {
    if (_routes.isNotEmpty && _routes.length > 1) {
      _routes.removeLast();
      notifyListeners();
    }
  }
}

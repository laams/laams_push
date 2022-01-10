import 'package:flutter/foundation.dart';

import '../jaguar_nav_setup.dart';
import 'jaguar_route.dart';
import 'nav_auth_data.dart';

class NavigatorStack with ChangeNotifier {
  NavAuthData _data;
  NavigatorStack(NavAuthData data) : _data = data;

  List<JaguarRoute> _routes = <JaguarRoute>[];
  List<JaguarRoute> get routes {
    return _routes;
  }

  void setSignedIn(bool isSignedIn) {
    _data = _data.copyWith(isSignedIn: isSignedIn);
    notifyListeners();
  }

  /// Call this to check for authentication before creating the navigator stack.
  void authenticate(NavAuthData newData) {
    if (_data.isSignedIn != newData.isSignedIn) {
      _data = newData;
      setRoutes([JaguarRoute.initialize(_data.initAuthedPath)], false);
    }
  }

  /// Call this to reset the stack.
  void setRoutes(List<JaguarRoute> newRoutes, bool init) {
    var generatedRoute = JaguarNavSetup.authenticateRoutes(
      routes: newRoutes,
      data: _data,
    );
    _routes = generatedRoute;
    if (!init) notifyListeners();
  }

  /// Call this to push a route to the stack.
  void push(JaguarRoute newRoute) {
    if (_routes.last.path != newRoute.path) {
      var generatedRoute = JaguarNavSetup.authenticateRoute(
        currentRoutes: _routes,
        route: newRoute,
        data: _data,
      );
      _routes = generatedRoute;
      notifyListeners();
    }
  }

  /// Call this to replace the last route with a new one.
  void replace(JaguarRoute newRoute) {
    if (_routes.isNotEmpty) {
      _routes.removeLast();
    }
    if (!_routes.any((e) => e.path == newRoute.path)) {
      var generatedRoute = JaguarNavSetup.authenticateRoute(
        currentRoutes: _routes,
        route: newRoute,
        data: _data,
      );
      _routes = generatedRoute;
      notifyListeners();
    }
  }

  /// Call this to pope a route for the stack.
  void pop() {
    if (_routes.length >= 2) {
      _routes.removeLast();
      notifyListeners();
    }
  }

  /// Call this to remove a specific route from the list of routes.
  void remove(JaguarRoute route) {
    if (_routes.isNotEmpty) {
      _routes.removeWhere((r) => r.path == route.path);
      notifyListeners();
    }
  }
}

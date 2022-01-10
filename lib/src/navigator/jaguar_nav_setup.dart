import 'jaguar_page.dart';
import 'models/jaguar_route.dart';
import 'models/nav_auth_data.dart';

abstract class JaguarNavSetup {
  List<JaguarPage> routesToPages(List<JaguarRoute> routes);

  /// Call this to authenticate a single route.
  static List<JaguarRoute> authenticateRoute({
    required List<JaguarRoute> currentRoutes,
    required JaguarRoute route,
    required NavAuthData data,
  }) {
    var newRoutes = List<JaguarRoute>.from(currentRoutes);
    var isSigninPath = route.path.contains(data.signinPath);
    var isSignupPath = route.path.contains(data.signupPath);
    var isPermitted = data.permissions.contains(route.path);
    var isPublic = data.publicPaths.contains(route.path);
    // Check if the Route ever really exist:
    if (data.allAppPages.contains(route.path)) {
      // Check if user is signed in:
      if (data.isSignedIn == null) {
        newRoutes.add(JaguarRoute.initialize(data.splashPath));
        return List<JaguarRoute>.from(newRoutes);
      } else if (data.isSignedIn!) {
        // Check if has permission to visit:
        if (isSigninPath || isSignupPath) {
          newRoutes.add(JaguarRoute.initialize(data.initAuthedPath));
          return List<JaguarRoute>.from(newRoutes);
        } else if (!isPermitted) {
          newRoutes.add(JaguarRoute.initialize(data.notAllowedPath));
          return List<JaguarRoute>.from(newRoutes);
        } else {
          newRoutes.add(route);
          return List<JaguarRoute>.from(newRoutes);
        }
      } else {
        // If the user is Signed Out:
        if (!isPublic) {
          final initPublicRoute = JaguarRoute.initialize(data.initPublicPath);
          return List<JaguarRoute>.from([initPublicRoute]);
        } else if (!isPermitted) {
          final notAllowedRoute = JaguarRoute.initialize(data.notAllowedPath);
          return List<JaguarRoute>.from([notAllowedRoute]);
        } else {
          newRoutes.add(route);
          return List<JaguarRoute>.from(newRoutes);
        }
      }
    } else {
      newRoutes.add(route);
      return List<JaguarRoute>.from(newRoutes);
    }
  }

  /// Call this to authenticate mulitple routes.
  static List<JaguarRoute> authenticateRoutes({
    required List<JaguarRoute> routes,
    required NavAuthData data,
  }) {
    var newRoutes = List<JaguarRoute>.from(routes);
    var paths = newRoutes.map((e) => e.path).toList();
    // Check if the Route ever really Exist:
    if (paths.every((a) => data.allAppPages.any((b) => b == a))) {
      var isSigninPath = paths.contains(data.signinPath);
      var isSignupPath = paths.contains(data.signupPath);
      var isPermitted = paths.every((a) => data.permissions.any((b) => b == a));
      var isPublic = paths.every((a) => data.publicPaths.any((b) => b == a));
      // Check if user is signed in:
      if (data.isSignedIn == null) {
        final splashRoute = JaguarRoute.initialize(data.splashPath);
        return List<JaguarRoute>.from([splashRoute]);
      } else if (data.isSignedIn!) {
        // Check if has permission to visit:
        if (isSigninPath || isSignupPath) {
          final homeRoute = JaguarRoute.initialize(data.initAuthedPath);
          return List<JaguarRoute>.from([homeRoute]);
        } else if (!isPermitted) {
          final notAllowedRoute = JaguarRoute.initialize(data.notAllowedPath);
          return List<JaguarRoute>.from([notAllowedRoute]);
        } else {
          return List<JaguarRoute>.from(newRoutes);
        }
      } else {
        // If the user is Signed Out:
        if (!isPublic) {
          final initPublicRoute = JaguarRoute.initialize(data.initPublicPath);
          return List<JaguarRoute>.from([initPublicRoute]);
        } else if (!isPermitted) {
          final notAllowedRoute = JaguarRoute.initialize(data.notAllowedPath);
          return List<JaguarRoute>.from([notAllowedRoute]);
        } else {
          return List<JaguarRoute>.from(newRoutes);
        }
      }
    } else {
      return List<JaguarRoute>.from(newRoutes);
    }
  }
}

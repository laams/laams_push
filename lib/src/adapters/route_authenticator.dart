import '../entities/laams_route.dart';

class RouteAuthenticator {
  final List<String> publicRoutes;
  final String notAllowedRoute;
  RouteAuthenticator({
    required this.publicRoutes,
    required this.notAllowedRoute,
  });

  LaamsRoute authenticateOnIsSignedIn({
    required bool isSignedIn,
    required LaamsRoute currentRoute,
    required LaamsRoute newRoute,
  }) {
    final bool isPublic = publicRoutes.any((e) => e == newRoute.name);
    if (isSignedIn && isPublic) return currentRoute;
    if (isSignedIn && !isPublic) return newRoute;
    if (!isSignedIn && isPublic) return newRoute;
    if (!isSignedIn && !isPublic) {
      final newName = notAllowedRoute;
      return newRoute.copyWith(name: newName);
    }
    return newRoute;
  }

  LaamsRoute authenticateResetAction({
    required bool isSignedIn,
    required LaamsRoute currentRoute,
    required LaamsRoute newRoute,
  }) {
    final bool isPublic = publicRoutes.any((e) => e == newRoute.name);
    if (isSignedIn && isPublic) return currentRoute;
    if (isSignedIn && !isPublic) return newRoute;
    if (!isSignedIn && isPublic) return newRoute;

    if (!isSignedIn && !isPublic) {
      final newName = notAllowedRoute;
      return newRoute.copyWith(name: newName);
    }
    return newRoute;
  }

  LaamsRoute authenticatePushAction({
    required bool isSignedIn,
    required LaamsRoute currentRoute,
    required LaamsRoute newRoute,
  }) {
    final bool isPublic = publicRoutes.any((e) => e == newRoute.name);
    if (isSignedIn && isPublic) return currentRoute;
    if (isSignedIn && !isPublic) return newRoute;
    if (!isSignedIn && isPublic) return newRoute;
    final newName = notAllowedRoute;
    if (!isSignedIn && !isPublic) return newRoute.copyWith(name: newName);
    return newRoute;
  }

  LaamsRoute authenticateReplaceAction({
    required bool isSignedIn,
    required LaamsRoute currentRoute,
    required LaamsRoute newRoute,
  }) {
    final bool isPublic = publicRoutes.any((e) => e == newRoute.name);
    if (isSignedIn && isPublic) return currentRoute;
    if (isSignedIn && !isPublic) return newRoute;
    if (!isSignedIn && isPublic) return newRoute;
    final newName = notAllowedRoute;
    if (!isSignedIn && !isPublic) return newRoute.copyWith(name: newName);
    return newRoute;
  }
}

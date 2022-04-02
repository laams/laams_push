import '../entities/laams_route.dart';

class RouteAuthenticator {
  final List<String> publicRoutes;
  RouteAuthenticator({required this.publicRoutes});

  LaamsRoute authIsSignedIn(
    bool isSignedIn,
    LaamsRoute currentRoute,
  ) {
    final bool isPublic = publicRoutes.any((e) => e == currentRoute.path);
    if (isSignedIn && isPublic) return const LaamsRoute('/');
    if (isSignedIn && !isPublic) return currentRoute;
    if (!isSignedIn && isPublic) return currentRoute;
    return LaamsRoute(publicRoutes.first);
  }

  LaamsRoute authenticateRoute({
    required bool isSignedIn,
    required LaamsRoute currentRoute,
    required LaamsRoute newRoute,
  }) {
    final bool isPublic = publicRoutes.any((e) => e == newRoute.path);
    if (isSignedIn && isPublic) return currentRoute;
    if (isSignedIn && !isPublic) return newRoute;
    if (!isSignedIn && isPublic) return newRoute;
    return LaamsRoute(publicRoutes.first);
  }
}

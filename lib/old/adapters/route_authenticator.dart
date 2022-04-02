// import '../entities/laams_route.dart';

// class RouteAuthenticator {
//   final List<String> publicRoutes;
//   RouteAuthenticator({required this.publicRoutes});

//   LaamsRoute authIsSignedIn(
//     bool isSignedIn,
//     LaamsRoute currentRoute,
//   ) {
//     final bool isPublic = publicRoutes.any((e) => e == currentRoute.name);
//     if (isSignedIn && isPublic) return const LaamsRoute.init();
//     if (isSignedIn && !isPublic) return currentRoute;
//     if (!isSignedIn && isPublic) return currentRoute;
//     return LaamsRoute.init(name: publicRoutes.first);
//   }

//   LaamsRoute authenticateRoute({
//     required bool isSignedIn,
//     required LaamsRoute currentRoute,
//     required LaamsRoute newRoute,
//   }) {
//     final bool isPublic = publicRoutes.any((e) => e == newRoute.name);
//     if (isSignedIn && isPublic) return currentRoute;
//     if (isSignedIn && !isPublic) return newRoute;
//     if (!isSignedIn && isPublic) return newRoute;
//     return LaamsRoute.init(name: publicRoutes.first);
//   }
// }

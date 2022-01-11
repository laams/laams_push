// import '../entities/laams_route.dart';

// class RouteAuthenticator {
//   final List<String> privateRouteNames;
//   final List<String> publicRouteNames;
//   final String notFoundRouteName;
//   final String splashRouteName;

//   RouteAuthenticator({
//     this.privateRouteNames,
//     this.publicRouteNames,
//     this.notFoundRouteName,
//     this.splashRouteName,
//   });

//   /// Call this to authenticate a single route.
//   List<LaamsRoute> authenticateRoute({
//     required List<LaamsRoute> currentRoutes,
//     required LaamsRoute route,
//     // required NavAuthData data,
//     required bool isSignedIn,
//   }) {
//     currentRoutes = List<LaamsRoute>.from(currentRoutes);
//     var isSigninPath = route.name == signinPath;
//     var isSignupPath = route.name == signupPath;

//     var isPermitted = data.permissions.contains(route.path);
//     var isPublic = data.publicPaths.contains(route.path);
//     // Check if the Route ever really exist:
//     if (data.allAppPages.contains(route.path)) {
//       // Check if user is signed in:
//       if (data.isSignedIn == null) {
//         newRoutes.add(LaamsRoute.initialize(data.splashPath));
//         return List<LaamsRoute>.from(newRoutes);
//       } else if (data.isSignedIn!) {
//         // Check if has permission to visit:
//         if (isSigninPath || isSignupPath) {
//           newRoutes.add(LaamsRoute.initialize(data.initAuthedPath));
//           return List<LaamsRoute>.from(newRoutes);
//         } else if (!isPermitted) {
//           newRoutes.add(LaamsRoute.initialize(data.notAllowedPath));
//           return List<LaamsRoute>.from(newRoutes);
//         } else {
//           newRoutes.add(route);
//           return List<LaamsRoute>.from(newRoutes);
//         }
//       } else {
//         // If the user is Signed Out:
//         if (!isPublic) {
//           final initPublicRoute = LaamsRoute.initialize(data.initPublicPath);
//           return List<LaamsRoute>.from([initPublicRoute]);
//         } else if (!isPermitted) {
//           final notAllowedRoute = LaamsRoute.initialize(data.notAllowedPath);
//           return List<LaamsRoute>.from([notAllowedRoute]);
//         } else {
//           newRoutes.add(route);
//           return List<LaamsRoute>.from(newRoutes);
//         }
//       }
//     } else {
//       newRoutes.add(route);
//       return List<LaamsRoute>.from(newRoutes);
//     }
//   }

//   // /// Call this to authenticate mulitple routes.
//   // static List<LaamsRoute> authenticateRoutes({
//   //   required List<LaamsRoute> routes,
//   //   required NavAuthData data,
//   // }) {
//   //   var newRoutes = List<LaamsRoute>.from(routes);
//   //   var paths = newRoutes.map((e) => e.path).toList();
//   //   // Check if the Route ever really Exist:
//   //   if (paths.every((a) => data.allAppPages.any((b) => b == a))) {
//   //     var isSigninPath = paths.contains(data.signinPath);
//   //     var isSignupPath = paths.contains(data.signupPath);
//   //     var isPermitted = paths.every((a) => data.permissions.any((b) => b == a));
//   //     var isPublic = paths.every((a) => data.publicPaths.any((b) => b == a));
//   //     // Check if user is signed in:
//   //     if (data.isSignedIn == null) {
//   //       final splashRoute = LaamsRoute.initialize(data.splashPath);
//   //       return List<LaamsRoute>.from([splashRoute]);
//   //     } else if (data.isSignedIn!) {
//   //       // Check if has permission to visit:
//   //       if (isSigninPath || isSignupPath) {
//   //         final homeRoute = LaamsRoute.initialize(data.initAuthedPath);
//   //         return List<LaamsRoute>.from([homeRoute]);
//   //       } else if (!isPermitted) {
//   //         final notAllowedRoute = LaamsRoute.initialize(data.notAllowedPath);
//   //         return List<LaamsRoute>.from([notAllowedRoute]);
//   //       } else {
//   //         return List<LaamsRoute>.from(newRoutes);
//   //       }
//   //     } else {
//   //       // If the user is Signed Out:
//   //       if (!isPublic) {
//   //         final initPublicRoute = LaamsRoute.initialize(data.initPublicPath);
//   //         return List<LaamsRoute>.from([initPublicRoute]);
//   //       } else if (!isPermitted) {
//   //         final notAllowedRoute = JaguarRoute.initialize(data.notAllowedPath);
//   //         return List<LaamsRoute>.from([notAllowedRoute]);
//   //       } else {
//   //         return List<LaamsRoute>.from(newRoutes);
//   //       }
//   //     }
//   //   } else {
//   //     return List<LaamsRoute>.from(newRoutes);
//   //   }
//   // }
// }

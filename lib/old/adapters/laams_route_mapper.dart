// import 'dart:convert';

// import '../entities/laams_route.dart';

// class LaamsRouteMapper {
//   const LaamsRouteMapper();
//   Uri toURI(LaamsRoute route) {
//     var newQuery = <String, dynamic>{};
//     newQuery.addAll(route.query ?? {});
//     newQuery.removeWhere((key, value) => value == null);
//     var query = newQuery.map((k, v) => MapEntry(k, json.encode(v)));
//     bool isEmtpyQuery = query.isEmpty;
//     return Uri(
//       path: route.name,
//       queryParameters: isEmtpyQuery ? null : query,
//       fragment: route.fragment,
//     );
//   }

//   LaamsRoute fromURI(Uri uri) {
//     var query = uri.queryParameters.map((k, v) => MapEntry(k, json.decode(v)));
//     return LaamsRoute.init(
//       name: uri.path,
//       query: query,
//       fragment: uri.fragment.isEmpty ? null : uri.fragment,
//     );
//   }
// }

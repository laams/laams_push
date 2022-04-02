import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../entities/laams_route.dart';

class LaamsRouteParser extends RouteInformationParser<LaamsRoute> {
  const LaamsRouteParser();
  @override
  Future<LaamsRoute> parseRouteInformation(RouteInformation routeInformation) {
    final path = routeInformation.location;
    if (path == null || path == '/') {
      return SynchronousFuture(const LaamsRoute('/'));
    }

    final sgment = path.split('#');
    String newPath = '';
    String newFragment = '';
    if (sgment.length > 1) {
      newPath = sgment.first;
      newFragment = sgment.last;
    }

    // var newQuery = <String, dynamic>{};
    // if (routeInformation.state != null) {
    //   print('Route Info State: ${routeInformation.state}');
    //   newQuery = Map<String, dynamic>.from(
    //     json.decode(routeInformation.state as String),
    //   );
    // }
    var uri = Uri(
      // queryParameters: newQuery,
      path: newPath,
      fragment: newFragment,
    );
    return SynchronousFuture(LaamsRoute.fromURI(uri));
  }

  @override
  RouteInformation? restoreRouteInformation(LaamsRoute configuration) {
    return RouteInformation(
      location: configuration.path,
      // state: json.encode(configuration.query),
    );
  }
}

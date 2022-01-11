import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../entities/laams_route.dart';

class LaamsRouteParser extends RouteInformationParser<LaamsRoutes> {
  final String initialRoute;
  LaamsRouteParser([this.initialRoute = '/']);
  @override
  Future<LaamsRoutes> parseRouteInformation(RouteInformation routeInformation) {
    final location = routeInformation.location;
    if (location == null) {
      return SynchronousFuture([LaamsRoute.init(name: initialRoute)]);
    } else if (location == '/') {
      return SynchronousFuture([LaamsRoute.init(name: initialRoute)]);
    }
    final uri = Uri.parse(location);
    return SynchronousFuture(LaamsRoute.routesFromURI(uri));
  }

  @override
  RouteInformation? restoreRouteInformation(LaamsRoutes configuration) {
    var uri = LaamsRoute.fromRoutes(configuration);
    return RouteInformation(location: uri.path);
  }
}

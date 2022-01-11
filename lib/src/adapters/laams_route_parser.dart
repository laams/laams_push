import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../entities/laams_route.dart';

class LaamsRouteParser extends RouteInformationParser<LaamsRoutes> {
  final String initialRoute;
  LaamsRouteParser(this.initialRoute);
  @override
  Future<LaamsRoutes> parseRouteInformation(RouteInformation routeInformation) {
    var newState = routeInformation.state;
    var segs = Uri.parse(routeInformation.location ?? '').pathSegments;
    var initRoute = LaamsRoute.init(name: initialRoute);
    if (segs.isEmpty) return SynchronousFuture([initRoute]);
    List<LaamsRoute> routes = [];
    segs = segs.toSet().toList();
    for (var segment in segs) {
      var newRoute = const LaamsRoute.init(name: '');
      if (segment.contains('id=')) {
        routes.add(newRoute.copyWith(name: '/$segment', state: newState));
      } else {
        routes.add(newRoute.copyWith(name: '/$segment', state: newState));
      }
    }
    return SynchronousFuture(routes);
  }

  @override
  RouteInformation? restoreRouteInformation(LaamsRoutes configuration) {
    var rs = configuration.map((e) => e.name).toList();
    var state = configuration.last.state;
    return RouteInformation(location: rs.join(), state: state);
  }
}

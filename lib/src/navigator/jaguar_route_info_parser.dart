import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'models/jaguar_route.dart';

class JaguarRouteInfoParser extends RouteInformationParser<List<JaguarRoute>> {
  final String initialRoute;
  JaguarRouteInfoParser(this.initialRoute);
  @override
  Future<List<JaguarRoute>> parseRouteInformation(
      RouteInformation routeInformation) {
    var newState = routeInformation.state;
    var segs = Uri.parse(routeInformation.location ?? '').pathSegments;
    var initRoute = JaguarRoute.initialize(initialRoute);
    if (segs.isEmpty) return SynchronousFuture([initRoute]);
    List<JaguarRoute> routes = [];
    segs = segs.toSet().toList();
    for (var segment in segs) {
      var newRoute = JaguarRoute.initialize('');
      if (segment.contains('id=')) {
        routes.add(newRoute.copyWith(id: '/$segment', state: newState));
      } else {
        routes.add(newRoute.copyWith(path: '/$segment', state: newState));
      }
    }
    return SynchronousFuture(routes);
  }

  @override
  RouteInformation? restoreRouteInformation(List<JaguarRoute> configuration) {
    var rs = configuration.map((e) => e.path).toList();
    var state = configuration.last.state;
    return RouteInformation(location: rs.join(), state: state);
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../entities/laams_route.dart';
import 'laams_route_mapper.dart';

class LaamsRouteParser extends RouteInformationParser<LaamsRoute> {
  final LaamsRouteMapper _mapper;
  const LaamsRouteParser() : _mapper = const LaamsRouteMapper();
  @override
  Future<LaamsRoute> parseRouteInformation(RouteInformation routeInformation) {
    final location = routeInformation.location;
    if (location == null) return SynchronousFuture(const LaamsRoute.init());
    if (location == '/') return SynchronousFuture(const LaamsRoute.init());
    final uri = Uri.parse(location);
    final state = routeInformation.state;
    return SynchronousFuture(_mapper.fromURI(uri).copyWith(state: state));
  }

  @override
  RouteInformation? restoreRouteInformation(LaamsRoute configuration) {
    var uri = _mapper.toURI(configuration);
    return RouteInformation(location: '$uri', state: configuration.state);
  }
}

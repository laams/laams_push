import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'entities/laams_route.dart';
import 'laams_page.dart';
import 'state/laams_push.dart';

class LaamsRouterDelegate extends RouterDelegate<LaamsRoutes>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<LaamsRoutes> {
  final LaamsPush laamsPush;
  final LaamsPage Function(LaamsRoute name) onGeneratePages;
  LaamsRouterDelegate(this.laamsPush, this.onGeneratePages)
      : navigatorKey = GlobalKey<NavigatorState>(),
        super();

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  List<LaamsRoute> get currentConfiguration => laamsPush.routes;

  @override
  Future<void> setNewRoutePath(LaamsRoutes configuration) {
    laamsPush.onSetRoutes(configuration, true);
    return SynchronousFuture<void>(null);
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final bool success = route.didPop(result);
    if (success && laamsPush.routes.length > 1) laamsPush.onPop();
    return success;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: List<LaamsPage>.unmodifiable(
        laamsPush.routes.map(onGeneratePages).toList(),
      ),
      onPopPage: _onPopPage,
    );
  }
}
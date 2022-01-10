import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'jaguar_nav_setup.dart';
import 'models/jaguar_route.dart';
import 'models/navigator_stack.dart';

class JaguarRouterDelegate extends RouterDelegate<List<JaguarRoute>>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<JaguarRoute>> {
  final NavigatorStack state;
  final JaguarNavSetup setup;
  JaguarRouterDelegate(this.state, this.setup)
      : navigatorKey = GlobalKey<NavigatorState>(),
        super() {
    state.addListener(notifyListeners);
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  List<JaguarRoute> get currentConfiguration => state.routes;

  @override
  Future<void> setNewRoutePath(List<JaguarRoute> configuration) {
    state.setRoutes(configuration, true);
    return SynchronousFuture<void>(null);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('JagauarRouterDelegate.build: ${state.routes}');
    return Navigator(
      key: navigatorKey,
      pages: UnmodifiableListView(setup.routesToPages(state.routes)),
      onPopPage: _onPopPage,
    );
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    if (route.didPop(result)) {
      if (state.routes.length >= 2) {
        state.pop();
      }
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    state.removeListener(notifyListeners);
    super.dispose();
  }
}

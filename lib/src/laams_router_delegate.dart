import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'entities/laams_route.dart';
import 'laams_page.dart';
import 'state/laams_push_state.dart';

class LaamsRouterDelegate extends RouterDelegate<LaamsRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<LaamsRoute> {
  final LaamsPushState laamsPush;
  final LaamsPage Function(LaamsRoute name) onGeneratePages;
  LaamsRouterDelegate(this.laamsPush, this.onGeneratePages)
      : navigatorKey = GlobalKey<NavigatorState>(),
        super() {
    laamsPush.addListener(notifyListeners);
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  LaamsRoute get currentConfiguration => laamsPush.routes.last;

  @override
  Future<void> setNewRoutePath(LaamsRoute configuration) {
    // if (kDebugMode) print('LaamsRouterDelegate.setNewRoutePath:$configuration');
    laamsPush.onResetRoutes(configuration, isInitial: true);
    return SynchronousFuture<void>(null);
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final bool success = route.didPop(result);
    if (success) laamsPush.onPopRoute();
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

  @override
  void dispose() {
    laamsPush.removeListener(notifyListeners);
    super.dispose();
  }
}

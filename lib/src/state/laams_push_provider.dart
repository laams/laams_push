import 'package:flutter/material.dart';

import '../entities/laams_route.dart';
import 'laams_push.dart';

class LaamsPushProvider extends StatefulWidget {
  final bool isSignedIn;
  // final List<String> permissions;
  // final List<String> publicPaths;
  // final List<String> allAppPages;
  // final String initPublicPath;
  // final String initAuthedPath;
  // final String notAllowedPath;
  // final String splashPath;
  // final String signinPath;
  // final String signupPath;
  final Widget child;

  const LaamsPushProvider({
    Key? key,
    required this.isSignedIn,
    // required this.permissions,
    // required this.publicPaths,
    // required this.allAppPages,
    // required this.initPublicPath,
    // required this.initAuthedPath,
    // required this.notAllowedPath,
    // required this.splashPath,
    // required this.signinPath,
    // required this.signupPath,
    required this.child,
  }) : super(key: key);

  @override
  State<LaamsPushProvider> createState() => _LaamsPushProviderState();
}

class _LaamsPushProviderState extends State<LaamsPushProvider> {
  bool isSignedIn = false;
  LaamsRoutes _routes = [
    const LaamsRoute.init(name: '/'),
  ];

  @override
  void initState() {
    super.initState();
    isSignedIn = widget.isSignedIn;
  }

  @override
  void didUpdateWidget(covariant LaamsPushProvider oldWidget) {
    if (widget.child != oldWidget.child) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  void _setRoutes(List<LaamsRoute> routes, bool init) {
    if (init) {
      _routes = routes;
    } else {
      setState(() => _routes = routes);
    }

    // void setRoutes(List<JaguarRoute> newRoutes, bool init) {
    //   var generatedRoute = JaguarNavSetup.authenticateRoutes(
    //     routes: newRoutes,
    //     data: _data,
    //   );
    //   _routes = generatedRoute;
    //   if (!init) notifyListeners();
    // }
  }

  /// This is the name of the function
  void _push(LaamsRoute route) {
    setState(() {
      _routes.removeWhere((element) => element == route);
      _routes.add(route);
    });

    // void push(JaguarRoute newRoute) {
    //   if (_routes.last.path != newRoute.path) {
    //     var generatedRoute = JaguarNavSetup.authenticateRoute(
    //       currentRoutes: _routes,
    //       route: newRoute,
    //       data: _data,
    //     );
    //     _routes = generatedRoute;
    //     notifyListeners();
    //   }
    // }
  }

  // / Call this to replace the last route with a new one.
  void _replace(LaamsRoute route) {
    if (_routes.isNotEmpty) {
      setState(() {
        _routes.removeLast();
        _routes.add(route);
      });
    }

    // if (_routes.isNotEmpty) {
    //   _routes.removeLast();
    // }
    // if (!_routes.any((e) => e.path == newRoute.path)) {
    //   var generatedRoute = JaguarNavSetup.authenticateRoute(
    //     currentRoutes: _routes,
    //     route: newRoute,
    //     data: _data,
    //   );
    //   _routes = generatedRoute;
    //   notifyListeners();
    // }
  }

  // / Call this to replace the last route with a new one.
  void _replaceAll(LaamsRoute route) {
    setState(() {
      _routes = List<LaamsRoute>.from([route]);
    });
  }

  void _pop() {
    if (_routes.length >= 2) {
      setState(() => _routes.removeLast());
    }
  }

  // / Call this to remove a specific route from the list of routes.
  // void remove(JaguarRoute route) {
  //   if (_routes.isNotEmpty) {
  //     _routes.removeWhere((r) => r.path == route.path);
  //     notifyListeners();
  //   }
  // }

  // LaamsPush push(BuildContext context) {
  //   return context.findAncestorWidgetOfExactType<LaamsPush>()!;
  // }
  @override
  Widget build(BuildContext context) {
    return LaamsPush(
      onReplaceAll: _replaceAll,
      onSetRoutes: _setRoutes,
      onPop: _pop,
      onPush: _push,
      onReplace: _replace,
      routes: _routes,
      child: widget.child,
    );
  }
}

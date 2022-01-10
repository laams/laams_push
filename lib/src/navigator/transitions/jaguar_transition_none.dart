import 'package:flutter/material.dart';

class JaguarTransitionNone<T> extends PageRouteBuilder<T> {
  final Widget child;
  final int duration;

  JaguarTransitionNone({
    required this.child,
    required this.duration,
    required RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
          pageBuilder: (cxt, animateIn, animateOut) => child,
          transitionDuration: Duration(milliseconds: duration),
          transitionsBuilder: (_, animateIn, animateOut, child) => child,
        );
}

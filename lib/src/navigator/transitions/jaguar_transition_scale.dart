import 'package:flutter/material.dart';

class JaguarTransitionScale<T> extends PageRouteBuilder<T> {
  final Widget child;
  final int duration;
  JaguarTransitionScale({
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
          transitionsBuilder: (_, a, __, c) => _transit(a, c),
        );

  static FadeTransition _transit(Animation<double> anim, Widget child) {
    return FadeTransition(
      opacity: anim.drive(
        Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.linear)),
      ),
      child: ScaleTransition(
        scale: anim.drive(
          Tween(begin: 0.5, end: 1.0).chain(CurveTween(curve: Curves.linear)),
        ),
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/animation_type.dart';

class JaguarTransitionSlide<T> extends PageRouteBuilder<T> {
  final Widget child;
  final int duration;
  final AnimationType animationType;
  JaguarTransitionSlide({
    required this.child,
    required this.duration,
    required this.animationType,
    required RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
          settings: settings,
          pageBuilder: (cxt, animateIn, animateOut) => child,
          transitionDuration: Duration(milliseconds: duration),
          transitionsBuilder: (context, animateIn, animateOut, child) {
            return SlideTransition(
              position: animateIn.drive(
                Tween<Offset>(begin: _offset(animationType), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.easeOut)),
              ),
              child: child,
            );
          },
        );

  static Offset _offset(AnimationType direction) {
    if (direction == AnimationType.slideRight) return const Offset(-1, 0);
    if (direction == AnimationType.slideLeft) return const Offset(1, 0);
    if (direction == AnimationType.slideUp) return const Offset(0, 1);
    return const Offset(0, -1);
  }
}

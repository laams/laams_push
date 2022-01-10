import 'package:flutter/material.dart';
import 'models/jaguar_route.dart';
import 'models/animation_type.dart';
import 'transitions/jaguar_transition_fade.dart';
import 'transitions/jaguar_transition_none.dart';
import 'transitions/jaguar_transition_scale.dart';
import 'transitions/jaguar_transition_slide.dart';

class JaguarPage<T> extends Page<T> {
  final Widget child;
  final bool maintainState;
  final bool fullscreenDialog;
  final AnimationType animationType;
  final int animationDuration;
  JaguarPage({
    required String? path,
    required Object? arguments,
    String? restorationId,
    this.fullscreenDialog = false,
    this.maintainState = true,
    required this.animationType,
    required this.animationDuration,
    required this.child,
  }) : super(
          key: ValueKey(path),
          name: path,
          arguments: arguments,
          restorationId: restorationId,
        );
  @override
  Route<T> createRoute(BuildContext context) {
    if (animationType == AnimationType.none) return _buildNone();
    if (animationType == AnimationType.scale) return _buildScale();
    if (animationType == AnimationType.fade) return _buildFade();
    return _buildSlide();
  }

  JaguarTransitionScale<T> _buildScale() {
    return JaguarTransitionScale<T>(
      settings: this,
      child: child,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      duration: animationDuration,
    );
  }

  JaguarTransitionFade<T> _buildFade() {
    return JaguarTransitionFade<T>(
      settings: this,
      child: child,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      duration: animationDuration,
    );
  }

  JaguarTransitionSlide<T> _buildSlide() {
    return JaguarTransitionSlide<T>(
      settings: this,
      child: child,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      animationType: animationType,
      duration: animationDuration,
    );
  }

  JaguarTransitionNone<T> _buildNone() {
    return JaguarTransitionNone<T>(
      settings: this,
      child: child,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      duration: animationDuration,
    );
  }

  factory JaguarPage.fromRoute(JaguarRoute route, Widget child) {
    return JaguarPage(
      path: route.path,
      arguments: route.arguments,
      animationType: route.animationType,
      animationDuration: route.duration,
      child: child,
    );
  }
  factory JaguarPage.fromID(JaguarRoute route, Widget child) {
    return JaguarPage(
      path: route.path,
      arguments: route.arguments,
      animationType: route.animationType,
      animationDuration: route.duration,
      child: child,
    );
  }
}

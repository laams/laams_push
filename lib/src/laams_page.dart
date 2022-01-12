import 'package:flutter/material.dart';

import 'entities/enums/animation_type.dart';
import 'entities/laams_route.dart';

/// A page that extends [Page] with a custom [PageRouteBuilder]
///
/// The type `T` specifies the return type of the route which can be supplied as
/// the route is popped from the stack via [Navigator.transitionDelegate] by
/// providing the optional `result` argument to the
/// [RouteTransitionRecord.markForPop] in the [TransitionDelegate.resolve].
///
/// See also:
///
///  * [PageRouteBuilder], which is the [PageRoute] version of this class.
class LaamsPage<T> extends Page<T> {
  /// The `screen` which [LaamsPage<T>] wraps around.
  final Widget child;

  /// Has no effect, since transition animation is set manually by
  /// [AnimationType]
  final bool fullscreenDialog;

  /// Page Transition and Reverse Transition Animations
  /// in `miliseconds`
  final int animationDuration;

  /// While transiationing from page to the other
  final AnimationType animationType;

  /// Whether the route obscures previous routes when the transition is complete.
  /// When an opaque route's entrance transition is complete,
  /// the routes behind the opaque route will not be built to save resources.
  ///
  /// Copied from [TransitionRoute].
  final bool opaque;

  /// Whether you can dismiss this route by tapping the modal barrier.
  /// The modal barrier is the scrim that is rendered behind each route,
  /// which generally prevents the user from interacting with the route
  /// below the current route, and normally partially obscures such routes.
  ///
  /// For example, when a dialog is on the screen, the page below the dialog
  /// is usually darkened by the modal barrier.
  /// If [barrierDismissible] is true, then tapping this barrier will
  /// cause the current route to be popped with null as the value.
  final bool barrierDismissible;

  /// The color to use for the modal barrier. If this is null, the barrier
  /// will be transparent.
  final Color? barrierColor;

  /// If the barrier is dismissible, this label will be read out if
  /// accessibility tools (like VoiceOver on iOS) focus on the barrier.
  final String? barrierLabel;

  /// By default, when the created route is replaced by another, the previous
  /// route remains in memory. To free all the resources when this is not
  /// necessary, set [maintainState] to false.
  final bool maintainState;

  const LaamsPage._({
    /// The key associated with this page and be used for comparing
    /// pages in [canUpdate].
    required LocalKey key,

    /// The name of the route (e.g., "/settings").
    /// If null, the route is anonymous.
    required String name,

    /// The arguments passed to this route.
    ///
    /// May be used when building the route, e.g. in [Navigator.onGenerateRoute]
    required Object? arguments,

    /// Restoration ID to save and restore the state of the [Route]
    /// configured by this page.
    /// [RestorationManager] explains how state restoration works in Flutter.
    String? restorationId,
    required this.child,
    this.fullscreenDialog = true,
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
    this.animationDuration = 300,
    this.animationType = AnimationType.none,
  }) : super(
          key: key,
          name: name,
          arguments: arguments,
          restorationId: restorationId,
        );

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      opaque: opaque,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      transitionDuration: Duration(milliseconds: animationDuration),
      reverseTransitionDuration: Duration(milliseconds: animationDuration),
      pageBuilder: (context, animation, animationSecond) => child,
      transitionsBuilder: _buildTransition,
    );
  }

  Widget _buildTransition(
    BuildContext context,
    Animation<double> anim1,
    Animation<double> anim2,
    Widget child,
  ) {
    if (animationType == AnimationType.fade) {
      final fader = anim1.drive(Tween(begin: 0.0, end: 1.0).chain(
        CurveTween(curve: Curves.linear),
      ));
      return FadeTransition(opacity: fader, child: child);
    }

    if (animationType == AnimationType.scale) {
      final scaler = anim1.drive(Tween(begin: 0.25, end: 1.0).chain(
        CurveTween(curve: Curves.linear),
      ));
      final fader = anim1.drive(Tween(begin: 0.0, end: 1.0).chain(
        CurveTween(curve: Curves.linear),
      ));
      return ScaleTransition(
        scale: scaler,
        child: FadeTransition(opacity: fader, child: child),
      );
    }

    if (animationType == AnimationType.slideToEnd) {
      final dir = Directionality.of(context);
      final offset = dir == TextDirection.ltr ? -1.0 : 1.0;
      final slider = anim1.drive(
        Tween<Offset>(begin: Offset(offset, 0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOut)),
      );
      return SlideTransition(position: slider, child: child);
    }

    if (animationType == AnimationType.slideToStart) {
      final dir = Directionality.of(context);
      final offset = dir == TextDirection.ltr ? 1.0 : -1.0;
      final slider = anim1.drive(
        Tween<Offset>(begin: Offset(offset, 0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOut)),
      );
      return SlideTransition(position: slider, child: child);
    }

    if (animationType == AnimationType.slideUp) {
      final slider = anim1.drive(
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOut)),
      );
      return SlideTransition(position: slider, child: child);
    }
    if (animationType == AnimationType.slideDown) {
      final slider = anim1.drive(
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOut)),
      );
      return SlideTransition(position: slider, child: child);
    }

    return child;
  }

  static LaamsPage<T> fromRoute<T>(LaamsRoute route, Widget child) {
    return LaamsPage<T>._(
      key: ValueKey(route.name),
      name: route.name,
      animationType: route.animationType ?? AnimationType.none,
      animationDuration: route.animationDuration ?? 300,
      arguments: route.arguments,
      child: child,
    );
  }
}

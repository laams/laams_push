import 'package:flutter/material.dart';

import 'adapters/laams_router_delegate.dart';
import 'entities/animation_type.dart';
import 'entities/laams_route.dart';

/// Contains a set of Helper functions makes accessing [LaamsRouterDelegate]
/// easy and conventient.
///
/// For instance if you want to navigate to page by pressing a button
/// you can call any of these methods:
/// ```dart
/// () => LaamsPush.push(context, '/settings');
///
/// // Or:
/// () => LaamsPush.reset(context, '/home');
///
/// // Or:
/// () => LaamsPush.replace(context, '/products');
///
/// // Or:
/// () => LaamsPush.remove(context, '/settings');
///
/// // Or:
/// () => LaamsPush.pop(context);
/// ```
/// or can
/// `
mixin LaamsPush {
  /// pushes a new route on top of an existing route.
  /// [context] and [name] are required. [LaamsPush] uses app context
  /// to find [LaamsRouterDelegate] and call its [push] method.
  ///
  /// [name] argument is used to map the [name] of the route with the
  /// corresponding `screen` [Widget] in order to push it on the stack.
  ///
  /// [arguments] are used to pass Widgets and other data around. However,
  /// this is `NOT STABLE` yet, as Flutter cannot cache [Widget], if you
  /// press `forward` and `backward` key in the browser, it cannot restore,
  /// the passed widget from the route. `Wait for LaamsPush updates`
  ///
  /// [animationType] is used to define the kind of transition you will have
  /// When pushing a new `screen` on top of an existing one. and the
  /// [animationDuration] is for setting the amount of time in `miliseconds`
  /// it should take to transition from one route to the other.
  ///
  /// [state] is used by [LaamsRouteParser]
  ///
  /// [query] is used for advanced nativation, with specific details.
  /// We recommend using this instead of [argument] as it is stable and
  /// has familiar syntax.
  ///
  /// Remember when calling [LaamsPushApp.onGeneratePages] you have complete
  /// access to [LaamsRoute] which contains all the `configurations` and `data`
  /// which you can pass to the [Widget] you are instantiating.
  ///
  /// Similar to [query] [fragment] helps you go to a specific part of your page
  /// in the browsers urls it is denoted as `#fragment`
  ///
  /// both [query] and [fragment] are cached and is retreived when you navigate
  /// through browsers of your apps stack history.
  ///
  /// You can call each method for specific details.
  static void push(
    BuildContext context,
    String name, {
    Object? arguments,
    AnimationType animationType = AnimationType.scale,
    int animationDuration = 300,
    Object? state,
    Map<String, dynamic>? query,
    String? fragment,
  }) {
    final del = Router.maybeOf(context)?.routerDelegate as LaamsRouterDelegate?;
    return del?.state.onPushRoute(
      LaamsRoute(
        name,
        animationType: animationType,
        duration: animationDuration,
        // arguments: arguments,
        // state: state,
        query: query,
        fragment: fragment,
      ),
    );
  }

  /// Reintializes apps stack history with a completely new `route`
  /// [context] and [name] are required. [LaamsPush] uses app context
  /// to find [LaamsRouterDelegate] and call its [reset] method.
  ///
  /// [name] argument is used to map the [name] of the route with the
  /// corresponding `screen` [Widget] in order to push it on the stack.
  ///
  /// [arguments] are used to pass Widgets and other data around. However,
  /// this is `NOT STABLE` yet, as Flutter cannot cache [Widget], if you
  /// press `forward` and `backward` key in the browser, it cannot restore,
  /// the passed widget from the route. `Wait for LaamsPush updates`
  ///
  /// [animationType] is used to define the kind of transition you will have
  /// When pushing a new `screen` on top of an existing one. and the
  /// [animationDuration] is for setting the amount of time in `miliseconds`
  /// it should take to transition from one route to the other.
  ///
  /// [state] is used by [LaamsRouteParser]
  ///
  /// [query] is used for advanced nativation, with specific details.
  /// We recommend using this instead of [argument] as it is stable and
  /// has familiar syntax.
  ///
  /// Remember when calling [LaamsPushApp.onGeneratePages] you have complete
  /// access to [LaamsRoute] which contains all the `configurations` and `data`
  /// which you can pass to the [Widget] you are instantiating.
  ///
  /// Similar to [query] [fragment] helps you go to a specific part of your page
  /// in the browsers urls it is denoted as `#fragment`
  ///
  /// both [query] and [fragment] are cached and is retreived when you navigate
  /// through browsers of your apps stack history.
  static void reset(
    BuildContext context,
    String name, {
    Object? arguments,
    AnimationType animationType = AnimationType.scale,
    int animationDuration = 300,
    Object? state,
    Map<String, dynamic>? query,
    String? fragment,
  }) {
    final del = Router.maybeOf(context)?.routerDelegate as LaamsRouterDelegate?;
    return del?.state.onResetRoutes(
      LaamsRoute(
        name,
        animationType: animationType,
        duration: animationDuration,
        // arguments: arguments,
        // state: state,
        query: query,
        fragment: fragment,
      ),
    );
  }

  /// Replaces the top most `route` on the stack with the `new route`.
  ///
  /// [context] and [name] are required. [LaamsPush] uses app context
  /// to find [LaamsRouterDelegate] and call its [replace] method.
  ///
  /// [name] argument is used to map the [name] of the route with the
  /// corresponding `screen` [Widget] in order to push it on the stack.
  ///
  /// [arguments] are used to pass Widgets and other data around. However,
  /// this is `NOT STABLE` yet, as Flutter cannot cache [Widget], if you
  /// press `forward` and `backward` key in the browser, it cannot restore,
  /// the passed widget from the route. `Wait for LaamsPush updates`
  ///
  /// [animationType] is used to define the kind of transition you will have
  /// When pushing a new `screen` on top of an existing one. and the
  /// [animationDuration] is for setting the amount of time in `miliseconds`
  /// it should take to transition from one route to the other.
  ///
  /// [state] is used by [LaamsRouteParser]
  ///
  /// [query] is used for advanced nativation, with specific details.
  /// We recommend using this instead of [argument] as it is stable and
  /// has familiar syntax.
  ///
  /// Remember when calling [LaamsPushApp.onGeneratePages] you have complete
  /// access to [LaamsRoute] which contains all the `configurations` and `data`
  /// which you can pass to the [Widget] you are instantiating.
  ///
  /// Similar to [query] [fragment] helps you go to a specific part of your page
  /// in the browsers urls it is denoted as `#fragment`
  ///
  /// both [query] and [fragment] are cached and is retreived when you navigate
  /// through browsers of your apps stack history.
  static void replace(
    BuildContext context,
    String name, {
    Object? arguments,
    AnimationType animationType = AnimationType.none,
    int animationDuration = 300,
    Object? state,
    Map<String, dynamic>? query,
    String? fragment,
  }) {
    final del = Router.maybeOf(context)?.routerDelegate as LaamsRouterDelegate?;
    return del?.state.onReplaceRoute(
      LaamsRoute(
        name,
        animationType: animationType,
        duration: animationDuration,
        // arguments: arguments,
        // state: state,
        query: query,
        fragment: fragment,
      ),
    );
  }

  /// Removes the `route` with specified [name] from the `routes stack`.
  ///
  /// [context] and [name] are required. [LaamsPush] uses [BuildContext]
  /// to find [LaamsRouterDelegate] and call its [remove] method.
  ///
  /// [name] argument is used to map the [name] of the route with the
  /// corresponding `screen` [Widget] in order to push it on the stack.
  ///
  /// [arguments] are used to pass Widgets and other data around. However,
  /// this is `NOT STABLE` yet, as Flutter cannot cache [Widget], if you
  /// press `forward` and `backward` key in the browser, it cannot restore,
  /// the passed widget from the route. `Wait for LaamsPush updates`
  ///
  /// [animationType] is used to define the kind of transition you will have
  /// When pushing a new `screen` on top of an existing one. and the
  /// [animationDuration] is for setting the amount of time in `miliseconds`
  /// it should take to transition from one route to the other.
  ///
  /// [state] is used by [LaamsRouteParser]
  ///
  /// [query] is used for advanced nativation, with specific details.
  /// We recommend using this instead of [argument] as it is stable and
  /// has familiar syntax.
  ///
  /// Remember when calling [LaamsPushApp.onGeneratePages] you have complete
  /// access to [LaamsRoute] which contains all the `configurations` and `data`
  /// which you can pass to the [Widget] you are instantiating.
  ///
  /// Similar to [query] [fragment] helps you go to a specific part of your page
  /// in the browsers urls it is denoted as `#fragment`
  ///
  /// both [query] and [fragment] are cached and is retreived when you navigate
  /// through browsers of your apps stack history.
  static void remove(
    BuildContext context,
    String name, {
    Object? arguments,
    AnimationType animationType = AnimationType.scale,
    int animationDuration = 300,
    Object? state,
    Map<String, dynamic>? query,
    String? fragment,
  }) {
    final del = Router.maybeOf(context)?.routerDelegate as LaamsRouterDelegate?;
    return del?.state.onRemoveRoute(
      LaamsRoute(
        name,
        animationType: animationType,
        duration: animationDuration,
        // arguments: arguments,
        // state: state,
        query: query,
        fragment: fragment,
      ),
    );
  }

  /// Pops the top most `route` fromt the `route stack`.
  static void pop(BuildContext context) {
    final del = Router.maybeOf(context)?.routerDelegate as LaamsRouterDelegate?;
    return del?.state.onPopRoute();
  }

  static LaamsRoute? route(BuildContext context) {
    final del = Router.maybeOf(context)?.routerDelegate as LaamsRouterDelegate?;
    return del?.state.routes.last;
  }

  static String? currentPath(BuildContext context) {
    final del = Router.maybeOf(context)?.routerDelegate as LaamsRouterDelegate?;
    return del?.state.routes.last.path;
  }

  static bool isCurrentPath(BuildContext context, String? currentPath) {
    final del = Router.maybeOf(context)?.routerDelegate as LaamsRouterDelegate?;
    return del?.state.routes.last.path == currentPath;
  }
}

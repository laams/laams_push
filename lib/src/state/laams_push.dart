import 'package:flutter/material.dart';

import '../entities/laams_route.dart';

class LaamsPush extends InheritedWidget {
  final LaamsRoutes routes;
  final void Function(List<LaamsRoute> routes, bool init) onSetRoutes;
  final void Function(LaamsRoute route) onPush;
  final void Function(LaamsRoute route) onReplace;
  final void Function(LaamsRoute route) onReplaceAll;
  final void Function() onPop;
  const LaamsPush({
    Key? key,
    required Widget child,
    required this.routes,
    required this.onPush,
    required this.onPop,
    required this.onSetRoutes,
    required this.onReplace,
    required this.onReplaceAll,
  }) : super(key: key, child: child);

  static LaamsPush of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<LaamsPush>()!;
  }

  /// The [push] function adds the new `screen` on top of the current
  /// screen.
  ///
  /// The [context] and [name] parameters must be passed to the function
  /// [name] indicates the route name.
  ///
  /// for instance if you have a `page` named `settings` then
  /// you can assign the value of [name] as `settings` or `/settings`
  ///
  /// [arguments]are used for deeplinking.
  /// Think of it as `query` after `path` in a URL.
  ///
  /// For example:
  /// ```dart
  /// final argument = <String, dynamic> {
  /// 'productID': 123,
  /// 'productName': 'Shirt',
  /// }
  /// ```
  /// And if [name] is `product`
  /// This will be shown in the browser URL [arguments],
  /// `/product?productID=123&productName=Shirt',
  /// you can then receive the [arguments] in the second page
  /// as a Map<String, String> .
  /// Must be `serializable` or will give out error.
  ///
  /// The [state] of the application in the [location].
  /// The app can have different states even in the same location.
  /// For example, the text inside a [TextField] or
  /// the scroll position in a [ScrollView]. These widget states can
  /// be stored in the [state].
  ///
  /// [state] must be serializable
  ///
  /// [fragment] you go to a specific part of the page it will be prefixed with `#`
  /// for instance if you have a page with an info section then.
  static void push(
    BuildContext context,
    String name, {
    Object? arguments,
    Object? state,
    String? fragment,
  }) {
    final widget = context.findAncestorWidgetOfExactType<LaamsPush>()!;
    return widget.onPush(LaamsRoute(
      name: name,
      arguments: arguments,
      state: state,
      fragment: fragment,
    ));
  }

  static void pop(BuildContext context) {
    final widget = context.findAncestorWidgetOfExactType<LaamsPush>()!;
    return widget.onPop();
  }

  /// The [replace] function adds the new `screen` on top of the current
  /// screen.
  ///
  /// The [context] and [name] parameters must be passed to the function
  /// [name] indicates the route name.
  ///
  /// for instance if you have a `page` named `settings` then
  /// you can assign the value of [name] as `settings` or `/settings`
  ///
  /// [arguments]are used for deeplinking.
  /// Think of it as `query` after `path` in a URL.
  ///
  /// For example:
  /// ```dart
  /// final argument = <String, dynamic> {
  /// 'productID': 123,
  /// 'productName': 'Shirt',
  /// }
  /// ```
  /// And if [name] is `product`
  /// This will be shown in the browser URL [arguments],
  /// `/product?productID=123&productName=Shirt',
  /// you can then receive the [arguments] in the second page
  /// as a Map<String, String> .
  /// Must be `serializable` or will give out error.
  ///
  /// The [state] of the application in the [location].
  /// The app can have different states even in the same location.
  /// For example, the text inside a [TextField] or
  /// the scroll position in a [ScrollView]. These widget states can
  /// be stored in the [state].
  ///
  /// [state] must be serializable
  ///
  /// [fragment] you go to a specific part of the page it will be prefixed with `#`
  /// for instance if you have a page with an info section then.
  static void replace(
    BuildContext context,
    String name, {
    Object? arguments,
    Object? state,
    String? fragment,
  }) {
    final widget = context.findAncestorWidgetOfExactType<LaamsPush>()!;
    return widget.onReplace(LaamsRoute(
      name: name,
      arguments: arguments,
      state: state,
      fragment: fragment,
    ));
  }

  static void replaceAll(
    BuildContext context,
    String name, {
    Object? arguments,
    Object? state,
    String? fragment,
  }) {
    final widget = context.findAncestorWidgetOfExactType<LaamsPush>()!;
    return widget.onReplaceAll(LaamsRoute(
      name: name,
      arguments: arguments,
      state: state,
      fragment: fragment,
    ));
  }

  @override
  bool updateShouldNotify(LaamsPush oldWidget) {
    return routes != oldWidget.routes;
  }
}

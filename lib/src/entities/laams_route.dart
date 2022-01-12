import 'enums/animation_type.dart';

/// A list of [LaamsRoute]
typedef LaamsRoutes = List<LaamsRoute>;

/// It is a `Data Transfer Object` which holds the configuration for
/// [LaamsPage]
class LaamsRoute {
  /// for instance if you have a `page` named `settings` then
  /// you can assign the value of [name] as `settings` or `/settings`
  final String name;

  /// It will animate the route that is pushed on the stack.
  /// The default [animationType] is [AnimationType.none],
  final AnimationType? animationType;

  /// Amount of time it takes to navigate from one `route` to the other
  /// in `miliseconds`
  final int? animationDuration;

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
  final Object? arguments;

  /// The state of the application in the [location].
  /// The app can have different states even in the same location.
  /// For example, the text inside a [TextField] or
  /// the scroll position in a [ScrollView]. These widget states can
  /// be stored in the [state].
  ///
  /// [state] must be serializable
  final Object? state;

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
  final Map<String, dynamic>? query;

  /// Helps you go to a specific part of the page it will be prefixed with `#`
  /// for instance if you have a page with an info section then.
  final String? fragment;

  const LaamsRoute({
    required this.name,
    required this.animationType,
    required this.animationDuration,
    required this.arguments,
    required this.state,
    required this.query,
    required this.fragment,
  });

  const LaamsRoute.init({
    this.name = '/',
    this.animationType,
    this.animationDuration,
    this.arguments,
    this.state,
    this.query,
    this.fragment,
  });

  LaamsRoute copyWith({
    String? name,
    AnimationType? animationType,
    int? animationDuration,
    Map<String, String>? arguments,
    Object? state,
    Map<String, dynamic>? query,
    String? fragment,
  }) {
    return LaamsRoute(
      name: name ?? this.name,
      animationType: animationType ?? this.animationType,
      animationDuration: animationDuration ?? this.animationDuration,
      arguments: arguments ?? this.arguments,
      state: state ?? this.state,
      query: query ?? this.query,
      fragment: fragment ?? this.fragment,
    );
  }

  @override
  operator ==(other) {
    if (other is! LaamsRoute) return false;
    return name == other.name &&
        animationType == other.animationType &&
        animationDuration == other.animationDuration &&
        arguments == other.arguments &&
        state == other.state &&
        query == other.query &&
        fragment == other.fragment;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      animationType.hashCode ^
      animationDuration.hashCode ^
      arguments.hashCode ^
      state.hashCode ^
      query.hashCode ^
      fragment.hashCode;

  @override
  String toString() => name;
}

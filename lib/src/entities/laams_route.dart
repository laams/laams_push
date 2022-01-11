/// A list of [LaamsRoute]
typedef LaamsRoutes = List<LaamsRoute>;

/// It is a `Data Transfer Object` which holds the configuration for
/// [LaamsPage]
class LaamsRoute {
  /// for instance if you have a `page` named `settings` then
  /// you can assign the value of [name] as `settings` or `/settings`
  final String name;

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

  /// Helps you go to a specific part of the page it will be prefixed with `#`
  /// for instance if you have a page with an info section then.
  final String? fragment;
  const LaamsRoute({
    required this.name,
    required this.fragment,
    required this.arguments,
    required this.state,
  });

  const LaamsRoute.init({
    required this.name,
    this.fragment,
    this.arguments,
    this.state,
  });

  LaamsRoute copyWith({
    String? name,
    String? fragment,
    Map<String, String>? arguments,
    Object? state,
  }) {
    return LaamsRoute(
      name: name ?? this.name,
      fragment: fragment ?? this.fragment,
      arguments: arguments ?? this.arguments,
      state: state ?? this.state,
    );
  }

  @override
  operator ==(other) {
    if (other is! LaamsRoute) return false;
    return name == other.name &&
        fragment == other.fragment &&
        arguments == other.arguments &&
        state == other.state;
  }

  @override
  int get hashCode =>
      name.hashCode ^ fragment.hashCode ^ arguments.hashCode ^ state.hashCode;

  @override
  String toString() {
    return name;
  }

  static Uri fromRoutes(List<LaamsRoute> routes) {
    var newRoutes = routes.map((e) => e).toList();
    return Uri(path: newRoutes.join(''));
  }

  static List<LaamsRoute> routesFromURI(Uri uri) {
    var paths = uri.pathSegments;
    // paths.insert(0, '/');
    List<LaamsRoute> newRoutes = [];
    for (var path in paths) {
      final route = LaamsRoute.init(name: path);
      newRoutes.add(route);
    }
    return newRoutes;
  }
}

import 'animation_type.dart';

/// A list of [LaamsRoute]
typedef LaamsRoutes = List<LaamsRoute>;

/// It is a `Data Transfer Object` which holds the configuration for
/// [LaamsPage]
class LaamsRoute {
  /// The `path` or `location` of the route:
  /// ## Example:
  /// ```dart
  /// var simpleRoute = LaamsRoute(
  /// path: '/home/products/:id',
  /// )
  ///
  /// var complexRoute = LaamsRoute(
  /// path: '/home/:slug/products/:id/update',
  /// )
  /// ```
  /// The path portions prefixed with `:` are considered queries, such as `id`
  final String _path;

  /// if you have provided a path like: '/home/:slug/products/:id/update'
  /// the path portions
  /// then you must provide a query like this: <String, dynamic>{"id": "123"}
  final Map<String, dynamic>? query;

  /// Scrolling to a specific loation: /products#menu
  final String? fragment;

  /// It will animate the route that is pushed on the stack.
  /// The default [animationType] is [AnimationType.none],
  final AnimationType animationType;

  /// Amount of time it takes to navigate from one `route` to the other
  /// in `miliseconds`. Defaults to `250 miliseconds`
  final int duration;

  const LaamsRoute(
    String path, {
    this.query,
    this.fragment,
    this.animationType = AnimationType.none,
    this.duration = 250,
  }) : _path = path;

  LaamsRoute copyWith({
    String? path,
    Map<String, dynamic>? query,
    String? fragment,
    AnimationType? animationType,
    int? animationDuration,
  }) {
    return LaamsRoute(
      path ?? _path,
      query: query ?? this.query,
      fragment: fragment ?? this.fragment,
      animationType: animationType ?? this.animationType,
      duration: animationDuration ?? duration,
    );
  }

  /// Get a specific field value from [query] map if not `null`
  dynamic getQueryValue(String key) => query?[key];

  /// Replaces all the query regex such `:id` to its actual value
  /// and returns the result path as a [String].
  String get path {
    if (query == null || query?.entries == null) return _path;
    String newPath = _path;
    for (var e in query!.entries) {
      newPath = newPath.replaceAll(':${e.key}', '${e.value}');
    }
    if (fragment == null || fragment!.isEmpty) return newPath;
    return '$newPath#$fragment';
  }

  @override
  String toString() => path;

  /// Converts from `Uri` object
  factory LaamsRoute.fromURI(Uri uri) {
    var uriQuery = Map<String, dynamic>.from(uri.queryParameters);
    var anim = uriQuery.remove('animationType');
    return LaamsRoute(
      uri.path,
      query: uriQuery,
      fragment: uri.fragment.isEmpty ? null : uri.fragment,
      animationType: AnimationTypeParser.fromName(anim),
      duration: int.tryParse(uriQuery.remove('duration') ?? '') ?? 250,
    );
  }

  // Converts Laams Route to URI:
  Uri toURI() {
    var newQuery = <String, dynamic>{
      'animationType': animationType,
      'duration': duration,
    }..addAll(query ?? {});
    newQuery.removeWhere((key, value) => value == null);
    newQuery = newQuery.map((k, v) => MapEntry(k, '$v'));
    return Uri(
      path: _path,
      queryParameters: newQuery.isEmpty ? null : newQuery,
      fragment: fragment,
    );
  }
}

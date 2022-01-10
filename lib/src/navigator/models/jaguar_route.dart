import 'animation_type.dart';

class JaguarRoute {
  final String _path;
  final String? id;
  final Object? state;
  final Object? arguments;
  final AnimationType animationType;
  final int duration;

  String get path {
    if (id != null) return '/id=$id';
    return _path;
  }

  const JaguarRoute({
    required String path,
    required this.id,
    required this.state,
    required this.arguments,
    required this.animationType,
    required this.duration,
  }) : _path = path;

  /// Initialize Route to a Specific Path
  factory JaguarRoute.initialize(
    String path, {
    String? id,
    Object? state,
    Object? arguments,
    AnimationType animationType = AnimationType.none,
    int duration = 100,
  }) {
    return JaguarRoute(
      path: path,
      id: id,
      state: state,
      arguments: arguments,
      animationType: animationType,
      duration: duration,
    );
  }

  JaguarRoute copyWith({
    String? path,
    String? id,
    Object? state,
    Object? arguments,
    AnimationType? animation,
    int? duration,
  }) {
    return JaguarRoute(
      path: path ?? _path,
      id: id ?? this.id,
      state: state ?? this.state,
      arguments: arguments ?? this.arguments,
      animationType: animation ?? animationType,
      duration: duration ?? this.duration,
    );
  }

  @override
  String toString() {
    return path;
  }
}

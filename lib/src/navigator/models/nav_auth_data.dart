class NavAuthData {
  final bool? isSignedIn;
  final List<String> permissions;
  final List<String> publicPaths;
  final List<String> allAppPages;
  final String initPublicPath;
  final String initAuthedPath;
  final String notAllowedPath;
  final String splashPath;
  final String signinPath;
  final String signupPath;
  NavAuthData({
    this.isSignedIn,
    required this.permissions,
    required this.publicPaths,
    required this.allAppPages,
    required this.initPublicPath,
    required this.initAuthedPath,
    required this.notAllowedPath,
    required this.splashPath,
    required this.signinPath,
    required this.signupPath,
  });

  NavAuthData copyWith({
    bool? isSignedIn,
    List<String>? permissions,
    List<String>? publicPaths,
    List<String>? allAppPages,
    String? initPublicPath,
    String? initAuthedPath,
    String? notAllowedPath,
    String? splashPath,
    String? signinPath,
    String? signupPath,
  }) {
    return NavAuthData(
      isSignedIn: isSignedIn ?? this.isSignedIn,
      permissions: permissions ?? this.permissions,
      publicPaths: publicPaths ?? this.publicPaths,
      allAppPages: allAppPages ?? this.allAppPages,
      initPublicPath: initPublicPath ?? this.initPublicPath,
      initAuthedPath: initAuthedPath ?? this.initAuthedPath,
      notAllowedPath: notAllowedPath ?? this.notAllowedPath,
      splashPath: splashPath ?? this.splashPath,
      signinPath: signinPath ?? this.signinPath,
      signupPath: signupPath ?? this.signupPath,
    );
  }
}

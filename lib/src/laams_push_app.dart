import 'package:flutter/material.dart';

import 'adapters/laams_route_parser.dart';
import 'adapters/route_authenticator.dart';
import 'entities/laams_route.dart';
import 'laams_page.dart';
import 'laams_router_delegate.dart';
import 'state/laams_push_state.dart';

class LaamsPushApp extends StatefulWidget {
  final bool isUserSignedIn;
  final List<String> publicRoutes;
  final LaamsPage Function(LaamsRoute route) onGeneratePages;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final RouteInformationProvider? routeInformationProvider;
  final Widget? home;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
  final BackButtonDispatcher? backButtonDispatcher;
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final ThemeMode? themeMode;
  final Color? color;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<ShortcutActivator, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  final bool debugShowMaterialGrid;
  final bool useInheritedMediaQuery;
  const LaamsPushApp.router({
    Key? key,
    required this.isUserSignedIn,
    required this.publicRoutes,
    required this.onGeneratePages,
    this.routeInformationProvider,
    this.scaffoldMessengerKey,
    this.home,
    this.routes,
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.navigatorObservers,
    this.backButtonDispatcher,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = false,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.debugShowMaterialGrid = false,
    this.useInheritedMediaQuery = false,
  }) : super(key: key);

  @override
  State<LaamsPushApp> createState() => _LaamsPushAppState();
}

class _LaamsPushAppState extends State<LaamsPushApp> {
  late final LaamsPushState _state;
  @override
  void initState() {
    _state = LaamsPushState(
      widget.isUserSignedIn,
      RouteAuthenticator(publicRoutes: widget.publicRoutes),
    );
    // _state.setIsSignedIn(widget.isUserSignedIn);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LaamsPushApp oldWidget) {
    _state.setIsSignedIn(widget.isUserSignedIn);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routerDelegate = LaamsRouterDelegate(
      _state,
      widget.onGeneratePages,
    );
    return MaterialApp.router(
      scaffoldMessengerKey: widget.scaffoldMessengerKey,
      routeInformationProvider: widget.routeInformationProvider,
      routeInformationParser: const LaamsRouteParser(),
      routerDelegate: routerDelegate,
      backButtonDispatcher: widget.backButtonDispatcher,
      builder: widget.builder,
      title: widget.title,
      onGenerateTitle: widget.onGenerateTitle,
      color: widget.color,
      theme: widget.theme,
      darkTheme: widget.darkTheme,
      highContrastTheme: widget.highContrastTheme,
      highContrastDarkTheme: widget.highContrastDarkTheme,
      themeMode: widget.themeMode,
      locale: widget.locale,
      localizationsDelegates: widget.localizationsDelegates,
      localeListResolutionCallback: widget.localeListResolutionCallback,
      localeResolutionCallback: widget.localeResolutionCallback,
      supportedLocales: widget.supportedLocales,
      debugShowMaterialGrid: widget.debugShowMaterialGrid,
      showPerformanceOverlay: widget.showPerformanceOverlay,
      checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
      showSemanticsDebugger: widget.showSemanticsDebugger,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      shortcuts: widget.shortcuts,
      actions: widget.actions,
      restorationScopeId: widget.restorationScopeId,
      scrollBehavior: widget.scrollBehavior,
      useInheritedMediaQuery: widget.useInheritedMediaQuery,
    );
  }
}

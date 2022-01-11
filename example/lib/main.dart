import 'package:flutter/material.dart';
import 'package:laams_push/laams_push.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LaamsPush(),
      child: const MyMainApp(),
    ),
  );
}

class MyMainApp extends StatelessWidget {
  const MyMainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final laamsPush = context.read<LaamsPush>();
    return MaterialApp.router(
      routerDelegate: LaamsRouterDelegate(
        laamsPush,
        (route) {
          switch (route.name) {
            case MyHomePage.name:
              return LaamsPage.fromRoute(route, const MyHomePage());
            case MySecondPage.name:
              return LaamsPage.fromRoute(route, const MySecondPage());
            case MyThirdPage.name:
              return LaamsPage.fromRoute(
                route,
                MyThirdPage(argument: route.arguments as Text),
              );
            default:
              return LaamsPage.fromRoute(route, const MyHomePage());
          }
        },
      ),
      routeInformationParser: LaamsRouteParser('/'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  static const String name = '/';
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () => context
                  .read<LaamsPush>()
                  .push(const LaamsRoute.init(name: MySecondPage.name)),
              child: const Text('Go to Second'),
            ),
          ],
        ),
      ),
    );
  }
}

class MySecondPage extends StatelessWidget {
  static const String name = '/second';
  const MySecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () => context.read<LaamsPush>().push(
                    const LaamsRoute.init(
                      name: MyThirdPage.name,
                      arguments: Text("How are you today"),
                    ),
                  ),
              child: const Text('Go to Third'),
            ),
            TextButton(
              onPressed: () => context.read<LaamsPush>().pop(),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyThirdPage extends StatelessWidget {
  static const String name = '/third';
  final Text argument;
  const MyThirdPage({Key? key, required this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            argument,
            // TextButton(
            //   onPressed: () => LaamsPush.pop(context),
            //   child: const Text('Go to Second'),
            // ),
            // TextButton(
            //   onPressed: () => LaamsPush.replace(context, MySecondPage.name),
            //   child: const Text('Replace With Second'),
            // ),
            // TextButton(
            //   onPressed: () => LaamsPush.replaceAll(context, MyHomePage.name),
            //   child: const Text('Go to Home'),
            // ),
          ],
        ),
      ),
    );
  }
}

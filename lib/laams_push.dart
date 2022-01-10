library laams_push;

import 'package:flutter/material.dart';

import 'src/laams_app.dart';

export 'src/laams_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LaamsApp.router(
      pages: {
        MyHomePage.path: MyHomePage(),
        MyAboutPage.path: MyAboutPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  static const String path = '/';
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laams Push')),
      body: const Center(child: Text('Hello World!')),
    );
  }
}

class MyAboutPage extends StatelessWidget {
  static const String path = '/about';
  const MyAboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laams Push')),
      body: const Center(child: Text('My about page!')),
    );
  }
}

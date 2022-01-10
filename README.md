<p align="start">
<img src="https://github.com/laams/laams_push/blob/dev/assets/navigator.png?raw=true" height="300" alt="Navigator" />
</p>

## Overview of `laams_push`

The goal of `laams_push` is to make all the advanced functionalities of navigation in `Flutter` easy to use. We have developed a declarative URI-based router for advanced navigtion in Flutter. `laams_push` functionalities include but are not limited to deep linking, authentication based navigation, custom route transition animation and many more. 

## Features

- Deep linking
- Navigation based on user authentication state
- Custom animations for navigation transition


## Getting started

add the `laams_push` to your `pubspec.yaml` and you are good to go. 

## Usage

Here is an example of how to use `laams_push` in your project.

```dart

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
```

## Maintainers

- [Najibullah Khoda Rahim](https://github.com/najibkr)
- [Laams LLC Team](https://github.com/laams)



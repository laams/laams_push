![Navigation](https://github.com/laams/laams_push/blob/dev/assets/navigator.png?raw=true)

*Image Source: [Google*

## Overview

The goal of `laams_push` is to make all the advanced functionalities of navigation in `Flutter` easy to use. We have developed a declarative URI-based router for advanced navigtion in Flutter. `laams_push` functionalities include but are not limited to deep linking, authentication based navigation, custom route transition animation and many more. 

This is the syntax of a URI: 
![Navigation](https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/URI_syntax_diagram.svg/1068px-URI_syntax_diagram.svg.png)

## Features

- Deep linking
- Navigation based on user authentication state
- Custom animations for navigation transition


## Getting started

1. Add the `laams_push` to `pubspec.yaml` under `dependencies` section in your flutter project.

```
dependencies:
  laams_push: <latest>
```

## Usage

Lets take a look at how to use `laams_push` in your your application. 

1. Provide `LaamsApp.router()` at the top of the `Widget` tree. 
2. Provide all your `routes` as a value to `pages` property of `LaamsApp`

### main.dart

```dart
void main()=> runApp(MyApp());


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
```
3. To navigate from one page to another inside your app, call one of the following methods

```dart
LaamsPush.push(context, '/second'); // Pushes the second page on top of the current route

LaamsPush.replace(context, '/second'); // Replaces the current route with /second

LaamsPush.pop(context); // Pops the current if it is not the only route in the stack
```
## Complete Example: 

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



![Navigation](https://github.com/laams/laams_push/blob/dev/assets/navigator.png?raw=true)

*Image Source: [Google*

## Overview

We have created the most effortless and easy-to-use routing solution for Flutter built on top of Navigator 2.0. The goal of `laams_push` is to make all the `advanced` functionalities of navigation in Flutter `easy to use`. We have developed a declarative URI-based router for advanced navigtion in Flutter. `laams_push` functionalities include but are not limited to deep linking, authentication based navigation, custom route transition animation and many more. 

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
And copy and past the example solution from the [example] tab. We have used `provider` for simple state management of the `example` app, you should add `provider` as a dependencies for the app to work.

Note: `laams_push` itself does not have any third-party dependencies. 
## Usage

All you have to do is:

### 1. Add `LaamsPushApp.router` instead of `MaterialApp.router` at the top of your widget tree. `LaamsPush.router` is just a wrapper around `MaterialApp` to make `laams_push` navigation setup completely effortless for you. This widget has five required properties which you should instantiate. 


Here is an example: 

```dart

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = context.watch<UserBloc>();
    return LaamsPushApp.router(
      isUserSignedIn: userBloc.isSignedIn,
      theme: ThemeData.light(),
      title: 'Laams Router Application',
      publicRoutes: const [SignInScreen.name, NotAllowedScreen.name],
      onGeneratePages: (LaamsRoute route) {
        switch (route.name) {
          case HomeScreen.name:
            return LaamsPage.fromRoute(route, const HomeScreen());
          case SignInScreen.name:
            return LaamsPage.fromRoute(route, const SignInScreen());
          case ProductsScreen.name:
            return LaamsPage.fromRoute(route, const ProductsScreen());
          case ProductDetail.name:
            final product = Product.fromJson(route.query!);
            return LaamsPage.fromRoute(route, ProductDetail(product));
          case NotAllowedScreen.name:
            return LaamsPage.fromRoute(route, NotAllowedScreen(route));
          default:
            return LaamsPage.fromRoute(route, NotFoundScreen(route));
        }
      },
    );
  }
}

```
* `isUserSignedIn`: displays a `screen` based on the user signed in status. You can provide the signed in status of the user using any of the available state management solutions. We have use `provider` in our example project, since it is easy to setup for smaller apps. 
* `onGeneratePages`: maps [LaamsRoute] to [LaamsPage]. Think of it as `onGenerateRoutes` inside flutter `MaterialApp`. You instantiate your screens based on the `route.name`. Make user to add a `notfound` route as the default. 
* `publicRoutes`: By default, all of the routes are protected, meaning a user who is not signed in cannot access any of the routes, except the public routes. list names of all your public routes here. 

### 2. Use any of these methods from any part of your Widget tree: 
```dart
 // Or:
 () => LaamsPush.push(context, '/settings');

 // Or:
 () => LaamsPush.reset(context, '/home');

 // Or:
() => LaamsPush.replace(context, '/products');

 // Or:
 () => LaamsPush.remove(context, '/settings');

 // Or:
 () => LaamsPush.pop(context);
```
* `LaamsPush.push`: pushes a route on top of the current route.
* `LaamsPush.reset`: reintializes the route stack with a new route. 
* `LaamsPush.replace`: replaces the current route with a new route, without changing the rest of routes stack.
* `LaamsPush.remove`: removes a route if it is behind or on top of the current route. 
* `LaamsPush.pop`: pops the current route. 


### When calling any of the above methods you can pass more arguments: 
For Example: 

```dart
  LaamsPush.push(
    context,
    '/settings',
    animationDuration: 300,
    animationType: AnimationType.slideDown,
    query: <String, dynamic>{
      'productID': 123,
      'productName': 'T-Shirt',
      'imageURL': 'https://www.example.com/image.jpg'
    },
    fragment: 'second-section',
    arguments: 'productID',
    state: 'any state',
  );
```
* `context`: `LaamsPush` uses `BuildContext` to find the the ancester Router's delegate, and call its methods. 
* `name`: is `LaamsRoute.name` value which is instantiated after you call one of the aforementioned, cached and then returned back as a parameter of `onGeneratePages` inside `LaamsPushApp.router`. You don't have to know how it works. All you have to know is this is `path` or name of the `screen` that you can to display. 
* `animationDuration`: The amount of time it should take in `miliseconds` to navigate to the new route. 
* `animationType`: The type of animation used when transitioning from one route to the other. `AnimationType.slideDown`, for instance, pushes the new route in the stack, while being dropped down from top to bottom. 
* `query`: This is our recommended solution for passing data from one screen to the other. Pass your data as `Map<String, dynamic>` and it receive in the next `Screen` as an argument. Look at the product details section and products list page in our example project. 
* `fragment`: this is equivalent to `#fragment` in the Uri, you can use this to navigate to a particular part of the new screen. 
* `arguments`: is passed to `RouteSettings`, it is not safe, we do not recommend using it, as Flutter cannot cache the data or the widget when you are passing to it, and will emit error, if you, for example, use the arrow buttons of your browser. 
* `state`: is passed to `LaamsRouteParser` for other browsing history caching mechanism. you do not have to use `arguments` or `state`. Use `query` and `fragment` instead, and let `laams_push` handle the rest.

#### Note: you do not have to know how any of these work. Just use them and they will work like a charm out of the box. 

## Advanced Usage: 
If you opt out of `LaamsPushApp.router`, You can use the following classes to setup everything on your own. 

1. `LaamsPushState`: a class which uses `ChangeNotifier` to keep track of the `routes stack`. 
2. `LaamsRouteParser` a class which parses `LaamsRoute` for Os configurations.
3. `LaamsRouteMapper`: converts `LaamsRoute` to Uri and back. 
4. `LaamsRoute`: you can extend it to add more functionalities for passing data from one widget to other. It holds the configurations for `LaamsPage`
5. `Laamspage`: it extends `Page<T>` and holds configurations for a route, which is then used for `Navigator`'s route stack inside a `Router`. 
6. `LaamsRouterDelegate`: It brings everything together. you can use it in `MaterialApp.router` or `Router.delegate`.

You do not have to use any of these. If you are using a `CupertinoApp` or a `WidgetsApp`, then, have a looke at `LaamsPushApp.router` implementation for better understanding, and reimplement that in your app, with all the functionalities that `laams_push` provides for you out of the box. 

## Best Practices: 
1. Use `LaamsPushApp.router` and have everything work for you out of the box.
2. Declare the name of your routes as a static const variable inside the widget that you want to display. for instance if you have a widget as your home screen and the name is `/home`, this is how you name it. 
  
```dart
class HomePage extends StatelessWidget {
  // name of the route: 
  static const String name = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Heme Page')),
    );
  }
}
```
This way, you can use the name of your route anywhere by calling: `HomePage.name`.

```dart
// When calling a buttons `onPressed` method: 
onPressed: () => LaamsPush.push(context, HomePage.name);

// Or in `onGeneratePages`:
if (route.name == HomePage.name){
  return LaamsPage.fromRoute(route, Homepage());
}
```


## Maintainers

- [Najibullah Khoda Rahim](https://github.com/najibkr)
- [Laams LLC Team](https://github.com/laams)



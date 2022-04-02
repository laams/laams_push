import 'package:flutter/material.dart';
import 'package:laams_push/laams_push.dart';
import 'package:provider/provider.dart';

/// A Bloc for keeping the state of the user
/// You can use a package of of your choice
/// For this app, ChangeNotifier with Provider has been chosen.
class UserBloc with ChangeNotifier {
  bool _isSignedIn = true;
  bool get isSignedIn => _isSignedIn;
  void signIn() {
    _isSignedIn = true;
    notifyListeners();
  }

  void signOut() {
    _isSignedIn = false;
    notifyListeners();
  }
}

// Product Enttiy
class Product {
  final int id;
  final String name;
  const Product({required this.id, required this.name});

  Product copyWith({int? id, String? name}) {
    return Product(id: id ?? this.id, name: name ?? this.name);
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'name': name};
  }
}

/// You can use any state management solution.
class ProductBloc with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => List<Product>.unmodifiable(_products);
  ProductBloc() {
    _products = productsFakeRepo;
  }

  void getProducts() {
    _products = productsFakeRepo;
    notifyListeners();
  }

  List<Product> productsFakeRepo = List<Product>.generate(100, (index) {
    return Product(id: index, name: 'My Product $index');
  });
}

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserBloc()),
      ChangeNotifierProvider(create: (_) => ProductBloc()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = context.watch<UserBloc>();
    return LaamsPushApp.router(
      isUserSignedIn: userBloc.isSignedIn,
      theme: ThemeData.light(),
      title: 'Laams Router Application',
      publicRoutes: const [SignInScreen.name],
      onGeneratePages: (LaamsRoute route) {
        switch (route.path) {
          case HomeScreen.name:
            return LaamsPage.fromRoute(route, const HomeScreen());
          case SignInScreen.name:
            return LaamsPage.fromRoute(route, const SignInScreen());
          case ProductsScreen.name:
            return LaamsPage.fromRoute(route, const ProductsScreen());
          case ProductDetail.name:
            final product = Product.fromJson(route.query!);
            return LaamsPage.fromRoute(route, ProductDetail(product));
          default:
            return LaamsPage.fromRoute(route, NotFoundScreen(route));
        }
      },
    );
  }
}

/// It `must` be called as the default in [LaamsPushApp.onGeneratePages],
class NotFoundScreen extends StatelessWidget {
  final LaamsRoute route;
  static const String name = '/notfound';
  const NotFoundScreen(this.route, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cound Not Find ${route.path.toUpperCase()}')),
      body: Center(
        child: TextButton(
          onPressed: () => LaamsPush.replace(context, HomeScreen.name),
          child: const Text('Could Find the page, go back home?'),
        ),
      ),
    );
  }
}

/// If the user is not signed in, this page is displayed to the user.
/// It `must` be passed as public route.
class SignInScreen extends StatelessWidget {
  static const String name = '/signin';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signin Screen')),
      body: Center(
        child: TextButton(
          onPressed: context.read<UserBloc>().signIn,
          child: const Text('Sign In'),
        ),
      ),
    );
  }
}

/// The first page automatically displayed after signinin
/// it must the first route to be decalared.
class HomeScreen extends StatelessWidget {
  static const String name = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signout = TextButton(
      onPressed: () => context.read<UserBloc>().signOut(),
      child: const Text("Signout", style: TextStyle(color: Colors.white)),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen'), actions: [signout]),
      body: Center(
        child: TextButton(
          onPressed: () => LaamsPush.push(context, ProductsScreen.name),
          child: const Text('Go to Products Screen'),
        ),
      ),
    );
  }
}

class ProductsScreen extends StatelessWidget {
  static const String name = '/products';
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsList = Consumer<ProductBloc>(
      builder: (context, bloc, _) => ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () => LaamsPush.push(
            context,
            ProductDetail.name,
            query: {"id": bloc.products[index].id},
          ),
          title: Text(bloc.products[index].name),
          subtitle: Text('${bloc.products[index].id}'),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Products Screen')),
      body: productsList,
    );
  }
}

class ProductDetail extends StatelessWidget {
  static const String name = '/products/:id';
  final Product product;
  const ProductDetail(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About ${product.name}')),
      body: ListTile(
        onTap: () => LaamsPush.pop(context),
        title: Text(product.name),
        subtitle: Text('${product.id}'),
        trailing: const Icon(Icons.close),
      ),
    );
  }
}

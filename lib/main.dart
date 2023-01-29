import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/prov_products.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edt_product_screen.dart';
import 'package:shop_app/screens/manage_products_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/products_screen.dart';
import 'package:shop_app/screens/single_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(null,
              []), //error here saying 3 positional arguments expected,but 0 found.
          update: (ctx, auth, previousProducts) => Products(auth.token,
              previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            fontFamily: "Lato",
            colorScheme: Theme.of(context)
                .colorScheme
                .copyWith(primary: Colors.blue, secondary: Colors.brown[300])),
        home: Consumer<Auth>(
            builder: (context, auth, _) =>
                auth.isAuth ? const ProductScreen() : const AuthScreen()),
        routes: {
          SingleProductScreen.routeName: (ctx) => const SingleProductScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrdersScreen.routeName: ((ctx) => const OrdersScreen()),
          ManageProductsScreen.routeName: (ctx) => const ManageProductsScreen(),
          EditProductScreen.routeName: (ctx) => const EditProductScreen(),
        },
      ),
    );
  }
}

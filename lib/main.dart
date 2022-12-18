import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/prov_products.dart';
import 'package:shop_app/screens/cart_screen.dart';
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
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            fontFamily: "Lato",
            colorScheme: Theme.of(context)
                .colorScheme
                .copyWith(primary: Colors.blue, secondary: Colors.brown[300])),
        home: const ProductScreen(),
        routes: {
          SingleProductScreen.routeName: (ctx) => const SingleProductScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
        },
      ),
    );
  }
}

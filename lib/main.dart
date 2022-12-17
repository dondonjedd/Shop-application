import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: "Lato",
          colorScheme: Theme.of(context)
              .colorScheme
              .copyWith(primary: Colors.blue, secondary: Colors.brown[200])),
      home: ProductScreen(),
      routes:  {SingleProductScreen.routeName:(ctx)=>SingleProductScreen()},
    );
  }
}

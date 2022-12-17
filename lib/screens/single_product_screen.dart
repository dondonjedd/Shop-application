import 'package:flutter/material.dart';

class SingleProductScreen extends StatelessWidget {
  // final Product product;
  // const SingleProductScreen({super.key, required this.product});

  static const routeName = "single-product-screen";

  const SingleProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String productId = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(productId),
      ),
    );
  }
}

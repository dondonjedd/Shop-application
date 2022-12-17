import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/prov_products.dart';

class SingleProductScreen extends StatelessWidget {
  // final Product product;
  // const SingleProductScreen({super.key, required this.product});

  static const routeName = "single-product-screen";

  const SingleProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String productId = ModalRoute.of(context)?.settings.arguments as String;
    final product = Provider.of<Products>(context, listen: false)
        .getById(productId) as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}

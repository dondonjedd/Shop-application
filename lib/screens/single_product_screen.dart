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
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            width: double.infinity,
            height: 300,
            child: Image.network(
              product.imageURL,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "RM${product.price}",
            style: const TextStyle(color: Colors.grey, fontSize: 10),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              product.description,
              textAlign: TextAlign.center,
              softWrap: true,
              style: const TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop App"),
      ),
      body: const products_grid(),
    );
  }
}

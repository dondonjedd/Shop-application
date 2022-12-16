import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {},
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {},
          ),
        ),
        child: Image.network(
          product.imageURL,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

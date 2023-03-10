import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/prov_products.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;

  const ProductsGrid({super.key, required this.showFavorites});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    final availableProducts =
        showFavorites ? productsProvider.favItems : productsProvider.items;
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<Products>(context, listen: false)
            .fetchAndSetProducts();
      },
      child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: availableProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemBuilder: (context, idx) {
            return ChangeNotifierProvider.value(
              value: availableProducts[idx],
              child: const ProductItem(),
            );
          }),
    );
  }
}

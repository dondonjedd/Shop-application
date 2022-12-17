import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/prov_products.dart';
import 'package:shop_app/widgets/product_item.dart';

class products_grid extends StatelessWidget {
  const products_grid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    final availableProducts = productsProvider.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: availableProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, idx) {
          return ProductItem(
            product: availableProducts[idx],
          );
        });
  }
}

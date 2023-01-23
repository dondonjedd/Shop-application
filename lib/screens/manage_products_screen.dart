import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/prov_products.dart';
import 'package:shop_app/screens/edt_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/manage_product_item.dart';

class ManageProductsScreen extends StatelessWidget {
  const ManageProductsScreen({super.key});
  static const routeName = "/manage-products";

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productProvider.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              ManageProductItem(
                id: productProvider.items[i].id,
                title: productProvider.items[i].title,
                imageUrl: productProvider.items[i].imageURL,
              ),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}

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
    print("building manage product screen");
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
      body: FutureBuilder(
        future: Provider.of<Products>(context, listen: false)
            .fetchAndSetProducts(true),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      await Provider.of<Products>(context, listen: false)
                          .fetchAndSetProducts(true);
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Consumer<Products>(
                            builder: ((ctx, productData, _) => ListView.builder(
                                  itemCount: productData.items.length,
                                  itemBuilder: (_, i) => Column(
                                    children: [
                                      ManageProductItem(
                                        id: productData.items[i].id,
                                        title: productData.items[i].title,
                                        imageUrl: productData.items[i].imageURL,
                                      ),
                                      const Divider()
                                    ],
                                  ),
                                )))),
                  ),
      ),
    );
  }
}

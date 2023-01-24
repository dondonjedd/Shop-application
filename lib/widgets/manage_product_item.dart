import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/prov_products.dart';
import 'package:shop_app/screens/edt_product_screen.dart';

class ManageProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  const ManageProductItem(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.id});

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () async {
                final res = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Are you sure"),
                          content:
                              const Text("Do you want to remove this product?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: const Text("Yes")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text("No"))
                          ],
                        ));

                if (res) {
                  try {
                    await Provider.of<Products>(context, listen: false)
                        .deleteProduct(id);
                  } catch (e) {
                    scaffold.hideCurrentSnackBar();
                    scaffold.showSnackBar(SnackBar(
                      content: const Text(
                        "Unable to delete product",
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Theme.of(context).errorColor,
                    ));
                  }
                }
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}

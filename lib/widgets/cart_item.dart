import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  const CartItemWidget(
    this.item, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(item.product.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.removeItem(item.product.id);
      },
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.inversePrimary,
          size: 40,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.network(item.product.imageURL),
              ),
              title: Text(item.product.title),
              subtitle: Text(
                  "Per Item: RM${item.product.price}\nTotal: RM${item.product.price * item.quantity}"),
              trailing: Text("${item.quantity}x"),
            )),
      ),
    );
  }
}

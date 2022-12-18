import 'package:flutter/material.dart';

import '../providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  const CartItemWidget(
    this.item, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}

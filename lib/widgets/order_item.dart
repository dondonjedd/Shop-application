import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  const OrderItem({super.key, required this.order});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("Total: RM ${widget.order.amount}"),
            subtitle: Text(
                "Ordered on ${DateFormat("dd/MM/yyyy").format(widget.order.dateTime)} at ${DateFormat("hh:mm a").format(widget.order.dateTime)}"),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Column(
              children: [
                const Divider(),
                SizedBox(
                  height: min(widget.order.products.length * 20.0 + 100, 180),
                  child: ListView.builder(
                      itemBuilder: ((ctx, i) => ListTile(
                            leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Image.network(
                                    widget.order.products[i].product.imageURL)),
                            title: Text(widget.order.products[i].product.title),
                            subtitle: Text(
                                "${widget.order.products[i].quantity} x RM${widget.order.products[i].product.price}"),
                          ))),
                ),
              ],
            )
        ],
      ),
    );
  }
}

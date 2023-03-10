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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height:
          _expanded ? min(widget.order.products.length * 60.0 + 110, 250) : 95,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title:
                    Text("Total: RM ${widget.order.amount.toStringAsFixed(2)}"),
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
                AnimatedContainer(
                  // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  height: _expanded
                      ? min(widget.order.products.length * 60 + 20, 150)
                      : 0,
                  duration: const Duration(milliseconds: 200),
                  child: ListView.builder(
                      itemCount: widget.order.products.length,
                      itemBuilder: ((ctx, i) => Column(
                            children: [
                              const Divider(height: 0),
                              ListTile(
                                leading: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Image.network(widget
                                        .order.products[i].product.imageURL)),
                                title: Text(
                                    widget.order.products[i].product.title),
                                subtitle: Text(
                                    "${widget.order.products[i].quantity} x RM${widget.order.products[i].product.price}"),
                              ),
                            ],
                          ))),
                )
            ],
          ),
        ),
      ),
    );
  }
}

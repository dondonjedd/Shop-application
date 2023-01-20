import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart' show Orders;

import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Your Orders")),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItem(order: ordersProvider.orders[i]),
        itemCount: ordersProvider.orders.length,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart' show Orders;
import 'package:shop_app/widgets/app_drawer.dart';

import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  static const routeName = "/orders";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future _ordersFuture;
  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    // TODO: implement initState
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Bulding Orders");
    return Scaffold(
      appBar: AppBar(title: const Text("Your Orders")),
      drawer: const AppDrawer(),
      body: FutureBuilder(
          future: _ordersFuture,
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.error != null) {
                return const Center(
                  child: Text("An Error Occured"),
                );
              }
              return Consumer<Orders>(
                  builder: ((context, orderData, child) => ListView.builder(
                        itemBuilder: (ctx, i) =>
                            OrderItem(order: orderData.orders[i]),
                        itemCount: orderData.orders.length,
                      )));
            }
          })),
    );
  }
}

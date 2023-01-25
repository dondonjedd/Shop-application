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
  var _isInit = false;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Orders>(context, listen: false)
          .fetchAndSetOrders()
          .then((value) => setState(() {
                _isLoading = false;
              }));
      _isInit = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Your Orders")),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (ctx, i) =>
                  OrderItem(order: ordersProvider.orders[i]),
              itemCount: ordersProvider.orders.length,
            ),
    );
  }
}

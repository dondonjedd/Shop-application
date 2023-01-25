import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';

class OrderButton extends StatefulWidget {
  const OrderButton({super.key});

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return _isLoading
        ? const CircularProgressIndicator()
        : TextButton(
            onPressed: cart.getTotalAmount <= 0
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });

                    try {
                      await Provider.of<Orders>(context, listen: false)
                          .addOrder(
                              cart.items.values.toList(), cart.getTotalAmount);
                      cart.clear();
                    } catch (e) {
                      await showDialog<void>(
                          context: context,
                          builder: ((context) => AlertDialog(
                                title: const Text("Error when adding order"),
                                content: const Text("Something went wrong"),
                                actions: [
                                  TextButton(
                                      onPressed: (() =>
                                          Navigator.of(context).pop()),
                                      child: const Text("OK"))
                                ],
                              )));
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  },
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primary)),
            child: Text(
              "Order Now",
              style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.titleLarge?.color),
            ),
          );
  }
}

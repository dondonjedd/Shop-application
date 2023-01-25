import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../utils.dart';
import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return _orders;
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.https(urlDomain, '/orders.json');
    try {
      final response = await http.post(url,
          body: json.encode({
            'amount': total,
            'products': cartProducts
                .map((cartItem) => {
                      'product': {
                        'id': cartItem.product.id,
                        'title': cartItem.product.title,
                        'description': cartItem.product.description,
                        'imageURL': cartItem.product.imageURL,
                        'price': cartItem.product.price,
                        'isFavorite': cartItem.product.isFavorite,
                      },
                      'quantity': cartItem.quantity
                    })
                .toList(),
            'dateTime': DateTime.now().toIso8601String(),
          }));

      _orders.insert(
          0,
          OrderItem(
              id: json.decode(response.body)['name'],
              amount: total,
              products: cartProducts,
              dateTime: DateTime.now()));

      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  void removeOrder(String productID) {
    _orders.removeWhere((element) => element.id == productID);
    notifyListeners();
  }
}

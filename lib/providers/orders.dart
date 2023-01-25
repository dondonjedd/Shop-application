import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/providers/product.dart';
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
  List<OrderItem> _orders = [];

  Future<void> fetchAndSetOrders() async {
    _orders.clear();
    final url = Uri.https(urlDomain, '/orders.json');
    try {
      final response = await http.get(url);
      print("Orders fetched");
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      final List<OrderItem> loadedOrders = [];
      // print(extractedData);
      if (extractedData == null) {
        return;
      }

      extractedData.forEach((orderId, data) {
        loadedOrders.add(OrderItem(
          id: orderId,
          amount: data['amount'],
          dateTime: DateTime.parse(data['dateTime']),
          products: (data['products']).map<CartItem>((item) {
            return CartItem(
                product: Product(
                    id: item['product']['id'],
                    title: item['product']['title'],
                    description: item['product']['description'],
                    imageURL: item['product']['imageURL'],
                    price: item['product']['price']),
                quantity: item['quantity']);
          }).toList(),
        ));
      });
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
      print("Orders Set");
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  List<OrderItem> get orders {
    return _orders;
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.https(urlDomain, '/orders.json');
    final timestamp = DateTime.now();
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
            'dateTime': timestamp.toIso8601String(),
          }));

      _orders.insert(
          0,
          OrderItem(
              id: json.decode(response.body)['name'],
              amount: total,
              products: cartProducts,
              dateTime: timestamp));

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

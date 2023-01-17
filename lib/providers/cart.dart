import 'package:flutter/cupertino.dart';
import 'package:shop_app/providers/product.dart';

class CartItem {
  Product product;
  int quantity;
  CartItem({required this.product, required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (existingCartItem) => CartItem(
                product: existingCartItem.product,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          product.id, () => CartItem(product: product, quantity: 1));
    }

    notifyListeners();
  }

  int get itemsLength {
    return _items.length;
  }

  double get getTotalAmount {
    double totalAmount = 0.0;
    _items.forEach((key, item) {
      totalAmount = totalAmount + item.quantity * item.product.price;
    });

    return totalAmount;
  }

  void removeItem(String prodID) {
    _items.remove(prodID);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}

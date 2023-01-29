import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';
import '../utils.dart';
import 'product.dart';

class Products with ChangeNotifier {
  final String? authToken;
  Products(this.authToken, this._items);

  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageURL:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageURL:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageURL:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageURL:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  Future<void> fetchAndSetProducts() async {
    _items.clear();
    final url = Uri.https(urlDomain, '/products.json', {'auth': '$authToken'});
    try {
      final response = await http.get(url);
      print("Product fetched");
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      final List<Product> loadedProducts = [];
      if (extractedData == null) {
        return;
      }

      extractedData.forEach((prodId, data) {
        loadedProducts.add(Product(
            id: prodId,
            title: data['title'],
            description: data['description'],
            imageURL: data['imageURL'],
            price: data['price'],
            isFavorite: data['isFavorite']));
      });
      _items = loadedProducts;
      notifyListeners();
      print("Product Set");
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favItems {
    return [..._items].where((prod) => prod.isFavorite).toList();
  }

  getById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> addProduct(Product newProduct) async {
    final url = Uri.https(urlDomain, '/products.json');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageURL': newProduct.imageURL,
            'price': newProduct.price,
            'isFavorite': newProduct.isFavorite,
          }));

      newProduct = newProduct.copyWith(id: json.decode(response.body)['name']);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> updateProduct(Product newProduct) async {
    final prodIndex =
        _items.indexWhere((element) => element.id == newProduct.id);

    final url = Uri.https(urlDomain, '/products/${newProduct.id}.json');

    try {
      final response = await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageURL': newProduct.imageURL,
            'price': newProduct.price,
            'isFavorite': newProduct.isFavorite,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();

      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.https(urlDomain, '/products/$id.json');
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException("Unable to delete product");
    }
    existingProduct = null;
  }
}

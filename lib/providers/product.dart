import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageURL;
  final double price;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageURL,
      required this.price,
      this.isFavorite = false});

  void _setFavValue(bool status) {
    isFavorite = status;
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    try {
      final url = Uri.https(urlDomain, '/products/$id.json');
      print("Changing Fav Status");
      final response =
          await http.patch(url, body: json.encode({'isFavorite': isFavorite}));
      print("Fav Status Set");
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (e) {
      _setFavValue(oldStatus);
    }
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageURL,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageURL: imageURL ?? this.imageURL,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

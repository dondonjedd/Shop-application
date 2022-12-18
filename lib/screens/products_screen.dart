import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

enum FilterOptions { favorites, all }

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var _showFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop App"),
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              onSelected: (FilterOptions val) {
                if (val == FilterOptions.favorites) {
                  setState(() {
                    _showFavorites = true;
                  });
                } else {
                  setState(() {
                    _showFavorites = false;
                  });
                }
              },
              itemBuilder: (_) {
                return [
                  const PopupMenuItem(
                    value: FilterOptions.favorites,
                    child: Text("Show Favorites"),
                  ),
                  const PopupMenuItem(
                    value: FilterOptions.all,
                    child: Text("Show All"),
                  )
                ];
              })
        ],
      ),
      body: ProductsGrid(showFavorites: _showFavorites),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/prov_products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum FilterOptions { favorites, all }

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var _showFavorites = false;
  var _isInit = false;
  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_isInit) {
      _isLoading = true;
      Provider.of<Products>(context).fetchAndSetProducts().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
      _isInit = true;
    }
    super.didChangeDependencies();
  }

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
                  ),
                ];
              }),
          Consumer<Cart>(
            builder: (_, cart, ch) =>
                BadgeCart(value: cart.itemsLength.toString(), child: ch!),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(showFavorites: _showFavorites),
    );
  }
}

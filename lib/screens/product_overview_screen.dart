import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../screens/cart_screen.dart';
import '../providers/cart.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';

enum FilterOptions{
  Favorits,
  All,
}
class ProductOverviewScreen extends StatefulWidget {

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(appBar: AppBar(
      title: const Text('My Shop'),
      actions: <Widget>[
        PopupMenuButton(
          onSelected: (FilterOptions selectedValue) {
            setState(() {
              if(selectedValue == FilterOptions.Favorits){
                _showOnlyFavorites = true;
              }
              else{
                _showOnlyFavorites = false;
              }
            });

          },
          itemBuilder: (_) => [
            PopupMenuItem(child: Text('Only Favorites'), value: FilterOptions.Favorits,),
            PopupMenuItem(child: Text('Show All'), value: FilterOptions.All,)
          ],
        icon: Icon(Icons.more_vert),
        ),
        Consumer<Cart>(
          builder: (_, cartData,ch) => Badgee(
          value: cart.itemCount.toString(),
          child: ch as Widget,
          ),
          child:IconButton(
          icon: Icon(Icons.shopping_cart,),
          onPressed: () {
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },
        ),
        ),
      ],
    ),
    drawer: AppDrawer(),
    body: ProductsGrid(_showOnlyFavorites),
    );
  }
}

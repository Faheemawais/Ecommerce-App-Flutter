import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../screens/cart_screen.dart';
import '../providers/cart.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/products_provider.dart';

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
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if(_isInit){
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(appBar: AppBar(
      title: const Text('Buy&Bye'),
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
            const PopupMenuItem(value: FilterOptions.Favorits,child: Text('Only Favorites'),),
            const PopupMenuItem(value: FilterOptions.All,child: Text('Show All'),)
          ],
        icon: const Icon(Icons.more_vert),
        ),
        Consumer<Cart>(
          builder: (_, cartData,ch) => Badgee(
          value: cart.itemCount.toString(),
          child: ch as Widget,
          ),
          child:IconButton(
          icon: const Icon(Icons.shopping_cart,),
          onPressed: () {
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },
        ),
        ),
      ],
    ),
    drawer: AppDrawer(),
    body: _isLoading ? Center(child: CircularProgressIndicator(),) : ProductsGrid(_showOnlyFavorites),
    );
  }
}

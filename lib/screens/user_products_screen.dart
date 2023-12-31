import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';

import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';
import '../screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false).fetchAndSetProducts(true);
  }

  

  @override
  Widget build(BuildContext context) {
    //final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: 'p12');
          }, icon: const Icon(Icons.add),),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder:(ctx, snapShot) => snapShot.connectionState == ConnectionState.waiting
          ? const Center(child: CircularProgressIndicator(),)
        : RefreshIndicator(
          onRefresh: () => _refreshProducts(context),
          child: Consumer<ProductsProvider>(
            builder:(ctx, productsData, _) => Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                  itemCount: productsData.items.length,
                  itemBuilder: (_, i) => Column(
                    children: <Widget>[
                      UserProductItem(productsData.items[i].id, productsData.items[i].title, productsData.items[i].imageUrl,),
                      const Divider(),
                    ],
                  ),),
            ),
          ),
        ),
      ),
    );
  }
}

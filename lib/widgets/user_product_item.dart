import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id,);
            }, icon: const Icon(Icons.edit), color: Theme.of(context).colorScheme.primary,),
            IconButton(
              onPressed: () async {
                Provider.of<ProductsProvider>(context, listen: false)
                    .deleteProduct(id)
                    .then((statusCode) {
                  if (statusCode >= 400) {
                    scaffold.showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Deleting Failed", textAlign: TextAlign.center,),
                      ),
                    );
                  }
                  else{
                    scaffold.showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Successfully Deleted", textAlign: TextAlign.center,),
                      ),
                    );
                  }
                });
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}

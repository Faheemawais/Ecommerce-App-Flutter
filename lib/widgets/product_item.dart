import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    return GridTile(child: Image.network(product.imageUrl, fit: BoxFit.cover,
    ),
      footer: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routName, arguments: product.id,);
          },
          child: GridTileBar(
            leading: IconButton(
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border,),
              color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
                product.toggleFavorite();
            },
            ),
            backgroundColor: Colors.black87,
            title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart' as ci;

class CartScreen extends StatelessWidget {
  static const routeName  = '/Cart';

  @override
  Widget build(BuildContext context) {
    final cart  = Provider.of<Cart>(context);
    return Scaffold(appBar: AppBar(
      title: const Text('Your Cart'),
    ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Total', style: TextStyle(fontSize: 20),),
                  const Spacer(),
                  Chip(label: Text('\$${cart.totalAmount}', style: const TextStyle(color: Colors.white,),),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  TextButton(onPressed: () {}, child: const Text('ORDER NOW'),)
                ],
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => ci.CartItem(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].title),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/orders.dart';
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
                  Chip(label: Text('\$${cart.totalAmount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white,),),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  OrderButton(cart: cart),
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

class OrderButton extends StatefulWidget {
  final Cart cart;
  const OrderButton({
    Key? key, required this.cart,
  }) : super(key: key);

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: _isLoading || widget.cart.totalAmount <= 0 ? null : () async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).addOrder( widget.cart.items.values.toList(),  widget.cart.totalAmount);
      setState(() {
        _isLoading = false;
      });
      widget.cart.clear();
    },
      child: _isLoading ? const CircularProgressIndicator() : const Text('ORDER NOW'),);
  }
}


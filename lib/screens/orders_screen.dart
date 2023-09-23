import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    //final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if(dataSnapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(dataSnapshot.error != null){
            return const Center(
              child: Text('An Error occurred!'),
            );
          }
          else{
            return Consumer<Orders>(
              builder: (ctx, orderData, child) =>  ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (ctx, i) {
                return OrderItem1(orderData.orders[i]);
              },
            ),
            );
          }
        },
      ),);
  }
}

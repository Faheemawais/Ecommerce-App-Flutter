import 'package:flutter/material.dart';

import 'dart:math';
import 'package:intl/intl.dart';

import '../providers/orders.dart';

class OrderItem1 extends StatefulWidget {
  final OrderItem orderItem;

  OrderItem1(this.orderItem);

  @override
  State<OrderItem1> createState() => _OrderItem1State();
}

class _OrderItem1State extends State<OrderItem1> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.orderItem.amount}'),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.orderItem.dateTime),),
            trailing: IconButton(icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more), onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            ),
          ),
          if(_expanded) Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            height: min(widget.orderItem.products.length * 20 + 10, 100),
          child: ListView(children: widget.orderItem.products.map((e) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(e.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text('${e.quantity}x \$${e.price}', style: TextStyle(fontSize: 18, color: Colors.grey),)
            ],
          )).toList(),),
          ),
         ],
      ),
    );
  }
}

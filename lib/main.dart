import 'package:flutter/material.dart';

import './providers/products_provider.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      theme: ThemeData(

        colorScheme: ThemeData.light().colorScheme.copyWith(
      primary: Colors.purple,
      secondary: Colors.deepOrange,// Accent color
    ),
    canvasColor: Color.fromRGBO(225, 254, 229, 1),
    fontFamily: 'Lato',
    textTheme: ThemeData.light().textTheme.copyWith(
    bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
    bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
    headline1: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Raleway'),
    headline2: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'RobontoCondensed'),
    headline3: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'RobontoCondensed'),
    headline4: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'RobontoCondensed'),
    headline5: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Raleway', color: Colors.white ),
    headline6: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'RobontoCondensed'),
    subtitle1: TextStyle(fontSize: 16),
    subtitle2: TextStyle(fontSize: 14),
    caption: TextStyle(fontSize: 12),
    button: TextStyle(fontSize: 14),
    overline: TextStyle(fontSize: 10),
    ),
        ),
      home: ProductOverviewScreen(),
      routes: {
        ProductDetailScreen.routName: (ctx) => ProductDetailScreen(),
      },
    );
  }
}

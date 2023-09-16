import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import './providers/cart.dart';
import './screens/orders_screen.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './providers/products_provider.dart';
import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/user_products_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
        ChangeNotifierProvider.value(
        value: ProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ChangeNotifierProvider.value(
        value: Orders(),
      ),
    ],
      child: MaterialApp(
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
          headline1: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Lato'),
          headline2: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Anton'),
          headline3: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Anton'),
          headline4: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Anton'),
          headline5: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Lato', color: Colors.white ),
          headline6: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Anton'),
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
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
        },
      ),
    );
  }
}

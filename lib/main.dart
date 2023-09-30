import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/splash_screen.dart';
import './providers/auth.dart';
import './screens/edit_product_screen.dart';
import './providers/cart.dart';
import './screens/orders_screen.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './providers/products_provider.dart';
import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/user_products_screen.dart';
import './screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(
        value: Auth(),
      ),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(update: (ctx, auth, previousProducts) => ProductsProvider(
          auth.token,
          auth.userId,
          previousProducts == null ? [] : previousProducts.items,
        ), create: (_) => ProductsProvider(null, null, []),
      ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ChangeNotifierProxyProvider<Auth, Orders>(update: (ctx, auth, previousOrders) => Orders(
        auth.token,
        auth.userId,
        previousOrders == null ? [] : previousOrders.orders,
      ), create: (_) => Orders(null, null, []),
      ),
    ],
      child: Consumer<Auth>(builder: (ctx, auth, _) => MaterialApp(
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
          headline1: TextStyle(fontSize: 20, fontFamily: 'Lato'),
          headline2: TextStyle(fontSize: 18,  fontFamily: 'Anton'),
          headline3: TextStyle(fontSize: 16,  fontFamily: 'Anton'),
          headline4: TextStyle(fontSize: 16,  fontFamily: 'Anton'),
          headline5: TextStyle(fontSize: 22,  fontFamily: 'Lato', color: Colors.white ),
          headline6: TextStyle(fontSize: 14,  fontFamily: 'Anton'),
          subtitle1: TextStyle(fontSize: 16),
          subtitle2: TextStyle(fontSize: 14),
          caption: TextStyle(fontSize: 12),
          button: TextStyle(fontSize: 14),
          overline: TextStyle(fontSize: 10),
          ),
        ),
        home: auth.isAuth ? ProductOverviewScreen() : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting ? SplashScreen() : AuthScreen(),
        ),
        routes: {
          ProductDetailScreen.routName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
      ),
    );
  }
}

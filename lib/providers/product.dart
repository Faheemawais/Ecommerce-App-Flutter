import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;


  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
});

  Future<void> toggleFavorite() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.parse('https://shop-app-df8dc-default-rtdb.firebaseio.com/products/$id.json');
    try {
      await http.patch(url, body: json.encode({
        'isFavorite': isFavorite,
      }));
    }
    catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
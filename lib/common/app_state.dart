import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  int cartCounter = 0;

  // Cart data list
  int get getCart => cartCounter;

  // Add item to cart
  updateCart(int value) {
    cartCounter = value;
    notifyListeners();
  }

}
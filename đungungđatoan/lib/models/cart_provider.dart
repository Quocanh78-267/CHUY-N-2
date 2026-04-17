import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void add() {
    _count++;
    notifyListeners();
  }

  void remove() {
    if (_count > 0) {
      _count--;
      notifyListeners();
    }
  }
}
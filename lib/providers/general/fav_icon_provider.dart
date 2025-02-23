import 'package:flutter/material.dart';

class FavIconProvider extends ChangeNotifier {
  bool _isFav = false;
  bool get isFav => _isFav;
  
  void setIsFav(bool value) {
    _isFav = value;
    notifyListeners();
  }
}
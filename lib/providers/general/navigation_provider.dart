import 'package:flutter/widgets.dart';

class NavigationProvider extends ChangeNotifier{
  int _navIndex = 0;

  int get navIndex => _navIndex;

  void setNavIndex(int value) {
    _navIndex = value;
    notifyListeners();
  }
}
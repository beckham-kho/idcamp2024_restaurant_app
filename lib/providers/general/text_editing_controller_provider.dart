import 'package:flutter/material.dart';

class TextEditingControllerProvider extends ChangeNotifier {
  TextEditingController _searchController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _reviewController = TextEditingController();

  TextEditingController get searchController => _searchController;
  TextEditingController get nameController => _nameController;
  TextEditingController get reviewController => _reviewController;

  void setSearchController(String text) {
    _searchController.text = text;
    notifyListeners();
  }

  void setNameController(String text) {
    _searchController.text = text;
    notifyListeners();
  }

  void setReviewController(String text) {
    _searchController.text = text;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/general/restaurant.dart';
import 'package:restaurant_app/services/sqlite_service.dart';

class DatabaseProvider extends ChangeNotifier {
  final SqliteService _service;

  DatabaseProvider(this._service);

  String _message = "";
  String get message => _message;

  List<Restaurant>? _restaurantList;
  List<Restaurant>? get restaurantList => _restaurantList;

  Restaurant? _restaurant;
  Restaurant? get restaurant => _restaurant;

  Future<void> readAllFavRestaurantValue() async {
    try {
      _restaurantList = await _service.readAllFavRestaurants();
      _message = "Semua data restoran favorit berhasil dimuat";
      notifyListeners();
    } catch(e) {
      _message = "Gagal memuat seluruh data restoran favorit :(";
      notifyListeners();
    }
  }

  Future<void> readFavRestaurantByIdValue(String id, String name) async {
    try {
      _restaurant = await _service.readFavRestaurantsById(id);
      _message = "Data restoran $name berhasil dimuat";
      notifyListeners();
    } catch(e) {
      _message = "Gagal memuat data restoran $name :(";
      notifyListeners();
    }
  }

  Future<void> createFavRestaurantValue(Restaurant value) async {
    try {
      final result = await _service.createFavRestaurant(value);
      final isError = result == 0;

      if(isError) {
        _message = 'Gagal menyimpan data restoran "${value.name}" :(';
        notifyListeners();
      } else {
        _message = 'Berhasil menyimpan data restoran "${value.name}"';
        notifyListeners();
      }
    } catch(e) {
      _message = 'Gagal menyimpan data restoran "${value.name}" :(';
      notifyListeners();
    }
  }

  Future<void> deleteFavRestaurantValueById(String id, String name) async {
    try {
      await _service.deleteFavRestaurant(id);
      _message = 'Data restoran "$name" berhasil dihapus';
      notifyListeners();
    } catch(e) {
      _message = 'Gagal menghapus data restoran "$name" :(';
      notifyListeners();
    }
  }
}
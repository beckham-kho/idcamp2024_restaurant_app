import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/search_resto_result_state.dart';

class SearchRestoProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  SearchRestoProvider(this._apiServices);

  SearchRestoResultState _resultState = SearchRestoNoneState();

  SearchRestoResultState get resultState => _resultState;

  Future<void> fetchSearchResto(String query) async {
    try {
      _resultState = SearchRestoLoadingState();
      notifyListeners();

      final result = await _apiServices.searchResto(query);

      if (result.error) {
        _resultState =
            SearchRestoErrorState("Failed to load restaurant detail :(");
        notifyListeners();
      } else if (result.founded == 0) {
        _resultState =
            SearchRestoErrorState("Kata kunci '$query' tidak ditemukan.");
        notifyListeners();
      } else {
        _resultState = SearchRestoLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (_) {
      _resultState =
          SearchRestoErrorState("Terjadi kesalahan. Silakan coba lagi :(");
      notifyListeners();
    }
  }
}

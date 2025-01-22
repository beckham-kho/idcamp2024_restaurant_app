import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/resto_list_result_state.dart';

class RestoListProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestoListProvider(
    this._apiServices
  );

  RestoListResultState _resultState = RestoListNoneState();

  RestoListResultState get resultState => _resultState;

  Future<void> fetchRestoList() async {
    try {
      _resultState = RestoListLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestoList();

      if(result.error) {
        _resultState = RestoListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestoListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch(e) {
      _resultState = RestoListErrorState(e.toString());
      notifyListeners();
    }
  }
}
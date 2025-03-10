import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/resto_detail_result_state.dart';

class RestoDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestoDetailProvider(this._apiServices);

  RestoDetailResultState _resultState = RestoDetailNoneState();

  RestoDetailResultState get resultState => _resultState;

  Future<void> fetchRestoDetail(String id) async {
    try {
      _resultState = RestoDetailLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestoDetail(id);

      if (result.error) {
        _resultState = RestoDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestoDetailLoadedState(result.restaurantDetail);
        notifyListeners();
      }
    } on Exception catch (_) {
      _resultState = RestoDetailErrorState(
        "Terjadi kesalahan. Silakan coba lagi :(",
      );
      notifyListeners();
    }
  }
}

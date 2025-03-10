import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/post_rating_result_state.dart';

class PostRatingProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  PostRatingProvider(this._apiServices);

  PostRatingResultState _resultState = PostRatingNoneState();

  PostRatingResultState get resultState => _resultState;

  void setResultState(PostRatingResultState resultState) {
    _resultState = resultState;
    notifyListeners();
  }

  Future<void> postRating(String id, String name, String review) async {
    try {
      _resultState = PostRatingLoadingState();
      notifyListeners();

      final result = await _apiServices.postReview(id, name, review);

      if (result.error) {
        _resultState = PostRatingErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = PostRatingSuccessState();
        notifyListeners();
      }
    } on Exception catch (_) {
      _resultState = PostRatingErrorState(
        "Terjadi kesalahan. Silakan coba lagi :(",
      );
      notifyListeners();
    }
  }
}

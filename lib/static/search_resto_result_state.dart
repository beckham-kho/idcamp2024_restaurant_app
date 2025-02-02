import 'package:restaurant_app/data/model/general/restaurant.dart';

sealed class SearchRestoResultState {}

class SearchRestoNoneState extends SearchRestoResultState {}

class SearchRestoLoadingState extends SearchRestoResultState {}

class SearchRestoErrorState extends SearchRestoResultState {
  final String error;
  
  SearchRestoErrorState(this.error);
}

class SearchRestoLoadedState extends SearchRestoResultState {
  final List<Restaurant> data;

  SearchRestoLoadedState(this.data);
}
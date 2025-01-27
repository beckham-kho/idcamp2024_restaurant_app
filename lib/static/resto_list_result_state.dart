import 'package:restaurant_app/data/model/general/restaurant.dart';

sealed class RestoListResultState {}

class RestoListNoneState extends RestoListResultState {}

class RestoListLoadingState extends RestoListResultState {}

class RestoListErrorState extends RestoListResultState {
  final String error;
  
  RestoListErrorState(this.error);
}

class RestoListLoadedState extends RestoListResultState {
  final List<Restaurant> data;

  RestoListLoadedState(this.data);
}
import 'package:restaurant_app/data/model/detail/resto_detail_response.dart';

sealed class RestoDetailResultState {}

class RestoDetailNoneState extends RestoDetailResultState {}

class RestoDetailLoadingState extends RestoDetailResultState {}

class RestoDetailErrorState extends RestoDetailResultState {
  final String error;
  
  RestoDetailErrorState(this.error);
}

class RestoDetailLoadedState extends RestoDetailResultState {
  final RestaurantDetail data;

  RestoDetailLoadedState(this.data);
}
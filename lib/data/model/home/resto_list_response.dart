import 'package:restaurant_app/data/model/general/restaurant.dart';

class RestoListResponse {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  RestoListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestoListResponse.fromJson(Map<String, dynamic> json) =>
      RestoListResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

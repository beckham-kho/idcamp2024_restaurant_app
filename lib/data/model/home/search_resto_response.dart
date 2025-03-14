import 'package:restaurant_app/data/model/general/restaurant.dart';

class SearchRestoResponse {
  bool error;
  int founded;
  List<Restaurant> restaurants;

  SearchRestoResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestoResponse.fromJson(Map<String, dynamic> json) =>
      SearchRestoResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
          json["restaurants"].map((x) => Restaurant.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

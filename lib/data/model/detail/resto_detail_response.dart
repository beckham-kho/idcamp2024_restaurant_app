import 'package:restaurant_app/data/model/detail/category.dart';
import 'package:restaurant_app/data/model/detail/customer_review.dart';
import 'package:restaurant_app/data/model/detail/resto_menu.dart';
import 'package:restaurant_app/data/model/general/restaurant.dart';

class RestoDetailResponse {
  bool error;
  String message;
  RestaurantDetail restaurantDetail;

  RestoDetailResponse({
      required this.error,
      required this.message,
      required this.restaurantDetail,
  });

  factory RestoDetailResponse.fromJson(Map<String, dynamic> json) => RestoDetailResponse(
      error: json["error"],
      message: json["message"],
      restaurantDetail: RestaurantDetail.fromJson(json["restaurant"]),
  );

  Map<String, dynamic> toJson() => {
      "error": error,
      "message": message,
      "restaurant": restaurantDetail.toJson(),
  };
}

class RestaurantDetail extends Restaurant {
  String address;
  List<Category> categories;
  Menus menus;
  List<CustomerReview> customerReviews;

  RestaurantDetail({
    required super.id,
    required super.name,
    required super.description,
    required super.city,
    required super.pictureId,
    required super.rating,
    required this.address,
    required this.categories,
    required this.menus,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) => RestaurantDetail(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      city: json["city"],
      address: json["address"],
      pictureId: json["pictureId"],
      categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
      menus: Menus.fromJson(json["menus"]),
      rating: json["rating"]?.toDouble(),
      customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
  );

Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "city": city,
    "address": address,
    "pictureId": pictureId,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "menus": menus.toJson(),
    "rating": rating,
    "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
  };
}
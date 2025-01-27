import 'package:restaurant_app/data/model/detail/category.dart';

class CustomerReview {
  String name;
  String review;
  String date;

  CustomerReview({
      required this.name,
      required this.review,
      required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
      name: json["name"],
      review: json["review"],
      date: json["date"],
  );

  Map<String, dynamic> toJson() => {
      "name": name,
      "review": review,
      "date": date,
  };
}

class Menus {
  List<Category> foods;
  List<Category> drinks;

  Menus({
      required this.foods,
      required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
      foods: List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
      drinks: List<Category>.from(json["drinks"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
      "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
      "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
  };
}
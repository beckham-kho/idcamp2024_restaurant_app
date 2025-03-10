import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/detail/resto_detail_response.dart';
import 'package:restaurant_app/data/model/general/restaurant.dart';
import 'package:restaurant_app/providers/services/database_provider.dart';

class RestaurantFavButton extends StatelessWidget {
  const RestaurantFavButton({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final convertedRestaurant = Restaurant(
          id: restaurant.id,
          name: restaurant.name,
          description: restaurant.description,
          pictureId: restaurant.pictureId,
          city: restaurant.city,
          rating: restaurant.rating,
        );

        final databaseProvider = context.read<DatabaseProvider>();
        final isFav = await databaseProvider.isFavRestaurant(restaurant.id);

        if (!isFav) {
          await databaseProvider.createFavRestaurantValue(
            restaurant is RestaurantDetail ? convertedRestaurant : restaurant,
          );
        } else {
          await databaseProvider.deleteFavRestaurantValueById(
            restaurant.id,
            restaurant.name,
          );
        }
        databaseProvider.readAllFavRestaurantValue();
      },
      icon: Icon(
        context.watch<DatabaseProvider>().isFavRestaurant(restaurant.id)
            ? Icons.favorite_rounded
            : Icons.favorite_outline_rounded,
        color: Colors.red,
        size: 30,
      ),
    );
  }
}

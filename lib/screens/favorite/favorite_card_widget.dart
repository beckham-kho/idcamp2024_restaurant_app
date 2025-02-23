import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/general/restaurant.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  final Restaurant restaurant;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: .5),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Image.network(
                width: 120,
                height: 68,
                "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(restaurant.name),
                Text(restaurant.city),
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Colors.yellow,
                      size: 18,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      restaurant.rating.toString(),
                      style: Theme.of(context)
                        .textTheme
                        .titleMedium
                    ),
                  ],
                )
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {}, 
              icon: Icon(
                Icons.favorite_rounded,
                size: 30,
                color: Colors.red,
              ),
            ),
          ],
        )
      ),
    );
  }
}
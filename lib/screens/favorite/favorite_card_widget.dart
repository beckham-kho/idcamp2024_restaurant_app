import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/general/restaurant.dart';
import 'package:restaurant_app/providers/services/database_provider.dart';
import 'package:restaurant_app/screens/widgets/restaurant_fav_button_widget.dart';

class FavoriteCard extends StatefulWidget {
  const FavoriteCard({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  final Restaurant restaurant;
  final Function() onTap;

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DatabaseProvider>().readAllFavRestaurantValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.outline, width: .5),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: Image.network(
                  width: 120,
                  height: 68,
                  "https://restaurant-api.dicoding.dev/images/small/${widget.restaurant.pictureId}",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.restaurant.name),
                  Text(widget.restaurant.city),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      const SizedBox(width: 2),
                      Text(widget.restaurant.rating.toString(),
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  )
                ],
              ),
              Spacer(),
              RestaurantFavButton(restaurant: widget.restaurant),
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/general/restaurant.dart';
import 'package:restaurant_app/providers/general/fav_icon_provider.dart';
import 'package:restaurant_app/providers/services/database_provider.dart';

class RestoCard extends StatefulWidget {
  final Restaurant restaurant;
  final Function() onTap;

  const RestoCard({super.key, required this.restaurant, required this.onTap});

  @override
  State<RestoCard> createState() => _RestoCardState();
}

class _RestoCardState extends State<RestoCard> {
  @override
  void initState() {
    final databaseProvider = context.read<DatabaseProvider>();
    final favIconProvider = context.read<FavIconProvider>();
    
    Future.microtask(() async {
      await databaseProvider.readFavRestaurantByIdValue(widget.restaurant.id, widget.restaurant.name);
      final value = databaseProvider.restaurant == null ? false : databaseProvider.restaurant!.id == widget.restaurant.id;
      
      favIconProvider.setIsFav(value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Hero(
                  tag: 'restaurant-image-${widget.restaurant.pictureId}',
                  child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/small/${widget.restaurant.pictureId}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color.fromRGBO(0, 0, 0, 1),
                        Color.fromRGBO(0, 0, 0, 0.7),
                        Color.fromRGBO(0, 0, 0, 0),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.restaurant.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            Text(
                              widget.restaurant.city,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Colors.yellow,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              widget.restaurant.rating.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.8),
                          Color.fromRGBO(0, 0, 0, 0),
                          Color.fromRGBO(0, 0, 0, 0),
                        ],
                      ),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        final databaseProvider = context.read<DatabaseProvider>();
                        final favIconProvider = context.read<FavIconProvider>();
                        final isFav = favIconProvider.isFav;

                        if (!isFav) {
                          await databaseProvider.createFavRestaurantValue(widget.restaurant);
                        } else {
                          await databaseProvider.deleteFavRestaurantValueById(widget.restaurant.id, widget.restaurant.name);
                        }
                        favIconProvider.setIsFav(!isFav);
                        databaseProvider.readAllFavRestaurantValue();
                      },
                      icon: Icon(
                        context.watch<FavIconProvider>().isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

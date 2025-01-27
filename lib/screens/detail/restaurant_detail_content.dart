import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail/resto_detail_response.dart';
import 'package:restaurant_app/static/navigation_route.dart';

class RestaurantDetailContent extends StatelessWidget {
  const RestaurantDetailContent({
    super.key,
    required this.restaurantDetail,
  });

  final RestaurantDetail restaurantDetail;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurantDetail.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${restaurantDetail.city},",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              restaurantDetail.address,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context, 
                                NavigationRoute.ratingRoute.name,
                                arguments: restaurantDetail.id,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: Colors.yellow,
                                    size: 30,
                                  ),
                                  Text(
                                    "${restaurantDetail.rating.toString()} (${restaurantDetail.customerReviews.length.toString()})" ,
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.onPrimary
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Text(", ");
                        },
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Text(
                            restaurantDetail.categories[index].name,
                            style: Theme.of(context).textTheme.bodyMedium,
                          );
                        },
                        itemCount: restaurantDetail.categories.length,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Deskripsi",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      restaurantDetail.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Menu",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Makanan",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            ...restaurantDetail.menus.foods.map((food) => Text(
                              food.name,
                            )),
                          ],
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Minuman",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            ...restaurantDetail.menus.drinks.map((drink) => Text(
                              drink.name,
                            )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]
        );
      }
    );
  }
}
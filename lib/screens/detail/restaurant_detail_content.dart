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
    return Builder(builder: (context) {
      return CustomScrollView(slivers: [
        SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
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
                          padding: const EdgeInsets.all(7),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      color: Colors.yellow,
                                      size: 30,
                                    ),
                                    Text(
                                      "${restaurantDetail.rating.toString()} (${restaurantDetail.customerReviews.length.toString()})",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "Cek Ulasan",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                Text(
                  "Menu",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  "Makanan",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Text(
                          restaurantDetail.menus.foods[index].name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 5);
                    },
                    itemCount: restaurantDetail.menus.foods.length,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Minuman",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Text(
                          restaurantDetail.menus.drinks[index].name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 5);
                    },
                    itemCount: restaurantDetail.menus.drinks.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]);
    });
  }
}

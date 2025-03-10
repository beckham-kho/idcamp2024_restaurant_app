import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/detail/resto_detail_response.dart';
import 'package:restaurant_app/providers/services/database_provider.dart';
import 'package:restaurant_app/screens/detail/restaurant_detail_content.dart';
import 'package:restaurant_app/screens/widgets/restaurant_fav_button_widget.dart';

class RestaurantDetailBody extends StatefulWidget {
  final RestaurantDetail restaurantDetail;
  const RestaurantDetailBody({super.key, required this.restaurantDetail});

  @override
  State<RestaurantDetailBody> createState() => _RestaurantDetailBodyState();
}

class _RestaurantDetailBodyState extends State<RestaurantDetailBody> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DatabaseProvider>().readAllFavRestaurantValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                iconTheme: IconThemeData(
                  size: 30,
                  shadows: [
                    Shadow(
                      blurRadius: 15,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ],
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                actions: [
                  RestaurantFavButton(restaurant: widget.restaurantDetail),
                ],
                expandedHeight: 200,
                pinned: true,
                floating: false,
                snap: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag:
                        'restaurant-image-${widget.restaurantDetail.pictureId}',
                    child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/small/${widget.restaurantDetail.pictureId}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: RestaurantDetailContent(
          restaurantDetail: widget.restaurantDetail,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail/resto_detail_response.dart';
import 'package:restaurant_app/screens/detail/restaurant_detail_content.dart';

class RestaurantDetailBody extends StatelessWidget {
  final RestaurantDetail restaurantDetail;
  const RestaurantDetailBody({
    super.key,
    required this.restaurantDetail,
  });

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
                  shadows: [
                    Shadow(
                      blurRadius: 15,
                      color: Colors.black,
                      offset: Offset(0, 0)
                    )
                  ],
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                expandedHeight: 200,
                pinned: true,
                floating: false,
                snap: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'restaurant-image-${restaurantDetail.pictureId}',
                    child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/small/${restaurantDetail.pictureId}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: RestaurantDetailContent(restaurantDetail: restaurantDetail),
      ),
    );
  }
}

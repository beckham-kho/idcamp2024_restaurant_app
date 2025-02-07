import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail/resto_detail_response.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/screens/rating/rating_input_dialog.dart';

class RatingScreenBody extends StatefulWidget {
  final RestaurantDetail restaurantDetail;

  const RatingScreenBody({super.key, required this.restaurantDetail});

  @override
  State<RatingScreenBody> createState() => _RatingScreenBodyState();
}

class _RatingScreenBodyState extends State<RatingScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.restaurantDetail.name),
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).colorScheme.primary,
            label: Text(
              "Tambahkan ulasan",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
            icon: Icon(
              Icons.add_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return RatingInputDialog(
                      restaurantId: widget.restaurantDetail.id);
                },
              );
            }),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                          width: .5),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total rating: ${widget.restaurantDetail.rating.toString()} / 5 ",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "dari ${widget.restaurantDetail.customerReviews.length} ulasan",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      RatingBarIndicator(
                        rating: widget.restaurantDetail.rating,
                        itemBuilder: (context, index) => Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 30,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Apa kata mereka?",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 15),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 20);
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.outline,
                              width: .5),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                  width: .5,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.restaurantDetail.customerReviews[index]
                                      .name,
                                ),
                                Text(
                                  widget.restaurantDetail.customerReviews[index]
                                      .date,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget
                                .restaurantDetail.customerReviews[index].review,
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: widget.restaurantDetail.customerReviews.length,
                ),
              ],
            ),
          ),
        ));
  }
}

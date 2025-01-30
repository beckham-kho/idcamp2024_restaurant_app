import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/static/post_rating_result_state.dart';

import '../../providers/rating/post_rating_provider.dart';

class RatingInputDialog extends StatefulWidget {
  const RatingInputDialog({
    super.key,
    required TextEditingController nameController,
    required TextEditingController reviewController,
    required String restaurantId,
  }) : _restaurantId = restaurantId, _nameController = nameController, _reviewController = reviewController;

  final TextEditingController _nameController;
  final TextEditingController _reviewController;
  final String _restaurantId;

  @override
  State<RatingInputDialog> createState() => _RatingInputDialogState();
}

class _RatingInputDialogState extends State<RatingInputDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Berikan ratingmu!",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: widget._nameController,
              decoration: const InputDecoration(
                hintText: 'Masukan nama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: widget._reviewController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Masukan ulasan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )
              ),
            ),
            const SizedBox(height: 20),
            Consumer<PostRatingProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  PostRatingNoneState() => ElevatedButton(
                    onPressed: () {
                      setState(() {
                        context.read<PostRatingProvider>().postRating(widget._restaurantId, widget._nameController.text, widget._reviewController.text);
                        Future.delayed(
                          Duration(seconds: 3),
                          () => Navigator.pop(context),
                        );
                      });
                    },
                    child: Text("Kirim"),
                  ),
                  PostRatingLoadingState() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  PostRatingSuccessState() => Text("Ulasan terkirim!"),
                  PostRatingErrorState(error: var message) => Text(message),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
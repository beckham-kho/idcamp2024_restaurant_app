import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/general/text_editing_controller_provider.dart';
import 'package:restaurant_app/static/post_rating_result_state.dart';

import '../../providers/rating/post_rating_provider.dart';

class RatingInputDialog extends StatefulWidget {
  final TextEditingController _nameController;
  final TextEditingController _reviewController;
  final String _restaurantId;

  RatingInputDialog({super.key, required String restaurantId})
    : _restaurantId = restaurantId,
      _nameController = TextEditingController(),
      _reviewController = TextEditingController();

  @override
  State<RatingInputDialog> createState() => _RatingInputDialogState();
}

class _RatingInputDialogState extends State<RatingInputDialog> {
  final _reviewFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          height: MediaQuery.of(context).size.height * 0.6,
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
                itemBuilder:
                    (context, _) =>
                        Icon(Icons.star_rounded, color: Colors.amber),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const SizedBox(height: 20),
              Consumer<TextEditingControllerProvider>(
                builder: (context, value, child) {
                  return Form(
                    key: _reviewFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Nama anda tidak boleh kosong";
                            }
                            return null;
                          },
                          onChanged:
                              (value) => context
                                  .read<TextEditingControllerProvider>()
                                  .setNameController(value),
                          controller: widget._nameController,
                          decoration: const InputDecoration(
                            hintText: 'Masukan nama',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Ulasan tidak boleh kosong";
                            }
                            return null;
                          },
                          onChanged:
                              (value) => context
                                  .read<TextEditingControllerProvider>()
                                  .setReviewController(value),
                          controller: widget._reviewController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText: 'Masukan ulasan',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Consumer<PostRatingProvider>(
                          builder: (context, value, child) {
                            return switch (value.resultState) {
                              PostRatingNoneState() => ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                onPressed: () {
                                  if (_reviewFormKey.currentState!.validate()) {
                                    context
                                        .read<PostRatingProvider>()
                                        .postRating(
                                          widget._restaurantId,
                                          widget._nameController.text,
                                          widget._reviewController.text,
                                        );
                                    Future.delayed(Duration(seconds: 3), () {
                                      Navigator.pop(context);
                                      context
                                          .read<PostRatingProvider>()
                                          .setResultState(
                                            PostRatingNoneState(),
                                          );
                                      context
                                          .read<TextEditingControllerProvider>()
                                          .setNameController("");
                                      context
                                          .read<TextEditingControllerProvider>()
                                          .setNameController("");
                                    });
                                  }
                                },
                                child: Text(
                                  "Kirim",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                              PostRatingLoadingState() => Center(
                                child: Lottie.asset(
                                  "assets/animation/loading.json",
                                  repeat: true,
                                  height: 70,
                                  width: 70,
                                ),
                              ),
                              PostRatingSuccessState() => Text(
                                "Ulasan terkirim!",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              PostRatingErrorState(error: var message) => Text(
                                message,
                              ),
                            };
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

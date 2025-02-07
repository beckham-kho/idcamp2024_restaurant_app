import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/detail/resto_detail_provider.dart';
import 'package:restaurant_app/screens/rating/rating_screen_body.dart';
import 'package:restaurant_app/static/resto_detail_result_state.dart';

class RatingScreen extends StatefulWidget {
  final String restaurantId;
  const RatingScreen({super.key, required this.restaurantId});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestoDetailProvider>().fetchRestoDetail(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestoDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestoDetailLoadingState() => Center(
                child: Lottie.asset(
                  "assets/animation/loading.json",
                  repeat: true,
                  height: 200,
                  width: 200,
                ),
              ),
            RestoDetailLoadedState(data: var restaurant) =>
              RatingScreenBody(restaurantDetail: restaurant),
            RestoDetailErrorState(error: var message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/animation/error.json",
                      width: 200,
                      height: 200,
                      repeat: true,
                    ),
                    Text(message),
                  ],
                ),
              ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}

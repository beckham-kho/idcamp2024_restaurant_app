import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/detail/resto_detail_provider.dart';
import 'package:restaurant_app/screens/rating/rating_screen_body.dart';
import 'package:restaurant_app/static/resto_detail_result.dart';

class RatingScreen extends StatefulWidget {
  final String restaurantId;
  const RatingScreen({
    super.key,
    required this.restaurantId
  });

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
            RestoDetailLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestoDetailLoadedState(data: var restaurant) => RatingScreenBody(restaurantDetail: restaurant),
            RestoDetailErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
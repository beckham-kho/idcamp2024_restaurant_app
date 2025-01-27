import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/detail/resto_detail_provider.dart';
import 'package:restaurant_app/screens/detail/restaurant_detail_body.dart';
import 'package:restaurant_app/static/resto_detail_result.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;

  const DetailScreen({
    super.key,
    required this.restaurantId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
            RestoDetailLoadedState(data: var restaurant) => RestaurantDetailBody(restaurantDetail: restaurant),
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
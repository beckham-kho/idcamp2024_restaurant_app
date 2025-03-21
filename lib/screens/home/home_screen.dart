import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/general/text_editing_controller_provider.dart';
import 'package:restaurant_app/providers/home/resto_list_provider.dart';
import 'package:restaurant_app/providers/home/search_resto_provider.dart';
import 'package:restaurant_app/screens/home/resto_card_widget.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/resto_list_result_state.dart';
import 'package:restaurant_app/static/search_resto_result_state.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestoListProvider>().fetchRestoList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          "Daftar Restoran",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Consumer2<SearchRestoProvider,
                        TextEditingControllerProvider>(
                      builder: (
                        context,
                        searchFieldValue,
                        controllerValue,
                        child,
                      ) {
                        return TextField(
                          onChanged: (textValue) {
                            context
                                .read<SearchRestoProvider>()
                                .fetchSearchResto(textValue);
                            context
                                .read<TextEditingControllerProvider>()
                                .setSearchController(textValue);
                          },
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Cari Restoran...",
                            prefixIcon: Icon(Icons.search),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Consumer<TextEditingControllerProvider>(
              builder: (context, value, child) {
                return context
                        .watch<TextEditingControllerProvider>()
                        .searchController
                        .text
                        .isNotEmpty
                    ? Expanded(
                        child: Consumer<SearchRestoProvider>(
                          builder: (context, value, child) {
                            return switch (value.resultState) {
                              SearchRestoLoadingState() => Center(
                                  child: Lottie.asset(
                                    "assets/animation/loading.json",
                                    repeat: true,
                                    height: 200,
                                    width: 200,
                                  ),
                                ),
                              SearchRestoLoadedState(data: var restoList) =>
                                ListView.builder(
                                  itemCount: restoList.length,
                                  itemBuilder: (context, index) {
                                    final restaurant = restoList[index];

                                    return RestoCard(
                                      restaurant: restaurant,
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          NavigationRoute.detailRoute.name,
                                          arguments: restaurant.id,
                                        );
                                      },
                                    );
                                  },
                                ),
                              SearchRestoErrorState(error: var message) =>
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                      )
                    : Expanded(
                        child: Consumer<RestoListProvider>(
                          builder: (context, value, child) {
                            return switch (value.resultState) {
                              RestoListLoadingState() => Center(
                                  child: Lottie.asset(
                                    "assets/animation/loading.json",
                                    repeat: true,
                                    height: 200,
                                    width: 200,
                                  ),
                                ),
                              RestoListLoadedState(data: var restoList) =>
                                ListView.builder(
                                  itemCount: restoList.length,
                                  itemBuilder: (context, index) {
                                    final restaurant = restoList[index];

                                    return RestoCard(
                                      restaurant: restaurant,
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          NavigationRoute.detailRoute.name,
                                          arguments: restaurant.id,
                                        );
                                      },
                                    );
                                  },
                                ),
                              RestoListErrorState(error: var message) => Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
              },
            ),
          ],
        ),
      ),
    );
  }
}

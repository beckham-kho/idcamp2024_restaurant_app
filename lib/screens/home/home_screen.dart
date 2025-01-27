import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/home/resto_list_provider.dart';
import 'package:restaurant_app/screens/home/resto_card_widget.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/resto_list_result_state.dart';

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
          "Restaurant List",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.grey)
                    ),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Restaurant...",
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.grid_view_rounded),
                    color: Theme.of(context).colorScheme.primary,
                    iconSize: 28,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<RestoListProvider>(
                builder: (context, value, child) {
                  return switch (value.resultState) {
                    RestoListLoadingState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    RestoListLoadedState(data: var restoList) => ListView.builder(
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
                      child: Text(message),
                    ),
                    _ => const SizedBox(),
                  };
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
import 'dart:math';

import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/providers/home/resto_list_provider.dart';
import 'package:restaurant_app/static/app_workmanager.dart';
import 'package:restaurant_app/static/resto_list_result_state.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if(task == AppWorkmanager.periodic.taskName) {
      var restaurantNames = [];

      final apiServices = ApiServices();
      final restoListProvider = RestoListProvider(apiServices);
      await restoListProvider.fetchRestoList();
      final resultState = restoListProvider.resultState;

      if (resultState is RestoListLoadedState) {
        for (var restaurant in resultState.data) {
          restaurantNames.add(restaurant.name);
        }

      final randomRestaurantNameIndex = Random().nextInt(restaurantNames.length - 1);
      final randomRestaurant = restaurantNames[randomRestaurantNameIndex];
      print(randomRestaurant);

      } else if (resultState is RestoListErrorState) {
        print("Gagal dalam memuat data restoran");
      }
    }
    return Future.value(true);
  });
}

class WorkmanagerService {
  final Workmanager _workmanager;

  WorkmanagerService([Workmanager? workmanager]) : _workmanager = workmanager ??= Workmanager();

  Future<void> init() async {
    await _workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  }

  Future<void> runPeriodicTask() async {
    await _workmanager.registerPeriodicTask(
      AppWorkmanager.periodic.uniqueName,
      AppWorkmanager.periodic.taskName,
      frequency: const Duration(minutes: 15),
      initialDelay: Duration.zero,
      inputData: {
        "data": "Contoh doang anjay"
      }
    );
  }

  Future<void> cancelTask() async {
    await _workmanager.cancelAll();
  }
}
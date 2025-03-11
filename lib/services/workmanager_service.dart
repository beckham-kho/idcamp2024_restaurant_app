import 'dart:math';

import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/providers/home/resto_list_provider.dart';
import 'package:restaurant_app/providers/services/local_notification_provider.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
import 'package:restaurant_app/static/app_workmanager.dart';
import 'package:restaurant_app/static/resto_list_result_state.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == AppWorkmanager.periodic.taskName ||
        task == AppWorkmanager.oneOff.taskName) {
      var restaurantNames = [];
      final apiServices = ApiServices();
      final restoListProvider = RestoListProvider(apiServices);

      final flutterNotificationService = LocalNotificationService();
      final localNotificationProvider = LocalNotificationProvider(
        flutterNotificationService,
      );

      await restoListProvider.fetchRestoList();
      final resultState = restoListProvider.resultState;

      if (resultState is RestoListLoadedState) {
        for (var restaurant in resultState.data) {
          restaurantNames.add(restaurant.name);
        }
        final randomRestaurantNameIndex = Random().nextInt(
          restaurantNames.length - 1,
        );
        final randomRestaurant = restaurantNames[randomRestaurantNameIndex];
        localNotificationProvider.showNotification(randomRestaurant);
      } else if (resultState is RestoListErrorState) {
        print("Gagal dalam memuat data restoran");
      }
    }
    return Future.value(true);
  });
}

class WorkmanagerService {
  final Workmanager _workmanager;

  WorkmanagerService([Workmanager? workmanager])
      : _workmanager = workmanager ??= Workmanager();

  Future<void> init() async {
    await _workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  }

  Future<void> runPeriodicTask() async {
    final now = DateTime.now();
    final targetTime = DateTime(now.year, now.month, now.day, 11, 00);

    final initialDelay = targetTime.isBefore(now)
        ? targetTime.add(const Duration(days: 1)).difference(now)
        : targetTime.difference(now);

    await _workmanager.registerPeriodicTask(
      AppWorkmanager.periodic.uniqueName,
      AppWorkmanager.periodic.taskName,
      frequency: const Duration(hours: 24),
      initialDelay: initialDelay,
      inputData: {"data": "Tes periodic"},
    );
  }

  Future<void> runOneOffTask() async {
    await _workmanager.registerOneOffTask(
      AppWorkmanager.oneOff.uniqueName,
      AppWorkmanager.oneOff.taskName,
      constraints: Constraints(networkType: NetworkType.connected),
      initialDelay: Duration.zero,
      inputData: {"data": "Tes oneoff"},
    );
  }

  Future<void> cancelTask() async {
    await _workmanager.cancelAll();
  }
}

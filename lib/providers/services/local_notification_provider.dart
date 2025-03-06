import 'package:flutter/material.dart';
import 'package:restaurant_app/services/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvider(this.flutterNotificationService);

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  Future<void> requestPermission() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  void showNotification(String restaurantName) {
    _notificationId += 1;
    flutterNotificationService.showNotification(
      id: _notificationId,
      title: "Ubur-ubur ikan lele, yakin belum mau makan le?",
      body: "$restaurantName lagi nungguin kamu lohhh. Yuk cus kesana!",
      payload: "",
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/services/shared_preference_provider.dart';
import 'package:restaurant_app/services/workmanager_service.dart';

class NotificationSwitch extends StatefulWidget {
  const NotificationSwitch({
    super.key,
  });

  @override
  State<NotificationSwitch> createState() => _NotificationSwitchState();
}

class _NotificationSwitchState extends State<NotificationSwitch> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SharedPreferenceProvider>().getNotificationSettingValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SharedPreferenceProvider>(
      builder:(context, value, child) {
        return Switch(
          value: value.isOn,
          onChanged: (isOn) {
            value.saveNotificationSettingValue(isOn);
            value.getNotificationSettingValue();

            if(isOn == false) {
              context.read<WorkmanagerService>().cancelTask();
            } else {
              context.read<WorkmanagerService>().runPeriodicTask();
            }
          },
        );
      }
    );
  }
}
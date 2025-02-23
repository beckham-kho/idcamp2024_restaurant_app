import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/setting/notification_switch.dart';
import 'package:restaurant_app/screens/setting/theme_toggle_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ListTile(
                title: Text("Mode Tema"),
                trailing: ThemeToggleButton(),
              ),
              const SizedBox(height: 30),
              ListTile(
                title: Text("Notifikasi Makan Siang"),
                subtitle: Text("Notifikasi akan muncul setiap jam 11:00"),
                trailing: NotificationSwitch(),
              ),
            ],
          ),
        ),
      )
    );
  }
}
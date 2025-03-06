import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/general/navigation_provider.dart';
import 'package:restaurant_app/screens/favorite/favorite_screen.dart';
import 'package:restaurant_app/screens/home/home_screen.dart';
import 'package:restaurant_app/screens/setting/setting_screen.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NavigationProvider>(
        builder: (context, value, child) {
          return switch (value.navIndex) {
            0 => const HomeScreen(),
            1 => const FavoriteScreen(),
            _ => const SettingScreen(),
          };
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<NavigationProvider>().navIndex,
        onTap: (index) {
          context.read<NavigationProvider>().setNavIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: "Favorite",
            tooltip: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: "Settings",
            tooltip: "Settings",
          ),
        ],
      ),
    );
  }
}

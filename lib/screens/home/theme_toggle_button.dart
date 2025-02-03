import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/theme/theme_mode_provider.dart';

class ThemeToggleButton extends StatefulWidget {
  const ThemeToggleButton({
    super.key,
  });

  @override
  State<ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<ThemeToggleButton> {
  List<bool> isThemeModeSelected = [true, false, false];
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return ToggleButtons(
          borderColor: Theme.of(context).colorScheme.primary,
          selectedBorderColor: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(30),
          isSelected: isThemeModeSelected,
          onPressed: (index) {
            switch (index) {
              case 0: value.setThemeMode(ThemeMode.light); break;
              case 1: value.setThemeMode(ThemeMode.dark); break;
              case 2: value.setThemeMode(ThemeMode.system); break;
            }
            for (int i = 0; i < isThemeModeSelected.length; i++) {
              if(isThemeModeSelected[i] == true) {
                isThemeModeSelected[i] = false;
              }
            }
            isThemeModeSelected[index] = true;
          },
          children: [
            Icon(
              Icons.wb_sunny_rounded, 
              color: Theme.of(context).colorScheme.primary, 
              size: 24
            ),
            Icon(
              Icons.nightlight_rounded, 
              color: Theme.of(context).colorScheme.primary, 
              size: 24
            ),
            Icon(
              Icons.phone_android_rounded, 
              color: Theme.of(context).colorScheme.primary, 
              size: 24
            ),
          ],
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/services/shared_preference_provider.dart';

class ThemeToggleButton extends StatefulWidget {
  const ThemeToggleButton({
    super.key,
  });

  @override
  State<ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<ThemeToggleButton> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SharedPreferenceProvider>().getAppThemeModeValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SharedPreferenceProvider>(
      builder: (context, value, child) {
        final isThemeModeSelected = value.isThemeModeSelected;

        return ToggleButtons(
          borderColor: Theme.of(context).colorScheme.primary,
          selectedBorderColor: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(30),
          isSelected: isThemeModeSelected,
          onPressed: (index) {
            switch (index) {
              case 0:
                value.saveAppThemeModeValue("light");
                value.getAppThemeModeValue();
                break;
              case 1:
                value.saveAppThemeModeValue("dark");
                value.getAppThemeModeValue();
                break;
              case 2:
                value.saveAppThemeModeValue("system");
                value.getAppThemeModeValue();
                break;
            }
            for (int i = 0; i < isThemeModeSelected.length; i++) {
              if (isThemeModeSelected[i] == true) {
                isThemeModeSelected[i] = false;
              }
            }
            isThemeModeSelected[index] = true;
          },
          children: [
            Icon(Icons.wb_sunny_rounded,
                color: Theme.of(context).colorScheme.primary, size: 24),
            Icon(Icons.nightlight_rounded,
                color: Theme.of(context).colorScheme.primary, size: 24),
            Icon(Icons.phone_android_rounded,
                color: Theme.of(context).colorScheme.primary, size: 24),
          ],
        );
      },
    );
  }
}

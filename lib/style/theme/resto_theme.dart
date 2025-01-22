import 'package:flutter/material.dart';
import 'package:restaurant_app/style/typography/resto_text_theme.dart';

class RestoTheme {
  static ThemeData dynamicLightTheme(ColorScheme? lightDynamic) {
    return ThemeData(
      colorScheme: lightDynamic,
      brightness: Brightness.light,
      textTheme: restoTextTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData dynamicDarkTheme(ColorScheme? darkDynamic) {
    return ThemeData(
      colorScheme: darkDynamic,
      brightness: Brightness.dark,
      textTheme: restoTextTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      toolbarTextStyle:  restoTextTheme.titleMedium,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:restaurant_app/static/navigtaion_route.dart';
import 'package:restaurant_app/style/theme/resto_theme.dart';
import 'package:dynamic_color/dynamic_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp(
          title: 'Restaurant App',
          theme: RestoTheme.dynamicLightTheme(lightDynamic),
          darkTheme: RestoTheme.dynamicDarkTheme(darkDynamic),
          themeMode: ThemeMode.system,
          initialRoute: NavigtaionRoute.mainRoute.name,
          routes: {
            NavigtaionRoute.mainRoute.name: (context) => const HomeScreen(),
          },
        );
      },
    );
  }
}

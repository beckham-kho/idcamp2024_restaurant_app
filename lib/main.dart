import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/providers/detail/resto_detail_provider.dart';
import 'package:restaurant_app/providers/general/text_editing_controller_provider.dart';
import 'package:restaurant_app/providers/home/resto_list_provider.dart';
import 'package:restaurant_app/providers/home/search_resto_provider.dart';
import 'package:restaurant_app/providers/rating/post_rating_provider.dart';
import 'package:restaurant_app/providers/theme/theme_mode_provider.dart';
import 'package:restaurant_app/screens/detail/detail_screen.dart';
import 'package:restaurant_app/screens/home/home_screen.dart';
import 'package:restaurant_app/screens/rating/rating_screen.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/resto_theme.dart';
import 'package:dynamic_color/dynamic_color.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ApiServices>(
          create: (_) => ApiServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestoListProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestoDetailProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => PostRatingProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeModeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchRestoProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => TextEditingControllerProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
          // themeMode: ThemeMode.system,
          themeMode: context.watch<ThemeModeProvider>().themeMode,
          initialRoute: NavigationRoute.mainRoute.name,
          routes: {
            NavigationRoute.mainRoute.name: (context) => const HomeScreen(),
            NavigationRoute.detailRoute.name: (context) => DetailScreen(
                  restaurantId:
                      ModalRoute.of(context)?.settings.arguments as String,
                ),
            NavigationRoute.ratingRoute.name: (context) => RatingScreen(
                  restaurantId:
                      ModalRoute.of(context)?.settings.arguments as String,
                ),
          },
        );
      },
    );
  }
}

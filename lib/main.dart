import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/providers/detail/resto_detail_provider.dart';
import 'package:restaurant_app/providers/general/navigation_provider.dart';
import 'package:restaurant_app/providers/general/text_editing_controller_provider.dart';
import 'package:restaurant_app/providers/home/resto_list_provider.dart';
import 'package:restaurant_app/providers/home/search_resto_provider.dart';
import 'package:restaurant_app/providers/rating/post_rating_provider.dart';
import 'package:restaurant_app/providers/services/database_provider.dart';
import 'package:restaurant_app/providers/services/local_notification_provider.dart';
import 'package:restaurant_app/providers/services/shared_preference_provider.dart';
import 'package:restaurant_app/screens/detail/detail_screen.dart';
import 'package:restaurant_app/screens/home/home_screen.dart';
import 'package:restaurant_app/screens/navigation/navigation_bar_widget.dart';
import 'package:restaurant_app/screens/rating/rating_screen.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
import 'package:restaurant_app/services/shared_preference_service.dart';
import 'package:restaurant_app/services/sqlite_service.dart';
import 'package:restaurant_app/services/workmanager_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/resto_theme.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

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
          create: (context) => SearchRestoProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => TextEditingControllerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NavigationProvider(),
        ),
        Provider(
          create: (context) => SqliteService(),
        ),
        ChangeNotifierProvider(
          create: (context) => DatabaseProvider(
            context.read<SqliteService>(),
          ),
        ),
        Provider(
          create: (context) => SharedPreferenceService(prefs),
        ),
        ChangeNotifierProvider(
          create: (context) => SharedPreferenceProvider(
            context.read<SharedPreferenceService>()
          )
        ),
        Provider(
          create: (context) => WorkmanagerService()..init()
        ),
        Provider(
          create: (context) => LocalNotificationService()..init(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationService>(),
          )..requestPermission(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SharedPreferenceProvider>().getAppThemeModeValue();
      context.read<WorkmanagerService>().runPeriodicTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {

        return MaterialApp(
          title: 'Restaurant App',
          theme: RestoTheme.dynamicLightTheme(lightDynamic),
          darkTheme: RestoTheme.dynamicDarkTheme(darkDynamic),
          themeMode: context.watch<SharedPreferenceProvider>().appThemeMode,
          initialRoute: NavigationRoute.mainRoute.name,
          routes: {
            NavigationRoute.mainRoute.name: (context) => const NavigationBarWidget(),
            NavigationRoute.homeRoute.name: (context) => const HomeScreen(),
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



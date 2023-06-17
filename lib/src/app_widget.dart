import 'package:flutter/material.dart';
import 'package:weather_app/src/core/services/i_local_storage.dart';
import 'package:weather_app/src/core/services/shared_preferences_service.dart';

import 'package:weather_app/src/features/region/region_controller.dart';
import 'package:weather_app/src/core/services/http_service.dart';
import 'package:weather_app/src/themes/black_theme.dart';
import 'package:weather_app/src/features/weather/weather_page.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/src/themes/theme_model.dart';
import 'package:weather_app/src/themes/white_theme.dart';

import 'features/weather/weather_controller.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => HttpService()),
        Provider<ILocalStorage>(
          create: (context) => SharedPreferencesService(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegionController(context.read(), context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              WeatherController(context.read(), context.read()),
        ),
        ChangeNotifierProvider(create: (context) => ThemeModel()),
      ],
      child: Consumer<ThemeModel>(builder: (_, model, __) {
        return MaterialApp(
          title: 'WeatherApp',
          theme:whiteTheme,              
          darkTheme: blackTheme,
          themeMode:model.mode,
          debugShowCheckedModeBanner: false,
          initialRoute: '/weather',
          routes: {
            '/weather': (_) => const WeatherPage(),
          },
        );
      }),
    );
  }
}
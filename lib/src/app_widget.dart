import 'package:flutter/material.dart';
import 'package:weather_app/src/features/region/region_controller.dart';
import 'package:weather_app/src/core/services/http_service.dart';
import 'package:weather_app/src/themes/my_theme.dart';
import 'package:weather_app/src/features/weather/weather_page.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => HttpService()),
        ChangeNotifierProvider(
          create: (context) => RegionController(context.read()),
        ),
      ],
      child: MaterialApp(
        title: 'WeatherApp',
        theme: myTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/weather',
        routes: {
          '/weather': (_) => const WeatherPage(),
        },
      ),
    );
  }
}

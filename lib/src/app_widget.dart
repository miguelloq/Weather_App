import 'package:flutter/material.dart';
import 'package:weather_app/src/themes/my_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherApp',
      theme: myTheme,
      home: Container(),
    );
  }
}

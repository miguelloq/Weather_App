import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/src/features/weather/weather_controller.dart';
import '../region/region_search.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late final WeatherController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<WeatherController>(); //watch para testar esses text e elevated button
    controller.initCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
          actions: [
            IconButton(
              onPressed: () async {
                showSearch(context: context, delegate: RegionSearch());
              },
              icon: const Icon(
                Icons.search,
              ),
            ),
            IconButton(
              onPressed: () => controller.refreshCurrentAndStorageWeather(),
              icon: const Icon(Icons.refresh_rounded),
            ),
            IconButton(
              onPressed: () => controller.logWeather(),
              icon: const Icon(Icons.report_gmailerrorred),
            ),
            IconButton(
              onPressed: () => controller.deleteStorage(),
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
        body: Consumer<WeatherController>(
          builder: (BuildContext context, WeatherController controllerConsumer,
              Widget? widget) {
            return Center(
              child: Column(
                children: [
                  Text(controllerConsumer.currentWeather?.title ?? 'currentWeather null')
                ],
              ),
            );
          },
        ));
  }
}

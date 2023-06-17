import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/src/features/weather/components/neumorphism_box.dart';
import 'package:weather_app/src/features/weather/weather_controller.dart';
import '../../themes/theme_model.dart';
import '../region/region_search.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late final WeatherController controller;
  late final ThemeModel themeModel;

  @override
  void initState() {
    super.initState();
    themeModel = context.read<ThemeModel>();
    controller = context.read<WeatherController>();
    controller.initCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => themeModel.toggleMode(),
            icon: const Icon(Icons.sunny)),
        actions: [
          IconButton(
            onPressed: () {
              controller.refreshCurrentAndStorageWeather();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Weather Refreshed'),
                ),
              );
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
          IconButton(
            onPressed: () async {
              showSearch(context: context, delegate: RegionSearch());
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: NeumorphismBox(
          child: Consumer<WeatherController>(
            builder: (BuildContext context,
                WeatherController controllerConsumer, Widget? widget) {
              switch (controllerConsumer.state) {
                case WeatherDataState.noData:
                  return Center(
                    child: Text(
                      'No data detected',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  );
                case WeatherDataState.error:
                  return Center(
                    child: Text(
                      'Error',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  );
                case WeatherDataState.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case WeatherDataState.fetchData:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            controllerConsumer.currentWeather!.region.city,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            '${controllerConsumer.currentWeather!.region.country},${controllerConsumer.currentWeather!.region.state}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      Text(
                        '${controllerConsumer.currentWeather!.temperature.truncate().toString()}C°',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Column(
                        children: [
                          Text(
                            controllerConsumer.currentWeather!.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(70, 10, 70, 0),
                            child: Text(
                              'More specific ${controllerConsumer.currentWeather!.description} with ${controllerConsumer.currentWeather!.feelsLike} C° feels like',
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: NeumorphismBox(
                          height: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.air,
                                    size: 60,
                                  ),
                                  Text(
                                    '${controllerConsumer.currentWeather!.windSpeed.toString()} Km/h',
                                  ),
                                  Text(
                                    'Wind',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.water_drop_outlined,
                                    size: 60,
                                  ),
                                  Text(
                                      '${controllerConsumer.currentWeather!.humidity.toString()}%'),
                                  Text(
                                    'Humidity',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.compare_arrows_rounded,
                                    size: 60,
                                  ),
                                  Text(
                                    controllerConsumer.currentWeather!.pressure
                                        .toString(),
                                  ),
                                  Text(
                                    'Pressure',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
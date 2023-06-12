import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/shared_preferences_service.dart';
import '../region/region_search.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String a = 'abc';
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
        ],
      ),
      body: Center(
          child: Column(
        children: [
          const Text('WeatherPage'),
          ElevatedButton(
            onPressed: () async {
              final storage = SharedPreferencesService(
                  await SharedPreferences.getInstance());
              setState(() {
                a = storage.getString('currentRegion');
              });
            },
            child: Text(a),
          ),
          ElevatedButton(
              onPressed: () async {
                final storage = SharedPreferencesService(
                    await SharedPreferences.getInstance());
                storage.remove('currentRegion');
              },
              child: const Text('z'))
        ],
      )),
    );
  }
}

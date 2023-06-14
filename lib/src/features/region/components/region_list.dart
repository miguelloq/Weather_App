import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/src/features/region/region_controller.dart';
import 'package:weather_app/src/features/weather/weather_controller.dart';
import '../../../themes/theme_colors.dart';
import '../models/region.dart';

class RegionList extends StatelessWidget {
  final List<Region> regions;
  const RegionList({super.key, required this.regions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: regions.length,
      itemBuilder: ((context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: ThemeColors.primaryColor,
            child: Text(regions[index].country),
          ),
          onTap: () {
            final controllerRegion = context.read<RegionController>();
            final controllerWeather= context.read<WeatherController>();
            controllerRegion.chooseCity(index);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('City selected'),
              ),
            );
            controllerWeather.getWeatherFromStorageRegion();
          },
          title: Text(
            regions[index].city,
          ),
          subtitle: regions[index].state == 'null'
              ? const Text("No state")
              : Text(regions[index].state),
        );
      }),
    );
  }
}

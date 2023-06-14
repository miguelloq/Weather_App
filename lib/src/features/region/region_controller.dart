import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/core/services/i_local_storage.dart';
//import 'package:weather_app/src/core/services/shared_preferences_service.dart';

import '../../core/services/api_key.dart';
import '../../core/services/http_service.dart';
import 'models/region.dart';

class RegionController extends ChangeNotifier {
  List<Region> possibleRegions = [];
  late Region selectedCity;
  final HttpService client;
  final ILocalStorage storage;

  RegionController(this.client,this.storage);

  Future<void> getPossibleRegions(String cityName) async {
    final json = await client.get(
        'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=5&appid=${ApiKey.myKey}');
    possibleRegions = List<Region>.from(
      json.map(
        (e) => Region.fromJsonOpenWeather(e),
      ),
    );
    notifyListeners();
  }

  void clearPossibleRegions(){
    possibleRegions=[];
  }

  void chooseCity(int i) async{
    selectedCity=possibleRegions[i];
    storage.setString('storageRegion',selectedCity.toJson());
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';

import '../../core/services/http_service.dart';
import '../../core/services/i_local_storage.dart';
import '../region/models/region.dart';
import '../../core/services/api_key.dart';
import 'models/weather.dart';

enum WeatherDataState { noData, fetchData, error, loading }

class WeatherController extends ChangeNotifier {
  final HttpService client;
  final ILocalStorage storage;

  WeatherDataState state = WeatherDataState.noData;
  Weather? currentWeather;

  WeatherController(this.client, this.storage);

  Future<Weather> apiWeatherFromRegion({required Region region}) async {
    double latit = double.parse(region.latitude);
    double longi = double.parse(region.longitude);
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latit&lon=$longi&appid=${ApiKey.myKey}&units=metric';
    final json = await client.get(url);
    return Weather.fromJsonOpenWeather(json: json, region: region);
  }

  Future<void> getWeatherFromStorageRegion() async {
    state = WeatherDataState.loading;
    notifyListeners();
    try {
      String storageSavedRegion = await storage.getString('storageRegion');
      if (storageSavedRegion == '') {
        state = WeatherDataState.noData;
      } else {
        await updateCurrentWeatherFromStorageRegion( jsonString: storageSavedRegion);
        await saveCurrentWeatherInStorage();
        state = WeatherDataState.fetchData;
      }
    } catch (e) {
      state = WeatherDataState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> initCurrentWeather() async {
    String jsonStorageWeather = await storage.getString('storageWeather');
    if (jsonStorageWeather == '') {
      state = WeatherDataState.noData;
    } else {
      currentWeather = Weather.fromJson(jsonStorageWeather);
      state = WeatherDataState.fetchData;
    }
    notifyListeners();
  }

  Future<void> refreshCurrentAndStorageWeather() async {
    state = WeatherDataState.loading;
    notifyListeners();
    try {
      if (currentWeather != null) {
        currentWeather = await apiWeatherFromRegion(region: currentWeather!.region);
        await saveCurrentWeatherInStorage();
        state = WeatherDataState.fetchData;
      } else {
        state = WeatherDataState.noData;
      }
    } catch (e) {
      state = WeatherDataState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateCurrentWeatherFromStorageRegion(
      {required jsonString}) async {
    state = WeatherDataState.fetchData;
    currentWeather =
        await apiWeatherFromRegion(region: Region.fromJson(jsonString));
  }

  Future<void> saveCurrentWeatherInStorage() async {
    if (currentWeather != null) {
      await storage.setString('storageWeather', currentWeather!.toJson());
    }
  }

  Future<void> deleteStorage() async {
    await storage.remove('storageWeather');
    await storage.remove('storageRegion');
    log('deleteStorageWeather');
  }

  Future<void> logWeather() async {
    log('state: ${state.name}');
    log('currentWeather: $currentWeather');
    log('localRegion: ${await storage.getString('storageRegion')}');
    log('localWeather: ${await storage.getString('storageWeather')}');
  }
}

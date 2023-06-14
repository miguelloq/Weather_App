import 'dart:convert';

import '../../region/models/region.dart';

class Weather {
  Region region;
  String title;
  String description;
  double temperature;
  double feelsLike;
  double windSpeed;
  double humidity;
  double pressure;

  Weather({
    required this.region,
    required this.title,
    required this.description,
    required this.temperature,
    required this.feelsLike,
    required this.windSpeed,
    required this.humidity,
    required this.pressure,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'region': region.toMap(),
      'title': title,
      'description': description,
      'temperature': temperature,
      'feelsLike': feelsLike,
      'windSpeed': windSpeed,
      'humidity': humidity,
      'pressure': pressure,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      region: Region.fromMap(map['region'] as Map<String,dynamic>),
      title: map['title'] as String,
      description: map['description'] as String,
      temperature: map['temperature'] as double,
      feelsLike: map['feelsLike'] as double,
      windSpeed: map['windSpeed'] as double,
      humidity: map['humidity'] as double,
      pressure: map['pressure'] as double,
    );
  }

  Weather.fromJsonOpenWeather({required Map<String, dynamic> json,required this.region})
      : title = json['weather'][0]['main'].toString(),
        description = json['weather'][0]['description'].toString(),
        temperature = json['main']['temp'].toDouble(),
        feelsLike = json['main']['feels_like'].toDouble(),
        windSpeed = json['wind']['speed'].toDouble(),
        humidity = json['main']['humidity'].toDouble(),
        pressure = json['main']['pressure'].toDouble();

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) => Weather.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Weather(region: $region, title: $title, description: $description, temperature: $temperature, feelsLike: $feelsLike, windSpeed: $windSpeed, humidity: $humidity, pressure: $pressure)';
  }
}

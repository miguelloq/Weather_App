import 'dart:convert';

class Region {
  String city;
  String state;
  String country;
  String latitude;
  String longitude;

  Region(
      {required this.city,
      required this.state,
      required this.country,
      required this.latitude,
      required this.longitude});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city': city,
      'state': state,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  Region.fromMap(Map<String, dynamic> map)
      : city = map['city'].toString(),
        state = map['state'].toString(),
        country = map['country'].toString(),
        latitude = map['latitude'].toString(),
        longitude = map['longitude'].toString();

  Region.fromJsonOpenWeather(Map<String, dynamic> map)
      : city = map['name'].toString(),
        state = map['state'].toString(),
        country = map['country'].toString(),
        latitude = map['lat'].toString(),
        longitude = map['lon'].toString();

  String toJson() => json.encode(toMap());

  factory Region.fromJson(String source) =>
      Region.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'city:$city , state:$state , country:$country , latitude:$latitude , longitude:$longitude';
  }
}

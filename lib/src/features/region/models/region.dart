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

  Region.fromMap(Map<String, dynamic> map)
      : city = map['name'].toString(),
        state = map['state'].toString(),
        country = map['country'].toString(),
        latitude = map['lat'].toString(),
        longitude = map['lon'].toString();

  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'state': state,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'city:$city , state:$state , country:$country , latitude:$latitude , longitude:$longitude';
  }
}

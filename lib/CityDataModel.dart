
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;


Future<List<City>> getCities() async {
  final jsondata =
  await rootBundle.rootBundle.loadString('assets/cities.json');
  final list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => City.fromJson(e)).toList();
}


List<City> cityFromJson(String str) => List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

class City {
  City({
    required  this.id,
    required this.name,
    required this.state,
    required this.country,
    required this.coord,
  });

  int id;
  String name;
  String state;
  String country;
  Coord coord;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    state: json["state"],
    country:json["country"],
    coord: Coord.fromJson(json["coord"]),
  );
}

class Coord {
  Coord({
    required this.lon,
    required this.lat,
  });

  double lon;
  double lat;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
    lon: json["lon"].toDouble(),
    lat: json["lat"].toDouble(),
  );
}

import 'dart:convert';

import 'package:weather_app_bloc/data/dataproviders/api_providers.dart';
import 'package:weather_app_bloc/data/models/current_weather.dart';
import 'package:weather_app_bloc/data/models/search_location.dart';

class Repository {
  final ApiProviders apiProviders;
  Repository({
    required this.apiProviders,
  });

  Future<CurrentWeather> getWeather(String city) async {
    final _weather = await apiProviders.fetchWeather(city);
    return CurrentWeather.fromJson(_weather);
  }

  Future<List<SearchLocation>> searchLocations(String city) async {
    final List<dynamic> _locations = await apiProviders.searchLocation(city);
    return _locations.map((e) => SearchLocation.fromJson(e)).toList();
  }
}

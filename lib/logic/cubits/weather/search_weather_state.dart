part of 'search_weather_cubit.dart';

abstract class SearchWeatherState {
  const SearchWeatherState();

  // @override
  // List<Object> get props => [];
}

class WeatherSearchLoading extends SearchWeatherState {}

class WeatherSearchLoaded extends SearchWeatherState {
  final List<SearchLocation> locations;
  WeatherSearchLoaded({
    required this.locations,
  });
}

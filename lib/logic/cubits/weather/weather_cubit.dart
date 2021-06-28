import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:weather_app_bloc/data/models/current_weather.dart';
import 'package:weather_app_bloc/data/models/search_location.dart';
import 'package:weather_app_bloc/data/repositories/repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final Repository repository;
  WeatherCubit({required this.repository}) : super(WeatherInitial());

  void fetchWeather(String city) async {
    emit(WeatherInitial());
    repository
        .getWeather(city)
        .then((weather) => emit(WeatherLoaded(currentWeather: weather)));
  }
}

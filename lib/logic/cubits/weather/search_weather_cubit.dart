import 'package:bloc/bloc.dart';
import 'package:weather_app_bloc/data/models/search_location.dart';
import 'package:weather_app_bloc/data/repositories/repository.dart';

part 'search_weather_state.dart';

class SearchWeatherCubit extends Cubit<SearchWeatherState> {
  final Repository repository;

  SearchWeatherCubit({required this.repository})
      : super(WeatherSearchLoading());

  void searchLocations(String city) async {
    // print(city);
    emit(WeatherSearchLoading());
    repository.searchLocations(city).then((locations) {
      emit(WeatherSearchLoaded(locations: locations));
    });
  }
}

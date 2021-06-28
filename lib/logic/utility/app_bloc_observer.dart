import 'package:bloc/bloc.dart';
import 'package:weather_app_bloc/logic/cubits/weather/weather_cubit.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    // print(bloc);
    super.onChange(bloc, change);
  }

  @override
  void onCreate(BlocBase bloc) {
    print(bloc);
    // if (bloc is WeatherCubit) {
    //   bloc.fetchWeather();
    // }
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    print(bloc);
    super.onClose(bloc);
  }
}

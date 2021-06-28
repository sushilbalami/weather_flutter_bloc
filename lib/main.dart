import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app_bloc/data/dataproviders/api_providers.dart';
import 'package:weather_app_bloc/data/repositories/repository.dart';
import 'package:weather_app_bloc/logic/cubits/weather/search_weather_cubit.dart';
import 'package:weather_app_bloc/logic/utility/app_bloc_observer.dart';
import 'package:weather_app_bloc/presentation/router/app_router.dart';
import 'package:weather_app_bloc/presentation/screens/home_screen.dart';

import 'logic/cubits/weather/weather_cubit.dart';
import 'presentation/themes/lightTheme.dart';

void main() {
  final AppRouter _appRouter = AppRouter();
  final ApiProviders _apiProviders = ApiProviders();
  final Repository _repository = Repository(apiProviders: _apiProviders);
  Bloc.observer = AppBlocObserver();

  runApp(
    WeatherApp(
      appRouter: _appRouter,
      apiProviders: _apiProviders,
      repository: _repository,
    ),
  );
}

class WeatherApp extends StatelessWidget {
  final AppRouter? appRouter;
  final ApiProviders apiProviders;
  final Repository repository;

  WeatherApp({
    Key? key,
    this.appRouter,
    required this.apiProviders,
    required this.repository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherCubit(
            repository: repository,
          ),
        ),
        BlocProvider(
          create: (context) => SearchWeatherCubit(
            repository: repository,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: lightThemeData,
        onGenerateRoute: appRouter!.onGenerateRoute,
        home: Home(),
      ),
    );
  }
}

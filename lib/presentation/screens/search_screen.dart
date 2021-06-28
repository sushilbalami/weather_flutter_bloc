import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/logic/cubits/weather/search_weather_cubit.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          autofocus: true,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          onChanged: (city) => BlocProvider.of<SearchWeatherCubit>(context)
              .searchLocations(city),
        ),
      ),
      body: BlocBuilder<SearchWeatherCubit, SearchWeatherState>(
        builder: (context, state) {
          if (state is WeatherSearchLoading) {
            return CircularProgressIndicator();
          }
          if (state is WeatherSearchLoaded) {
            return ListView.builder(
              itemCount: state.locations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    state.locations[index].city,
                  ),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:weather_app_bloc/logic/cubits/weather/search_weather_cubit.dart';
import 'package:weather_app_bloc/logic/cubits/weather/weather_cubit.dart';

Widget buildFloatingSearchBar(BuildContext context) {
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  final FloatingSearchBarController _controller = FloatingSearchBarController();
  return FloatingSearchBar(
    hint: 'Search...',
    clearQueryOnClose: true,
    hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
          fontSize: 16,
        ),
    queryStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
          fontSize: 16,
        ),
    backgroundColor: Colors.white54,
    scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
    transitionDuration: const Duration(milliseconds: 250),
    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    axisAlignment: isPortrait ? 0.0 : -1.0,
    openAxisAlignment: 0.0,
    width: isPortrait ? 600 : 500,
    debounceDelay: const Duration(milliseconds: 500),
    controller: _controller,
    // onQueryChanged: (query) =>
    //     BlocProvider.of<SearchWeatherCubit>(context).searchLocations(query),
    onSubmitted: (query) =>
        BlocProvider.of<SearchWeatherCubit>(context).searchLocations(query),
    // onSubmitted: (query) => context.read<WeatherCubit>().searchLocations(query),
    // Specify a custom transition to be used for
    // animating between opened and closed stated.
    transition: CircularFloatingSearchBarTransition(),
    // actions: [
    //   FloatingSearchBarAction(
    //     showIfOpened: false,
    //     child: CircularButton(kath
    //       icon: const Icon(Icons.place),
    //       onPressed: () {},
    //     ),
    //   ),
    //   FloatingSearchBarAction.searchToClear(
    //     showIfClosed: false,
    //   ),
    // ],
    builder: (context, transition) {
      return BlocBuilder<SearchWeatherCubit, SearchWeatherState>(
        builder: (context, state) {
          if (state is WeatherSearchLoading) {
            return Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            );
          }
          if (state is WeatherSearchLoaded) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
              ),
              height: MediaQuery.of(context).size.height * 0.6,
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: state.locations.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        BlocProvider.of<WeatherCubit>(context)
                            .fetchWeather(state.locations[index].city);
                        _controller.close();
                      },
                      leading: IconButton(
                        onPressed: () => {},
                        icon: Icon(Icons.map_rounded),
                      ),
                      title: Text(
                        state.locations[index].city,
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: 17,
                        ),
                        maxLines: 1,
                      ),
                      subtitle: Text(
                        state.locations[index].country,
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return Center();
        },
      );
    },
  );
}

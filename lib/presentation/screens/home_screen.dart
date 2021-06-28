import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:weather_app_bloc/data/models/current_weather.dart';
import 'package:weather_app_bloc/logic/cubits/weather/weather_cubit.dart';
import 'package:weather_app_bloc/presentation/widgets/search_material.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<WeatherCubit>().fetchWeather("Kathmandu");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text(
      //     "Weather",
      //     style: GoogleFonts.poppins(
      //       color: Colors.white,
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () => Navigator.pushNamed(context, '/search'),
      //       icon: Icon(
      //         Icons.search,
      //       ),
      //     )
      //   ],
      // ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitial) {
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
          if (state is WeatherLoaded) {
            return WeatherStatus(
              currentWeather: state.currentWeather,
              state: state,
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}

class WeatherStatus extends StatelessWidget {
  final CurrentWeather currentWeather;
  final WeatherState state;
  const WeatherStatus(
      {Key? key, required this.currentWeather, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Container(
              height: size.height * 0.26,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network(
                    currentWeather.condition!['icon']
                        .toString()
                        .replaceRange(0, 2, 'https://'),
                    fit: BoxFit.cover,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentWeather.tempC.toString(),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        "  °C",
                        style: Theme.of(context).textTheme.headline6,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  currentWeather.name.toString(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  currentWeather.country!.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 32, 8, 8),
              child: Card(
                color: Colors.white10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _iconCard(
                          currentWeather.windFlow!.toDouble(), "Wind Flow",
                          context: context),
                      _iconCard(currentWeather.humidity!.toDouble(), "Humidity",
                          context: context),
                      _iconCard(
                          currentWeather.pressureMb!.toDouble(), "Pressure",
                          context: context),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 32, 8, 8),
              child: Card(
                color: Colors.white10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        currentWeather.forecast!.length,
                        (index) => _forecastIconCard(
                            currentWeather.forecast![index]['day']['avgtemp_c'],
                            currentWeather.forecast![index]['day']['condition']
                                ['icon'],
                            DateFormat('EEEE').format(DateTime.parse(
                                currentWeather.forecast![index]['date'])),
                            context: context)),
                  ),
                ),
              ),
            )
          ],
        ),
        buildFloatingSearchBar(context),
      ],
    );
  }

  Widget _iconCard(double value, String text, {required BuildContext context}) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        IconButton(
          onPressed: () {},
          icon: BoxedIcon(
            WeatherIcons.day_windy,
            size: 20,
            color: Color(0xff939597),
          ),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }

  Widget _forecastIconCard(double value, String image, String text,
      {required BuildContext context}) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              value.toString(),
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 16,
                  ),
            ),
            Text(
              " °",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
          child: Image.network(
            image.replaceRange(0, 2, 'https://'),
            width: 36,
            height: 36,
          ),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }
}

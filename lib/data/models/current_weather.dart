class CurrentWeather {
  String? name;
  String? country;
  double? tempC;
  double? tempF;
  double? airQuality;
  double? windFlow;
  double? pressureMb;
  int? humidity;
  double? feelsLikeC;
  Map<String, dynamic>? condition;
  List<dynamic>? forecast;
  CurrentWeather({
    this.name,
    this.country,
    this.tempC,
    this.tempF,
    this.airQuality,
    this.windFlow,
    this.pressureMb,
    this.humidity,
    this.feelsLikeC,
    this.condition,
    this.forecast,
  });

  CurrentWeather.fromJson(Map json)
      : name = json['location']['name'],
        country = json['location']['country'],
        tempC = json['current']['temp_c'],
        tempF = json['current']['temp_f'] as double,
        windFlow = json['current']['wind_mph'] as double,
        pressureMb = json['current']['pressure_mb'] as double,
        feelsLikeC = json['current']['feelslike_c'] as double,
        humidity = json['current']['humidity'] as int,
        airQuality = json['current']['air_quality']['so2'] as double,
        condition = json['current']['condition'],
        forecast = json['forecast']['forecastday'];
}

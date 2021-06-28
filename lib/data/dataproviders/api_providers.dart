import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiProviders {
  final String baseUrl =
      "https://api.weatherapi.com/v1/forecast.json?key=6e9740a24a8b49c9a9960644212606";
  final String searchBaseUrl =
      "https://api.weatherapi.com/v1/search.json?key=6e9740a24a8b49c9a9960644212606";

  Future<Map> fetchWeather(String city) async {
    try {
      final response =
          await http.get(Uri.parse(baseUrl + '&q=$city&days=7&aqi=yes'));
      return jsonDecode(response.body) as Map;
    } catch (e) {
      return {};
    }
  }

  Future<List<dynamic>> searchLocation(String city) async {
    try {
      final response = await http.get(Uri.parse(searchBaseUrl + '&q=$city'));
      // print(response.body);
      return json.decode(response.body) as List<dynamic>;
    } catch (e) {
      return [];
    }
  }
}

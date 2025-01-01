import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const _apiUrl = 'https://jsonplaceholder.typicode.com/posts/1';

  Future<Map<String, dynamic>> fetchWeatherData() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));

      print("WeatherService--_apiUrl-$_apiUrl");
      print("WeatherService---${response.statusCode}");
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }
}

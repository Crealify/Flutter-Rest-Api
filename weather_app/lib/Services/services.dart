import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/model.dart';

class WeatherServices {
  static Future<WeatherData?> fetchWeather() async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=27.6983&lon=83.4653&appid=8cb9b0faf3581dd5e91750f159ca26e9",

          // /&units=metric
        ),
      );
      //
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return WeatherData.fromJson(jsonData);
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}

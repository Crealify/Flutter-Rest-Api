import 'package:flutter/material.dart';
import 'package:weather_app/Services/services.dart';
import 'package:weather_app/model/model.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  late WeatherData weatherInfo;
  myWeather() {
    WeatherServices.fetchWeather().then((value) {
      setState(() {
        weatherInfo = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFF676BD0));
  }
}

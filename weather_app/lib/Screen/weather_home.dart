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
  void initState() {
    super.initState();
    myWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF676BD0),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(children: [WeatherDetails(weather: weatherInfo)]),
      ),
    );
  }
}

class WeatherDetails extends StatelessWidget {
  final WeatherData weather;
  const WeatherDetails({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //for current address name
        Text(
          weather.name,
          style: TextStyle(
            fontSize: .25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "${weather.temperature.current.toStringAsFixed(2)}° C",
          style: TextStyle(
            fontSize: .25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

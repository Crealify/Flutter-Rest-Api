import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Services/services.dart';
import 'package:weather_app/model/model.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  late WeatherData weatherInfo;
  bool isLoading = true;
  // myWeather() {
  //   WeatherServices.fetchWeather().then((value) {
  //     setState(() {
  //       weatherInfo = value!;
  //     });
  //   });
  // }

  @override
  void initState() {
    weatherInfo = WeatherData(
      name: '',
      temperature: Temperature(current: 0.0),
      humidity: 0,
      wind: Wind(speed: 0.0),
      maxTemperature: 0,
      minTemperature: 0,
      pressure: 0,
      seaLevel: 0,
      weather: [],
    );
    super.initState();
    myWeather();
  }

  void myWeather() async {
    final value = await WeatherServices.fetchWeather();
    if (value != null) {
      setState(() {
        weatherInfo = value;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat(
      "EEEE D, MMMM yyy",
    ).format(DateTime.now());

    String formattedTime = DateFormat("hh:mm a").format(DateTime.now());

    return Scaffold(
      backgroundColor: Color(0xFF676BD0),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : Center(
                child: WeatherDetails(
                  weather: weatherInfo,
                  formattedDate: formattedDate,
                  formattedTime: formattedTime,
                ),
              ),
      ),
    );
  }
}

class WeatherDetails extends StatelessWidget {
  final WeatherData weather;
  final String formattedDate;
  final String formattedTime;
  const WeatherDetails({
    super.key,
    required this.weather,
    required this.formattedDate,
    required this.formattedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        //for current address name
        Text(
          weather.name,
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        // for current temperature of my location
        Text(
          "${weather.temperature.current.toStringAsFixed(2)}° C",
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        //fpr weather condition
        if (weather.weather.isNotEmpty)
          Text(
            weather.weather[0].main,
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        SizedBox(height: 30),
        Text(
          formattedDate,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          formattedTime,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

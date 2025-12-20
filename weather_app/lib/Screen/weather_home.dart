
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
      "EEEE d, MMMM yyyy",
    ).format(DateTime.now());
    String formattedTime = DateFormat("hh:mm a").format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF676BD0),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : WeatherDetails(
                weather: weatherInfo,
                formattedDate: formattedDate,
                formattedTime: formattedTime,
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
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 60),

          /// City Name
          Text(
            weather.name,
            style: const TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          /// Temperature
          Text(
            "${weather.temperature.current.toStringAsFixed(2)}° C",
            style: const TextStyle(
              fontSize: 44,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 2),

          /// Weather Condition
          if (weather.weather.isNotEmpty)
            Text(
              weather.weather[0].main,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),

          const SizedBox(height: 24),

          /// Date & Time
          Text(
            formattedDate,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          Text(
            formattedTime,
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),

          const SizedBox(height: 30),

          /// Weather Icon
          Container(
            height: 180,
            width: 180,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/cloudy.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// Info Card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    infoItem(
                      icon: Icons.wind_power,
                      title: "Wind",
                      value: "${weather.wind.speed} km/h",
                    ),
                    infoItem(
                      icon: Icons.sunny,
                      title: "Max",
                      value: "${weather.maxTemperature.toStringAsFixed(2)}° C",
                    ),
                    infoItem(
                      icon: Icons.ac_unit,
                      title: "Min",
                      value: "${weather.minTemperature.toStringAsFixed(2)}° C",
                    ),
                  ],
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: Divider(color: Colors.white30),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    infoItem(
                      icon: Icons.water_drop,
                      title: "Humidity",
                      value: "${weather.humidity}%",
                      iconColor: Colors.amber,
                    ),
                    infoItem(
                      icon: Icons.air,
                      title: "Pressure",
                      value: "${weather.pressure} hPa",
                      iconColor: Colors.amber,
                    ),
                    infoItem(
                      icon: Icons.leaderboard,
                      title: "Sea-Level",
                      value: "${weather.seaLevel} m",
                      iconColor: Colors.amber,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Column infoItem({
    required IconData icon,
    required String title,
    required String value,
    Color iconColor = Colors.white,
  }) {
    return Column(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}

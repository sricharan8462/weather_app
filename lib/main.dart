import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const WeatherInfoApp());
}

class WeatherInfoApp extends StatelessWidget {
  const WeatherInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Info App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final TextEditingController _cityController = TextEditingController();
  String _city = "";
  String _temperature = "";
  String _condition = "";
  List<String> _weeklyForecast = [];

  /// Function to fetch simulated weather data for the entered city
  void fetchWeather() {
    final Random random = Random();
    int temp = 15 + random.nextInt(16); // Random temperature between 15-30°C
    List<String> conditions = ["Sunny", "Cloudy", "Rainy"];
    String condition = conditions[random.nextInt(conditions.length)];

    setState(() {
      _city = _cityController.text;
      _temperature = "$temp°C";
      _condition = condition;
      _weeklyForecast =
          []; // Reset weekly forecast when fetching current weather
    });
  }

  /// Function to fetch a 7-day simulated weather forecast
  void fetchWeeklyForecast() {
    final Random random = Random();
    List<String> conditions = ["Sunny", "Cloudy", "Rainy"];

    setState(() {
      _weeklyForecast = List.generate(7, (index) {
        int temp = 15 + random.nextInt(16);
        String condition = conditions[random.nextInt(conditions.length)];
        return "Day ${index + 1}: $temp°C, $condition";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Info')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchWeather,
              child: const Text("Fetch Weather"),
            ),
            const SizedBox(height: 20),
            if (_city.isNotEmpty) ...[
              Text("City: $_city",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Text("Temperature: $_temperature",
                  style: const TextStyle(fontSize: 18)),
              Text("Condition: $_condition",
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
            ],
            ElevatedButton(
              onPressed: fetchWeeklyForecast,
              child: const Text("Get 7-Day Forecast"),
            ),
            const SizedBox(height: 20),
            if (_weeklyForecast.isNotEmpty) ...[
              const Text("7-Day Forecast:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ..._weeklyForecast.map((dayForecast) =>
                  Text(dayForecast, style: const TextStyle(fontSize: 16))),
            ],
          ],
        ),
      ),
    );
  }
}

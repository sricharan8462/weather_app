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

  void fetchWeather() {
    final Random random = Random();
    int temp = 15 + random.nextInt(16); // Random temperature between 15-30°C
    List<String> conditions = ["Sunny", "Cloudy", "Rainy"];
    String condition = conditions[random.nextInt(conditions.length)];

    setState(() {
      _city = _cityController.text;
      _temperature = "$temp°C";
      _condition = condition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Info')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            Text("City: $_city", style: const TextStyle(fontSize: 20)),
            Text("Temperature: $_temperature", style: const TextStyle(fontSize: 20)),
            Text("Condition: $_condition", style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
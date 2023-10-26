import 'package:flutter/material.dart';
import 'weather_api.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApi _weatherApi = WeatherApi();
  String cityName = 'bangkok';
  Map<String, dynamic> weatherData = {};

  void fetchWeather() async {
    try {
      final response =
      await _weatherApi.get('weather/current', params: {'city': cityName});
      final data = json.decode(response);
      setState(() {
        weatherData = data;
      });
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: weatherData.isNotEmpty
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'City: ${weatherData['city']}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'Temperature: ${weatherData['temperature']} ${weatherData['unit']}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'Condition: ${weatherData['condition']}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      cityName = 'new_city';
                    });
                    fetchWeather();
                  },
                  child: Text('Change City'),
                ),
              ],
            ),
            SizedBox(height: 32),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Humidity: ${weatherData['humidity']}%',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    'Wind Speed: ${weatherData['windSpeed']} ${weatherData['windUnit']}',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    'UV Index: ${weatherData['uvIndex']}',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ],
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}
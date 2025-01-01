import 'dart:async';
import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? _weatherData;
  bool _isLoading = true;
  String? _errorMessage;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
    _startRealTimeUpdates();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startRealTimeUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _fetchWeather();
    });
  }

  Future<void> _fetchWeather() async {
    try {
      final data = await _weatherService.fetchWeatherData();
      setState(() {
        _weatherData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(child: Text('Error: $_errorMessage'));
    }

    return Card(
      child: ListTile(
        title: const Text('Weather Widget'),
        subtitle: Text(
          'Title: ${_weatherData?['title']}\n'
              'Body: ${_weatherData?['body']}',
        ),
      ),
    );
  }
}

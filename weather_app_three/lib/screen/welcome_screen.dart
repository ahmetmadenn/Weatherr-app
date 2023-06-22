import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_three/screen/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    getLocationAndFetchWeather();
  }

  void getLocationAndFetchWeather() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    double latitude = position.latitude;
    double longitude = position.longitude;

    fetchWeatherData(latitude, longitude);
  }

  void fetchWeatherData(double latitude, double longitude) async {
    String apiKey = '3dfa70aa1e4ebc7248931372305ee132';
    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';

    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> weatherData = jsonDecode(response.body);
      String cityName = weatherData['name'];
      double temperatureKelvin = weatherData['main']['temp'];
      double temperatureCelsius = temperatureKelvin - 273.15;
      String weatherDescription = weatherData['weather'][0]['description'];

      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              cityName: cityName,
              temperature: temperatureCelsius.round().toDouble(),
              weatherDescription: weatherDescription,
            ),
          ),
        );
      });
    } else {
      print('Hava durumu bilgisi alınamadı. Hata kodu: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 183, 198, 14),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/welcome.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: SizedBox(
                height: 250,
                width: 250,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

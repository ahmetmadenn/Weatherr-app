import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String cityName;
  final double temperature;
  final String weatherDescription;

  const HomeScreen({
    super.key,
    required this.cityName,
    required this.temperature,
    required this.weatherDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bulut.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/loc.png'),
                  const SizedBox(height: 20),
                  Text(
                    'Şehir: $cityName',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Image.asset('assets/images/loc2.png'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Sıcaklık: $temperature °C',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

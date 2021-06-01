import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/networking.dart';

import '../services/location.dart';

const String apiKey = 'c9db25feaa50da245b8f05b969e3136f';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longtitude;
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getPosition();
    latitude = location.latitude;
    longtitude = location.longtitude;

    NetworkHelp networkHelp = NetworkHelp(
        url:
            'https://samples.openweathermap.org/data/2.5/weather?lat={$latitude}&lon={$longtitude}&appid={$apiKey}');
    var weatherData = await networkHelp.getData();
    print(weatherData);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(
          locationWeather: weatherData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}

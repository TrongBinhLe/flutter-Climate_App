import '../services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    getPosition();
  }

  void getPosition() async {
    Location location = Location();
    await location.getPosition();
    latitude = location.latitude;
    longtitude = location.longtitude;
  }

  void getData() async {
    String api = 'c9db25feaa50da245b8f05b969e3136f';
    http.Response response = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?lat={$latitude}&lon={$longtitude}&appid={$api}');
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      double temperature = decodedData['main']['temp'];
      int condition = decodedData['weather'][0]['id'];
      String cityName = decodedData['name'];

      print(temperature);
      print(condition);
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            getData();
          },
        ),
      ),
    );
  }
}

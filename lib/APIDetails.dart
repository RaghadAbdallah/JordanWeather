import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'WeatherAPI.dart';
import 'FavouritePage.dart';

class WeatherPage extends StatefulWidget {
  final int cityID;

  WeatherPage(this.cityID);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String weatherInfo = '';
  DateTime selectedDate = DateTime.now();

  Map<String, dynamic> getWeatherSplittedInfo() {
    Map<String, dynamic> info = new Map<String, dynamic>();
    List<String> info2 = weatherInfo.split(',');
    for (String s in info2) info.addAll({s.split(':')[0]: s.split(':')[1]});

    return info;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference favourite =
        FirebaseFirestore.instance.collection('favorite');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                favourite.add(getWeatherSplittedInfo());
              },
              icon: Icon(Icons.star_border))
        ],
        title: Text('Weather'),
      ),
      body: FutureBuilder(
        future: getWeatherInfo(this.widget.cityID),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text('${snapshot.error} has occurred.'),
            );
          else if (snapshot.hasData) {
            final Weather weather = snapshot.data as Weather;
            weatherInfo =
                'Temp:${weather.main.temp}C,\nFeelsLike: ${weather.main.feelsLike} C,\nHumidity: ${weather.main.humidity},\nPressure: ${weather.main.pressure},\nDateOfAdding : ${selectedDate.toString().split(' ')[0]},\nName:${weather.name}';
            return Center(
              child: Container(
                color: Colors.white24,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.workspaces_filled),
                      Text(
                        'City Name: ${weather.name}!',
                        style: TextStyle(fontSize: 40),
                      ),
                      Container(
                        color: Colors.teal,
                        width: 200,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(weatherInfo, style: TextStyle(fontSize: 20))
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

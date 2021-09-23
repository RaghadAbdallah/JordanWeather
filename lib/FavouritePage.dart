import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Favourite {
  Favourite(
      {this.WeatherPressure,
      this.WeatherHumidity,
      this.Temperatur,
      this.WeatherfeelsLike});

  int? WeatherPressure;
  int? WeatherHumidity;
  double? Temperatur;
  double? WeatherfeelsLike;

}

class FavoriteCitiesPage extends StatefulWidget {
  @override
  _FavoriteCitiesPageState createState() => _FavoriteCitiesPageState();
}

class _FavoriteCitiesPageState extends State<FavoriteCitiesPage> {
  final Favourite favoriteCities = Favourite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Cities'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('favorite').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isNotEmpty) {
              var cityInfo = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: cityInfo.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Card(
                        elevation: 5,
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('favorite')
                                              .doc(cityInfo[index].id)
                                              .delete();
                                          deletedToast(cityInfo, index);
                                        },
                                        icon: Icon(
                                          Icons.remove_circle,
                                          color: Colors.red,
                                        )),
                                  ],
                                ),
                              ),
                              /*
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Text(
                                  '${cityInfo[index]['name']}',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: Icon(
                                  cityInfo[index]['weather'] == 'Clear'
                                      ? Icons.wb_sunny
                                      : Icons.cloud,
                                  size: 100,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Text(
                                  'Weather : ${cityInfo[index]['weather']}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),*/
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Text(
                                  'Name: ${cityInfo[index].data().toString().split(',')[1].split(':')[1]}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                  'Weather FeelsLike : ${cityInfo[index].data().toString().split(',')[5].split(':')[1]}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                  'Temperature : ${cityInfo[index].get('Temp').toString()} ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Text(
                                  'Weather Pressure: ${cityInfo[index].data().toString().split(',')[3].split(':')[1]}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 20, left: 100),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Weather Humidity : ${cityInfo[index].data().toString().split(',')[4].split(':')[1]}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ))

                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          }
          return Center(
            child: Column(children: [
              Text(
                'You don\'t added cities to favorite yet',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ], mainAxisAlignment: MainAxisAlignment.center),
          );
        },
      ),
    );
  }

  void deletedToast(List<QueryDocumentSnapshot<Object?>> cityInfo, int index) {
    Fluttertoast.showToast(
        msg: '${cityInfo[index]['name']} Deleted',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM);
  }
}

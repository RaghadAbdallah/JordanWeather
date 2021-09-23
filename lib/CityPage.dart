import 'package:firebase_core/firebase_core.dart';
import 'CityDataModel.dart';
import 'package:flutter/material.dart';
import 'APIDetails.dart';
import 'FavouritePage.dart';

class CityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jordan Cities',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Cities(),
    );
  }
}

class Cities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('List Of Cities'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FavoriteCitiesPage())),
            icon: Icon(Icons.favorite)),],
      ),
      body: FutureBuilder(
        future: getCities(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text('${data.error}'));
          } else if (data.hasData) {
            var items = data.data as List<City>;
            return ListView.builder(itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WeatherPage(items[index].id))),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(items[index].name.toString()),
                                Text(items[index].state.toString()),
                                Text('Latitude : ${items[index].coord.lat}'),
                                Text('Longitude : ${items[index].coord.lon}'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

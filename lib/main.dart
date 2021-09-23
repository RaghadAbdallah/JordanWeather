import 'dart:async';
import 'CityPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen',
      home: MyHomePage(),
      //theme: ThemeData.dark(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Timer(Duration(seconds:3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:

                (context) =>CityPage()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 200,),
          Container(

              child:CircleAvatar(backgroundImage:AssetImage('assets/Logo.jpg'),radius: 150,)

          )
          , SizedBox(height: 60,)
          ,Text('Done By Raghad',
            style: TextStyle(
              inherit: false,
              color:Colors.white24,
              fontSize: 20,
            ),)
        ],
      ),
    );
  }
}



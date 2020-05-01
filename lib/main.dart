import 'package:clima/screens/about_app.dart';
import 'package:clima/screens/country_screen.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/screens/news.dart';
import 'package:clima/screens/noInternet.dart';
import 'package:clima/screens/webmap.dart';
import 'package:clima/screens/world_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:connectivity/connectivity.dart';

import 'backend/fetching.dart';
import 'nav.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

//  String netCheck(){
//    var connectivityResult=Connectivity().checkConnectivity();
//print(connectivityResult);
//    // ignore: unrelated_type_equality_checks
//    if(connectivityResult==ConnectivityResult.wifi||connectivityResult==ConnectivityResult.mobile){
//      return "wel";
//    }
//    else{
//     return "no";
//
//    }
//
//  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Name',
      initialRoute: 'wel',
      routes: {
        'wel': (context) => WorldScreen(),
//        'no': (context) =>  HomePage(),

      },
    );
  }
}
  class _MyAppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Center(
  child: new SplashScreen(
  seconds: 5,
  navigateAfterSeconds: new WorldScreen(),
  image: new Image.asset("gif/covid.gif",),
  backgroundColor: Colors.black,
  styleTextUnderTheLoader: new TextStyle(),
  photoSize: 230.0,
  loaderColor: Colors.black38,
  loadingText: Text("GO Corona",
  style: TextStyle(letterSpacing: 8,
  fontSize: 30,
  color: Colors.white,
  fontWeight: FontWeight.bold

  ),
  ),
  ),
  );
  }
  }

import "package:flutter/material.dart";
import 'package:webview_flutter/webview_flutter.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/screens/youtube.dart';
import 'package:clima/widgets/my_header_world.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:io';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'about_app.dart';
import 'news.dart';
import 'noInternet.dart';

class webMap extends StatefulWidget {

  @override
  _webMapState createState() => _webMapState();
}

class _webMapState extends State<webMap> {
  Future Nonet(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => noInternet()));
  }
  StreamSubscription connectivitySubscription;

  bool dialogshown = false;

  Future<bool> checkinternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return Future.value(true);
      }
    } on SocketException catch (_) {
      return Future.value(false);
    }
  }

  @override
  void initState() {
    super.initState();
    checknet();
  }

  @override
  void dispose() {
    super.dispose();

    connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Name',
      home: Scaffold(
          appBar: AppBar(
            title: Text("Covid-19 Spread Accross India"),
            backgroundColor: Color(0xFFd50000),
          ),


          body: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              child: WebView(
                initialUrl: "https://maps.mapmyindia.com/corona",
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          )
      ),
    );
  }
void checknet() {
    ConnectivityResult _previousResult;

    bool dialogshown = false;
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connresult) {
      if (connresult == ConnectivityResult.none) {
        dialogshown = true;
        Nonet(context);
      } else if (_previousResult == ConnectivityResult.none) {
        checkinternet().then((result) {
          if (result == true) {
            if (dialogshown == true) {
              dialogshown = false;
              Navigator.pop(context);
            }
          }
        });
      }

      _previousResult = connresult;
    });
  }

}

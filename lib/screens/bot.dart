import 'package:clima/screens/world_screen.dart';
import 'package:connectivity/connectivity.dart';
import "package:flutter/material.dart";
import 'package:webview_flutter/webview_flutter.dart';
import 'package:clima/screens/location_screen.dart';
import 'dart:io';
import 'dart:async';
import 'noInternet.dart';

import 'about_app.dart';


class news extends StatefulWidget
{
  @override
  _newsState createState () => _newsState();

}

class _newsState extends State<news> {

  Future WorldScreen1(context) async {Navigator.push(
      context, MaterialPageRoute(builder: (context) => WorldScreen()));}

  Future aboutapp(context) async {Navigator.push(
      context, MaterialPageRoute(builder: (context) => about_app()));}


  Future locationscreen1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationScreen()));
  }
  Future Nonet(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => noInternet()));
  }

  StreamSubscription connectivitySubscription;
  bool dialogshown = false;

  Future<bool> checkinternet()async{
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
//          appBar: AppBar(
//            title: Text(''),
//          ),

            body: Padding(
                padding: const EdgeInsets.only(top: 30),

                child: Container(

                  child: WebView(
                    initialUrl: "https://inshorts.com/en/read/national",
                    javascriptMode:JavascriptMode.unrestricted,



                  ),
                )
            ))
    );
  }
  void  checknet() {
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
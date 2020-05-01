import 'package:clima/screens/location_screen.dart';
import 'package:clima/screens/youtube.dart';
import 'package:clima/widgets/my_header_world.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:io';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'noInternet.dart';
import 'about_app.dart';
import 'news.dart';

class WorldScreen extends StatefulWidget {

  @override
_WorldScreenState createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen> {


  Future LocationScreen1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationScreen()));
  }

  Future about_app1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => about_app()));
  }


  Future webAb(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => youtube()));
  }

  Future news1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => news()));
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

  Widget build(BuildContext context) {
    int _currentindex = 0;

    return MaterialApp(
      title: 'App Name',
      home: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: _currentindex,
          height: 70.0,
          items: <Widget>[
            Icon(Icons.public, size: 30, color: Color(0xFFd50000)),
            Icon(Icons.search, size: 30),
            Icon(Icons.library_books, size: 30),
            Icon(Icons.ondemand_video, size: 30),
            Icon(Icons.bug_report, size: 30),
          ],
          color: Colors.white70,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.black38,
          animationCurve: Curves.linearToEaseOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              switch (index) {
                case 1:
                  {
                    LocationScreen1(context);
                    _currentindex = index;
                  }
                  break;
                case 2:
                  {
                    webAb(context);
                    _currentindex = index;
                  }
                  break;
                case 3:
                  {
                    news1(context);
                    _currentindex = index;
                  }
                  break;
                case 4:
                  {
                    about_app1(context);
                    _currentindex = index;
                  }
                  break;
                default :
                  {
                    print("defalut");
                  }
                  break;
              }
            });
          },
        ),


        body: SingleChildScrollView(
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MyHeaderW(
                    image: "icons/coronadr.svg",
                    textTop: "World",
                    textBottom: "",
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: Container(
                      child: Image.asset('gif/worldmap.gif'),
                      height: 200.0,
                    ),
                  ),
                  Center(

                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                        child: Text("Countries Impacted by COVID-19 over time",

                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontSize: 12.0,

                            )
                        ),
                      )

                  ),
                ]
            ),

          ),
        ),

      ),
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

//        showDialog(
//            barrierDismissible: false,
//            context: context,builder: (_) => AssetGiffyDialog(
//          image: Image.asset('gif/Internet1.gif',height: 200,),
//          title: Text('Oppps connection lost ',
//            textAlign: TextAlign.center,
//            style: TextStyle(
//                fontSize: 15.0, fontWeight: FontWeight.w600),
//          ),
//          description: Text('Check your Internet Connection and try again',
//            textAlign: TextAlign.center,
//            style: TextStyle(),
//          ),
//          entryAnimation:EntryAnimation.TOP,
//          onlyOkButton: true,
//          onOkButtonPressed:() {
//            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//          },
//        ) );

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
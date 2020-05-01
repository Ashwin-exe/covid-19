import 'dart:async';
import 'dart:io';

import 'package:clima/screens/location_screen.dart';
import 'package:clima/screens/youtube.dart';
import 'package:clima/screens/world_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:clima/constant.dart';
import 'package:clima/widgets/my_header.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'news.dart';
import 'noInternet.dart';
class about_app extends StatefulWidget
{
  @override
  _about_appState createState () => _about_appState();

}
class _about_appState extends State<about_app> {
  Future WorldScreen1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorldScreen()));
  }

  Future news1(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => news()));
  }

  TextEditingController insertedValue = TextEditingController();

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
    int _currentindex = 3;
    return MaterialApp(
      title: 'About Covid-19',

      home: MaterialApp(
        title: 'App Name',
        home: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            index: _currentindex,
            height: 70.0,
            items: <Widget>[
              Icon(Icons.public, size: 30),
              Icon(Icons.search, size: 30),
              Icon(Icons.library_books, size: 30),
              Icon(Icons.ondemand_video, size: 30),
              Icon(Icons.bug_report, size: 30,color:Color(0xFF11249F)),
            ],
            color: Colors.white70,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.black38,
            animationCurve: Curves.linearToEaseOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                switch (index) {
                  case 0:
                    {
                      WorldScreen1(context);
                      _currentindex = index;

                    }
                    break;
                  case 1:
                    {
                      locationscreen1(context);
                      _currentindex = index;
                    }
                    break;
                  case 2:
                    {
                      news1(context);
                      _currentindex = index;
                    }
                    break;
                  case 3:
                    {
                      news1(context);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyHeader(
                  image: "icons/coronadr.svg",
                  textTop: "Get to know",
                  textBottom: "About Covid-19.",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Symptoms",
                        style: kTitleTextstyle,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SymptomCard(
                            image: "images/headache.jpg",
                            title: "Headache",
                            isActive: true,
                          ),
                          SymptomCard(
                            image: "images/cough.jpg",
                            title: "Caugh",
                          ),
                          SymptomCard(
                            image: "images/fever.jpg",
                            title: "Fever",
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SymptomCard(
                            image: "images/flu.jpg",
                            title: "Flu",
                            isActive: true,
                          ),
                          SymptomCard(
                            image: "images/breath.jpg",
                            title: "Out of Breath",
                          ),
                          SymptomCard(
                            image: "images/throat.jpg",
                            title: "Sore Throat",
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text("Prevention", style: kTitleTextstyle),
                      SizedBox(height: 20),
                      PreventCard(
                        text:
                        "Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks",
                        image: "images/wear_mask.jpg",
                        title: "Wear face mask",
                      ),
                      PreventCard(
                        text:
                        "Hand-washing with soap and water is a far more powerful weapon against germs than many of us realize.",
                        image: "images/wash_hands.jpg",
                        title: "Wash your hands",
                      ),
                      PreventCard(
                        text:
                        "Keeping space between yourself and other people outside of your home. Stay at least 6 feet from other people",
                        image: "images/distancing.jpg",
                        title: "Maintain Social Distancing",
                      ),
                      PreventCard(
                        text:
                        "Coronavirus: Don’t be a super-spreader. Stay home. Stay alive. #stayhome #staysafe",
                        image: "images/stayhome.jpg",
                        title: "Stay Home",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  checknet() {
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
    class PreventCard extends StatelessWidget {
    final String image;
    final String title;
    final String text;
    const PreventCard({
    Key key,
    this.image,
    this.title,
    this.text,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: SizedBox(
    height: 120,
    child: Stack(
    alignment: Alignment.centerLeft,
    children: <Widget>[
    Container(
    height: 200,
    width: double.infinity,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.white,
    boxShadow: [
    BoxShadow(
    offset: Offset(0, 8),
    blurRadius: 24,
    color: kShadowColor,
    ),
    ],
    ),
    ),
    Image.asset(image),
    Positioned(
    left: 130,
    child: Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical:1),
    height: 120,
    width: MediaQuery.of(context).size.width - 160,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
    Text(
    title,
    style: kTitleTextstyle.copyWith(
    fontSize: 15,
    ),
    ),
    Text(
    text,
    style: TextStyle(
    fontSize: 12,
    ),
    ),

    ],
    ),
    ),
    ),
    ],
    ),
    ),
    );
    }
    }

    class SymptomCard extends StatelessWidget {
    final String image;
    final String title;
    final bool isActive;
    const SymptomCard({
    Key key,
    this.image,
    this.title,
    this.isActive = false,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.all(6),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    boxShadow: [
    isActive
    ? BoxShadow(
    offset: Offset(0, 10),
    blurRadius: 20,
    color: kActiveShadowColor,
    )
        : BoxShadow(
    offset: Offset(0, 3),
    blurRadius: 6,
    color: kShadowColor,
    ),
    ],
    ),
    child: Column(
    children: <Widget>[
    Image.asset(image, height: 90),
    Text(
    title,
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    ],
    ),
    );
    }
    }

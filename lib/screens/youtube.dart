import "package:flutter/material.dart";
import 'package:webview_flutter/webview_flutter.dart';

class youtube extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("What is Covid-19 ?"),
          backgroundColor:Color(0xFFd50000),
        ),


        body: Container(
          child: WebView(
            initialUrl: "https://www.trackcorona.live/informed",
            javascriptMode:  JavascriptMode.unrestricted,
          ),
        )
    );

  }
}
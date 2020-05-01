import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Fetching {
  // Fetching(this.countryName);
  // final countryName;

  // Fetching() {
  //   getData(insertedValue);
  // }

  Future getData(String insertedValue) async {
    http.Response data =
        await http.get("https://corona.lmao.ninja/countries/$insertedValue");
    if (data.statusCode == 200) {
      return jsonDecode(data.body);
      // var country = jsonDecode(data.body)['country'];
      // var cases = jsonDecode(data.body)['cases'];
      // var todayCases = jsonDecode(data.body)['todayCases'];
      // var deaths = jsonDecode(data.body)['deaths'];
      // var todayDeaths = jsonDecode(data.body)['todayDeaths'];
      // var recovered = jsonDecode(data.body)['recovered'];
      // var active = jsonDecode(data.body)['active'];
      // var critical = jsonDecode(data.body)['critical'];
      // print("Country: $country");
      // print("Total Cases: $cases");
      // print("Today Cases: $todayCases");
      // print("Total Deaths: $deaths");
      // print("Today Deaths: $todayDeaths");
      // print("Recovered: $recovered");
      // print("Active: $active");
      // print("Critical: $critical");
    } else {
      AlertDialog(
        title: Text("No Data Found"),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import '../utils/globals.dart' as Globals;
import 'dart:io';
List list = List();
var isLoading = false;
//Future<Post> fetchPost() async {
//  final response =
//  await http.get('https://api.myjson.com/bins/f69dg');
//
//  if (response.statusCode == 200) {
//    // If the call to the server was successful, parse the JSON.
//    return Post.fromJson(json.decode(response.body));
//  } else {
//    // If that call was not successful, throw an error.
//    throw Exception('Failed to load post');
//  }
//}
//
//class Post {
//  final int userId;
//  final int id;
//  final String title;
//  final String body;
//
//  Post({this.userId, this.id, this.title, this.body});
//
//  factory Post.fromJson(Map<String, dynamic> json) {
//    return Post(
//      id: json['id'],
//      title: json['title'],
//
//    );
//  }
//}
//
//_fetchData() async {
//  setState(() {
//    isLoading = true;
//  });
//  final response =
//  await http.get("https://jsonplaceholder.typicode.com/photos");
//  if (response.statusCode == 200) {
//    list = json.decode(response.body) as List
//    setState(() {
//      isLoading = false;
//    });
//  } else {
//    throw Exception('Failed to load photos');
//  }
//}

Future<void> getCurrentLocation() async {

//  toastMessageBottom("Server requesting for location.");


// Platform messages may fail, so we use a try/catch PlatformException.
  try {
    var location = new Location();

    location.onLocationChanged().listen((LocationData currentLocation) {
      Globals.currentLat = currentLocation.latitude;
      Globals.currentLong = currentLocation.longitude;
    });
    String lat = "Latitude: " + Globals.currentLat.toString();
    String long = "Longitude: " + Globals.currentLong.toString();

//    toastMessageBottom("---  Sending Current Location --- \n\n" + lat +"\n\n" + long);
  } on PlatformException catch (e) {
    if (e.code == 'PERMISSION_DENIED') {
      Globals.toastMessage("Permission denied");
    }

  }
}


Future<void> checkConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//      Globals.toastMessage('connected');
      Globals.isConnected = true;
    }
  } on SocketException catch (_) {
//    Globals.toastMessage('not connected');
    Globals.isConnected = false;
  }
}
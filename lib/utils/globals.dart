import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms/sms.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_button/progress_button.dart';
import 'dart:io';
int currentIndex = 0;
MediaQueryData queryData;
double screenWidth  = 0;
double screenHeight = 0 ;
double currentLat = 0 ;
double currentLong = 0;
List <String> selectedServiceList ;
String selectedServices = "";
String selectedTech = "";
String serverNumber = "21589894";
String customerNumber = "+639431379554";
int selectedServiceCtr = 0;
var contactController = TextEditingController();
var messageController = TextEditingController();
bool isConnected = false;
int isSMSSent = 0 ;

//class SizeConfig {
//  static MediaQueryData _mediaQueryData;
//  static double screenWidth;
//  static double screenHeight;
//  static double blockSizeHorizontal;
//  static double blockSizeVertical;
//
//  void init(BuildContext context) {
//    _mediaQueryData = MediaQuery.of(context);
//    screenWidth = _mediaQueryData.size.width;
//    screenHeight = _mediaQueryData.size.height;
//    blockSizeHorizontal = screenWidth / 100;
//    blockSizeVertical = screenHeight / 100;
//  }
//}
void toastMessage(String msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIos: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 24.0
  );
}
void toastMessageBottom(String msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 24.0
  );
}

Widget widgetButton(title , VoidCallback method){
  return ProgressButton(
    onPressed: method,
    child: Text(title , style: TextStyle(color: Colors.white),),
    backgroundColor: Colors.indigoAccent,
  );
}


import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms/sms.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import '../utils/globals.dart' as Globals;
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
void receiveSMS() {
  SmsReceiver receiver = new SmsReceiver();
  receiver.onSmsReceived.listen(( SmsMessage msg) => validateRequest(msg.address , msg.body) );
}

void triggerSMS(){
//  _sendSMS(messageController.text.toString()  , contactController.text.toString());
}
void sendSMS(String msg , String receiver){
  SmsSender sender = new SmsSender();
  String address = receiver ;
  SmsMessage message = new SmsMessage(address, msg);
  message.onStateChanged.listen((state) {
    if (state == SmsMessageState.Sent) {
//      print("SMS is sent!");
//      toastMessage("SMS is sent!");
      Globals.isSMSSent = 1 ;

    } else if (state == SmsMessageState.Delivered) {
      print("SMS is delivered!");
      toastMessage("SMS is delivered!");
    } else if(state == SmsMessageState.Fail){

      Globals.isSMSSent = 2 ;
    }
  });
  sender.sendSms(message);
}



void validateRequest(address , message){
//    toastMessageBottom("New Message Recieved from :" + address + "\n\n" + message);
  if (message.toString().toLowerCase().contains("location")){
    getCurrentLocation();
  }else{
//     toastMessageBottom("Server is requesting for someting else.");
  }


}
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

      toastMessage("Permission denied");
    }

  }
}
Future<void> getSMS() async {
  //toastMessage("Getting SMS");
  SmsQuery query = new SmsQuery();
  List<SmsMessage> messages = await query.getAllSms;
  List<SmsMessage> msg = await query.querySms(address: "21589894");

  Globals.toastMessage("RECEIVED getSMS() : " + msg.first.body);
//    List<SmsThread> threads = await query.getAllThreads;
//    Contact contac//    //toastMessage(messages.first.address);
//
//t = threads.first.contact;
}

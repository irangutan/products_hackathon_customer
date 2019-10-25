import 'package:flutter/material.dart';
import '../utils/globals.dart' as Globals;
import '../utils/api_helper.dart' as APIHelper;
import '../utils/sms_methods.dart' as SMS ;
import 'review.dart' as ReviewScreen;
import 'request.dart' as RequestScreen;
import 'list_request.dart' as ListRequestScreen;
import 'main.dart' as MainScreen;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'success.dart' as SuccessScreen;
void main() => runApp(SubmitRequestScreen());

class SubmitRequestScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SubmitRequestProgressPage(title: 'List of Service Request'),
    );
  }
}

class SubmitRequestProgressPage extends StatefulWidget {
  SubmitRequestProgressPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SubmitRequestProgressPageState createState() => _SubmitRequestProgressPageState();
}

class _SubmitRequestProgressPageState extends State<SubmitRequestProgressPage> {

  @override
  void initState() {

    APIHelper.getCurrentLocation();
    submitRequest();
    super.initState();
//    post = fetchPost();

  }
  void submitRequest(){

      String message ;
      String receiver ;
      String front_msg = 'Your service request has been submitted. \n';
      String selectedServiceListStr = Globals.selectedServiceList.toString().replaceAll(new RegExp(r"\s+\b|\b\s"), "");
      selectedServiceListStr = selectedServiceListStr.substring(1);
      selectedServiceListStr = selectedServiceListStr.substring(0 , selectedServiceListStr.length -1 );
      String req_ser = "request_new_${selectedServiceListStr}_${Globals.currentLat},${Globals.currentLong}" ;
      String server_front_msg = "I am looking for someone to fix my ${selectedServiceListStr}. I am currently in {Globals.currentLat},${Globals.currentLong}\n";
      message = server_front_msg + '\n\n'+ req_ser;

      APIHelper.getCurrentLocation();

//    if(currentLong == 0.0 || currentLat == 0.0){
//      toastMessage("Error retrieving current location. Please try again.");
//    }else{



        APIHelper.getCurrentLocation();
        SMS.sendSMS(message, Globals.serverNumber);

        Future.delayed(const Duration(milliseconds: 3000), () {

          setState(() {
            // Here you can write your code for open new view
            if(Globals.isSMSSent == 1){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SuccessScreen.SuccessRequestScreen()),

              );
              Globals.isSMSSent = 0;
            }
            if(Globals.isSMSSent == 2){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReviewScreen.ReviewScreen()),

              );

            }
          });
        });
//

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SpinKitFadingCube(
              color: Colors.indigoAccent,
              size: MediaQuery.of(context).size.width / 2 ,
            ) ,
            Padding(
              padding: new EdgeInsets.only(top: 55),
              child: Text("Submitting service request..." , style: TextStyle(fontSize: 20),) ,
            ),

//            Loading(indicator: BallPulseIndicator(), size: 100.0)
          ],
        ),
      ),

    );
  }
}

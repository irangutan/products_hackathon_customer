import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/globals.dart' as Globals;
import '../utils/api_helper.dart' as APIHelper;
import '../utils/sms_methods.dart' as SMS;
import 'splash.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:mobile_popup/mobile_popup.dart';
import 'package:sms/sms.dart';
import 'package:flutter/scheduler.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() => runApp(ListRequestScreen());

class ListRequestScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: ListRequestPage(title: 'List of Service Request'),
    );
  }
}

class ListRequestPage extends StatefulWidget {
  ListRequestPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ListRequestPageState createState() => _ListRequestPageState();
}

class _ListRequestPageState extends State<ListRequestPage> {
  List<Widget> listWidgetMsg = new List<Widget>();
  @override
  void initState() {

    // Here you can write your code for open new view
    triggerGetSMS();
    APIHelper.getCurrentLocation();
    setState(() {
      Globals.currentIndex = 1;
      listWidgetMsg.add(Text("Loading..."));
    });
    super.initState();
//    post = fetchPost();
  }

  void triggerGetSMS() {
    Future.delayed(const Duration(milliseconds: 500), () {
      getSMS();
    });
  }

  Future<void> getSMS() async {
    SmsQuery query = new SmsQuery();
    List<SmsMessage> messages = await query.getAllSms;
    List<SmsMessage> msg = await query.querySms(
        address: Globals.serverNumber,
        kinds: [SmsQueryKind.Sent, SmsQueryKind.Inbox]);

    setState(() {
      listWidgetMsg.clear();

      if(!msg[0].body.toString().contains("completed")){
        Globals.isHaveRequest = 1;
        listWidgetMsg.add(Container(
          alignment: Alignment.topCenter,
          padding: new EdgeInsets.only(
//          top: MediaQuery.of(context).size.height * .58,
              right: 20.0,
              left: 20.0),
          child: new Container(
            width: MediaQuery.of(context).size.width,
            child: new Card(
              color: Colors.white,
              elevation: 4.0,
              child: Column( children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "Request Service last update.",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 25  ,fontWeight: FontWeight.bold ),
                    )) ,
                Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      msg[0].body.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20),
                    ))
              ],)


              ,
            ),
          ),
        ));
      }else{
        Globals.isHaveRequest = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
//    WidgetsBinding.instance.addPostFrameCallback((_){
//      setState(() {
////        getSMS();
//      });
//
//    });
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the ListRequestPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: new SingleChildScrollView(
              child: new Column(
                  children: <Widget>[Column(children: listWidgetMsg)]))),
//      floatingActionButton: FloatingActionButton(
//        onPressed:  ,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

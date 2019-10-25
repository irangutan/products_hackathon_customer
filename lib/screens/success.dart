import 'package:flutter/material.dart';
import '../utils/globals.dart' as Globals;
import '../utils/api_helper.dart' as APIHelper;
import '../utils/sms_methods.dart' as SMS ;
import 'review.dart' as ReviewScreen;
import 'request.dart' as RequestScreen;
import 'list_request.dart' as ListRequestScreen;
import 'main.dart' as MainScreen;
void main() => runApp(SuccessRequestScreen());

class SuccessRequestScreen extends StatelessWidget {
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
      home: SuccessRequestPage(title: 'List of Service Request'),
    );
  }
}

class SuccessRequestPage extends StatefulWidget {
  SuccessRequestPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SuccessRequestPageState createState() => _SuccessRequestPageState();
}

class _SuccessRequestPageState extends State<SuccessRequestPage> {

  @override
  void initState() {
    Globals.selectedServiceList = [];
    APIHelper.getCurrentLocation();
    super.initState();
//    post = fetchPost();
  }
  void returnRequestScreen(){

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RequestScreen.RequestScreen ()),
    );
  }
  void gotoList() {


    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListRequestScreen.ListRequestScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the SuccessRequestPage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black )),
//        backgroundColor: Colors.white,
//      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Colors.indigoAccent,
                  size: 250.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),

              ],
            ) ,
            Text("Your request service has been submitted." , style: TextStyle(fontSize: 20),) ,
            Padding(
                padding: EdgeInsets.all(20.0),
                child : Globals.widgetButton("GO TO SERVICE REQUEST LIST" , gotoList) ,


            ),
          Padding(
              padding: EdgeInsets.all(20.0),
              child : Globals.widgetButton("CREATE NEW REQUEST" , returnRequestScreen) ,
          )


      ],

        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

import 'package:flutter/material.dart';
import 'package:products_hackaton/utils/globals.dart';
import 'package:progress_button/progress_button.dart';
import 'splash.dart';
import '../utils/api_helper.dart' as APIHelper;
import '../utils/globals.dart' as Globals;
import '../utils/sms_methods.dart' as SMS;
import 'package:flutter/cupertino.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'request.dart' as RequestScreen;
import 'success.dart' as SuccessScreen;
import 'submit_request_progress.dart' as SubmitRequestScreen ;
void main() => runApp(ReviewScreen());

class ReviewScreen extends StatelessWidget {
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
      home: MyHomePage(title: 'Review'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class Technicians {
  const Technicians(this.name);

  final String name;
}
class _MyHomePageState extends State<MyHomePage> {

  bool chkBol = false;

  @override
  void initState() {
    setState(() {
      if (Globals.isSMSSent == 2){
        toastMessage("Unable to send text. Please make sure that you have enough balance.");
        Globals.isSMSSent = 0;
      }
    });
    super.initState();
//    post = fetchPost();

  }
  void pushSelectedService(String service){
    toastMessage(service);
  }

  void pushSelectedTech(String tech){
    toastMessage(tech);
  }
  void returnRequestScreen(){

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RequestScreen.RequestScreen ()),
    );
  }
  void submitRequest(){

    APIHelper.getCurrentLocation();

//    if(currentLong == 0.0 || currentLat == 0.0){
//      toastMessage("Error retrieving current location. Please try again.");
//    }else{


    if(Globals.currentLong == 0.0 || Globals.currentLat == 0.0){
      Globals.toastMessage("Error retrieving current location. Please try again.");
    }else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SubmitRequestScreen.SubmitRequestScreen()),

      );
    }




//      if(Globals.isSMSSent == 1){
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => SuccessScreen.SuccessRequestScreen()),
//
//        );
//        Globals.isSMSSent = 0;
//      }

//    }

  }

//
//  Widget widgetCheckBox(title){
//
//    return  Column(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        Text(title , style: TextStyle(color: Colors.black),),
//        Checkbox(
//          value: chkBol,
//          onChanged: (bool value) {
//          setState(() {
//            chkBol = value;
//                if (value == true) {
//                    toastMessage(title);
//                }
//            });
//          },
//        ),
//      ],
//    );
//
//  }
  Widget widgetChkGroup(){
    return CheckboxGroup(
        labels: <String>[
          "Service 1",
          "Service 2",
          "Service 3",
          "Service 4",
          "Service 5",
          "Service 6",
          "Service 7",
        ],
        disabled: [
//        "Wednesday",
//        "Friday"
        ],
        onChange: (bool isChecked, String label, int index) => print("isChecked: $isChecked   label: $label  index: $index"),
//      onSelected: (List<String> checked) => print("checked: ${checked.toString()}"),
        onSelected: (List<String> checked) => toastMessage("checked: ${checked.toString()}")
    ) ;
  }
  Widget widgetDropdown(){

    int _user;
    var users = <String>[
      'Technician 1',
      'Technician 2',
      'Technician 3',
    ];

    return new DropdownButton<String>(
      hint: new Text('Please select'),
      value: _user == null ? null : users[_user],
      items: users.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _user = users.indexOf(value);
          toastMessage(value);
        });
      },
    );
  }

  Widget widgetCard(Widget widgetChild){
    return   Container(
      alignment: Alignment.topCenter,
      padding: new EdgeInsets.only(
//          top: MediaQuery.of(context).size.height * .58,
          right: 20.0,
          left: 20.0),
      child: new Container(

        height: 200.0,
        width: MediaQuery.of(context).size.width,
        child: new Card(
          color: Colors.white,
          elevation: 4.0,
          child: widgetChild ,
        ),
      ),
    ) ;
  }
  Widget widgetListView(Widget widgetChild){
    return SingleChildScrollView(
        child: new Column(
            children: <Widget>[
              Wrap(
                spacing: 8.0, // gap between adjacent chips
                runSpacing: 4.0, // gap between lines
                children: <Widget>[
                  widgetChild

                ],
              )
            ]
        )
    ) ;
  }

  Widget getSelectedServices(){
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < selectedServiceList.length; i++){
//      list.add(new Text(selectedServiceList[i]));
        list.add(
            Padding(
                padding: EdgeInsets.all(2.0),
                child :
                Text (selectedServiceList[i],
                  textAlign: TextAlign.right , style: TextStyle( fontSize: 20),)
            )
//            new Card(
//              child: new Column(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
//                children: <Widget>[
//                  Text(selectedServiceList[i] , style: TextStyle(color: Colors.red),)
//                ],
//              ),
//            )
        );
    }
//    return  Row(children: list);
    return new Column(children: list) ;
  }

  Widget widgetSummary(){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child :
          Text ("Summary of Request " ,
            textAlign: TextAlign.right , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25),),

        ),

        Padding(
          padding: EdgeInsets.all(20.0),
          child :
          Text ("Selected Services" ,
            textAlign: TextAlign.center , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
        ),
        Padding(
            padding: EdgeInsets.all(20.0),
            child :
            getSelectedServices()
        ),

      ],
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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black )),
        backgroundColor: Colors.white,

      ),
      body: Center (

          child: new SingleChildScrollView(
              child: new Column(
                  children: <Widget>[
                    Wrap(
//                      spacing: 8.0, // gap between adjacent chips
//                      runSpacing: 4.0, // gap between lines
                      children: <Widget>[
                        Container(
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
                              child:
                              new Column(
                                children: <Widget>[
                                  widgetSummary()
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(20.0),
                            child :widgetButton("SUBMIT REQUEST" , submitRequest )
                        ) ,
                        Padding(
                            padding: EdgeInsets.all(20.0),
                            child :widgetButton("BACK TO REQUEST PAGE" , returnRequestScreen )
                        )
                      ],
                    )
                  ]
              )
          )

      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

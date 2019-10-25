import 'package:flutter/material.dart';
import 'package:products_hackaton/utils/globals.dart';
import 'package:progress_button/progress_button.dart';
import 'splash.dart';
import '../utils/api_helper.dart';
import '../utils/globals.dart' as Globals;
import 'package:flutter/cupertino.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'review.dart' as ReviewScreen;
import 'package:sms/sms.dart';
void main() => runApp(RequestScreen());

class RequestScreen extends StatelessWidget {
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
      home: MyHomePage(title: 'Request A Service'),
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
  int _counter = 0;
  bool chkBol = false;
  bool body_bool = false;
  String isHaveRequestMsg = "";
//  Future<Post> post;
  @override
  void initState() {
    Globals.currentIndex = 0;

    triggerGetSMS();

    super.initState();
//    post = fetchPost();
  }

  void pushSelectedService(List <String> service){
//   / toastMessage(service);
    selectedServiceList = service ;
    selectedServiceCtr = selectedServiceList.length;
  }

  void pushSelectedTech(String tech){
    selectedTech = tech;
  }
  void moveToReview(){
    if(selectedServiceCtr < 0 || selectedServiceCtr == 0){
      toastMessage("Please select at least 1 service / appliance");
    }else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ReviewScreen.ReviewScreen()),

      );
    }

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
          "Television",
          "Refrigerator"
        ],
        disabled: [
//        "Wednesday",
//        "Friday"
        ],
//      checked: selectedServiceList,
        onChange: (bool isChecked, String label, int index) => print("isChecked: $isChecked   label: $label  index: $index"),
//      onSelected: (List<String> checked) => print("checked: ${checked.toString()}"),
        onSelected: (List<String> checked) =>  pushSelectedService(checked)
//       toastMessage("checked: ${checked.toString()}")
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
          pushSelectedTech(value);
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


      if(!msg[0].body.toString().contains("completed")){
        Globals.isHaveRequest = 1;

      }else{
        Globals.isHaveRequest = 0;
      }


      if(Globals.isHaveRequest == 1){
        toastMessage("Not able to create a service request.");
        body_bool = true;
        setState(() {
          isHaveRequestMsg = "Not able to create a service request.";
        });
      }

    });
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
      body: Center(
        child: AbsorbPointer (
            absorbing: body_bool ,
            child: new SingleChildScrollView(
                child: new Column(
                    children: <Widget>[
                      Wrap(
                        spacing: 8.0, // gap between adjacent chips
                        runSpacing: 4.0, // gap between lines
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(20.0),
                              child :
                              Text ("Select an Appliance " ,
                                textAlign: TextAlign.right , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),)
                          )

                          ,
                          widgetCard ( widgetListView(widgetChkGroup()) ) ,
//            Padding(
//                padding: EdgeInsets.all(20.0),
//                child :
//                Text ("Select a Technician " ,
//                  textAlign: TextAlign.right , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),)
//            ) ,
//            widgetDropdown(),
                          Padding(
                              padding: EdgeInsets.all(20.0),
                              child :widgetButton("PROCEED" , moveToReview)

                          ) ,
                          Padding(
                              padding: EdgeInsets.all(20.0),
                              child : Text ('${isHaveRequestMsg}')

                          )

                        ],
                      )
                    ]
                )
            )
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

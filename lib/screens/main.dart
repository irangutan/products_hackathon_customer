import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart' show BottomNavyBar, BottomNavyBarItem;
import 'home.dart' as HomeScreen;
import 'request.dart' as RequestScreen;
import 'list_request.dart' as ListRequestScreen;
import '../utils/Globals.dart' as Globals;
import '../utils/sms_methods.dart' as sms_methods;
import '../utils/api_helper.dart' as APIHelper;
void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    screenWidth = MediaQuery.of(context).size.width;
//    screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          accentColor: Colors.blue
      ),
      home: MyHomePage(title: 'Tracking Services'),
    );
  }

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int bottomSelectedIndex = 0;

  int _counter = 0;
  List<Widget> _pages;
  Widget _homePage;
  Widget _shipmentsPage;
  Widget _currentPage;

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
      _currentPage = _homePage;
    });
  }
  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;

      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        RequestScreen.RequestScreen(),
        ListRequestScreen.ListRequestScreen(),

//        Shipments(),
//        Notifications(),
//        SendSms()
//        Yellow(),
      ],
    );
  }

  @override
  void initState() {
    APIHelper.checkConnection();
    Globals.currentIndex = 0;
    sms_methods.receiveSMS();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
      body: buildPageView(),
      // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: Globals.currentIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          Globals.currentIndex = index;
          bottomTapped(index);
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Request'),
            activeColor: Colors.indigo,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.format_list_bulleted),
              title: Text('Request List'),
              activeColor: Colors.indigo
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Profile'),
              activeColor: Colors.indigo
          ),

//          BottomNavyBarItem(
//              icon: Icon(Icons.notifications),
//              title: Text('Notifications'),
//              activeColor: Colors.indigo
//          ),
//          BottomNavyBarItem(
//              icon: Icon(Icons.sms),
//              title: Text('Messaging'),
//              activeColor: Colors.indigo
//          ),
        ],
      ),
    );
  }
}







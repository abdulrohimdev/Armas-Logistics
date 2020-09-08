import 'dart:convert';
import 'package:Armas/source/AppScreen/Page/AccountScreen.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../MessageCode.dart';
import '../ApiUrl.dart';
import 'Page/HomeScreen.dart';
import 'package:flutter/services.dart';
class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AccountScreen(),    
    AccountScreen(),    
  ];

  DateTime currentBackPressTime;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print(exit_warning);
      Fluttertoast.showToast(
          msg:exit_warning,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);

      return Future.value(false);
    }
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
  }

  Widget getBody() {
    return _widgetOptions.elementAt(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: WillPopScope(child: getBody(), onWillPop: onWillPop),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(AntDesign.home, size: 25.0),
            title: Text('Home'),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(AntDesign.earth, size: 25.0),
          //   title: Text('Connect'),
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              AntDesign.user,
              size: 25.0,
            ),
            title: Text('Account'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFe64c4c),
        onTap: _onItemTapped,
      ),
    );
  }
}

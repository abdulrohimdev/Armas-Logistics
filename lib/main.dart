import 'package:Armas/source/AuthScreen/PasswordConnectionWithoutBack.dart';
import 'package:flutter/material.dart';
import './source/MainScreen/MainScreen.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './source/MainScreen/Splash.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;
  @override
  void initState() {
    super.initState();
    _isLogin();
  }

  Future _isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getBool('isLogedIn'));
    if (prefs.getBool('isLogedIn') != null) {
      setState(() {
        isLogin = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xffe64c4c)));

    return MaterialApp(
      title: 'My Armas',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      // home: _loginStatus == LoginStatus.notSignin ? new MainPage() : SigninWithPasswordWithoutBack(),
      home: Splash(isLogin),
      
    );
  }
}


import 'package:Armas/source/AuthScreen/PasswordConnectionWithoutBack.dart';
import 'package:flutter/material.dart';
import './MainScreen.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
class Splash extends StatefulWidget {
  final bool isLogin;
  Splash(this.isLogin);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => widget.isLogin ? SigninWithPasswordWithoutBack() : MainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Center(
                child: Image(
                  image: AssetImage('assets/img/logo-armas.png'),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text("PT. ARMAS LOGISTICS SERVICE",
                    style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 5.0,
              ),
              Center(
                child: Text("Pelanggan Puas, Majulah ARMAS!",
                    style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 40.0,
              ),
              CircularProgressIndicator()
              // SizedBox(
              //   child: TextLiquidFill(
              //         text: 'PT. ARMAS LOGISTIC SERVICE',
              //         waveColor: Colors.redAccent,
              //         boxBackgroundColor: Colors.white,
              //         textStyle: TextStyle(
              //           fontSize: 14.0,
              //           fontWeight: FontWeight.bold,
              //         ),
              //         boxHeight: 40.0,
              //   ),
              // ),
            ],
          ),
        ));
  }
}

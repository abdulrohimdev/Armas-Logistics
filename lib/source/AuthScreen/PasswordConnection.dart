import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../MessageCode.dart';
import '../AppScreen/AppScreen.dart';
import '../ApiUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SigninWithPassword extends StatefulWidget {
  @override
  _SigninWithPasswordState createState() => _SigninWithPasswordState();
}

class _SigninWithPasswordState extends State<SigninWithPassword> {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  ProgressDialog progressDialog;
  TextEditingController password = new TextEditingController();
  String deviceID;
  String deviceInfo;

  _deviceInfo() async {
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    deviceID = androidInfo.androidId;
    deviceInfo = androidInfo.model;
  }

  void _submit() async {
    if (password.text != '') {
      progressDialog.show();
      var body = jsonEncode({
        "password": password.text,
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authTokenID = prefs.getString("authToken");
      http.Response response = await http.post(login,
          headers: {
            'Accept': 'application/json',
            'Auth': authTokenID,
            'Device': deviceID
          },
          body: body);
      print(response.body);
      var result = json.decode(response.body);
      if (result['status'] == true) {
        setState(() {
          prefs.setBool("isLogedIn", true);         
        });
        Future.delayed(Duration(seconds: 0)).then((value) {
          progressDialog.hide().whenComplete(() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AppScreen()),
            );
          });
        });
      } else {
        Future.delayed(Duration(seconds: 3)).then((value) {
          progressDialog.hide().whenComplete(() {
            Fluttertoast.showToast(
                msg: result['message'],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        });
      }
      print(authTokenID);

    } else {
      Fluttertoast.showToast(
          msg: fieldCantEmpty,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

  }

  Widget formSignin() {
    return Container(
      padding: EdgeInsets.all(35.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: password,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            cursorColor: Color(0xFF7d7d7d),
            style: GoogleFonts.roboto(fontSize: 15.0, color: Color(0xFF7d7d7d)),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFf7f5f5),
              hintStyle:
                  GoogleFonts.roboto(fontSize: 15.0, color: Color(0xFF7d7d7d)),
              contentPadding: EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
              hintText: "Input Your Password",
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
              onTap: () {
                _submit();
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(2, 4),
                            blurRadius: 5,
                            spreadRadius: 2)
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xffff6e6e), Color(0xffe64c4c)])),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Center(
                          child: new Text('Connect',
                              style: new TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ))),
                    ],
                  ))),
        ],
      ),
    );
  }

  Widget title() {
    return Column(
      children: <Widget>[
        new Container(
            padding: EdgeInsets.only(left: 35.0, bottom: 10.0),
            alignment: Alignment.centerLeft,
            child: new Text("Sign In",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500, fontSize: 30.0))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceInfo();
    progressDialog = ProgressDialog(context,
        isDismissible: false, type: ProgressDialogType.Normal);
    progressDialog.style(message: "Loading");

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          elevation: 0.0,
          titleSpacing: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.red,
                  size: 35.0,
                ),
              ),
              new Text('Back',
                  style: new TextStyle(color: Colors.red)) // Your widgets here
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            title(),
            formSignin(),
          ],
        )));
  }
}

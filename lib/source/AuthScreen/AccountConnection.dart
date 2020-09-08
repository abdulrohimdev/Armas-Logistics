import 'dart:convert';
import 'package:Armas/source/AuthScreen/PasswordConnectionWithoutBack.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../ApiUrl.dart';
import '../MessageCode.dart';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'PasswordConnection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountConnection extends StatefulWidget {
  @override
  _AccountConnectionState createState() => _AccountConnectionState();
}

class _AccountConnectionState extends State<AccountConnection> {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  ProgressDialog progressDialog;
  String deviceID;
  String deviceInfo;
  final format = DateFormat("dd-MM-yyyy");
  TextEditingController empid = new TextEditingController();
  TextEditingController numberId = new TextEditingController();
  TextEditingController bornDate = new TextEditingController();

  _deviceInfo() async {
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    deviceID = androidInfo.androidId;
    deviceInfo = androidInfo.model;
  }

  void _submit() async {
    if (empid.text != '' && bornDate.text != '' && numberId.text != '') {
      progressDialog.show();
      var body = jsonEncode({
        "employee_id": empid.text,
        "birthday": bornDate.text,
        "id_number": numberId.text,
        "device_id": deviceID,
        "device_name": deviceInfo
      });

      http.Response response = await http.post(register,
          headers: {'Accept': 'application/json'}, body: body);
      var result = json.decode(response.body);
      if (result['status'] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        setState(() {
          prefs.setString('authToken', result['results']['auth']);
          prefs.setString('employeeToken', result['results']['employee']);
          prefs.setString('employeeID', result['results']['employee_id']);   
          prefs.setBool("isLogedIn", true);         

        });
        Future.delayed(Duration(seconds: 0)).then((value) {
          progressDialog.hide().whenComplete(() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SigninWithPasswordWithoutBack()),
            );
          });
        });
      } else {
        Future.delayed(Duration(seconds: 3)).then((value) {
          progressDialog.hide().whenComplete(() {
            Fluttertoast.showToast(
                msg: msgFailedLogin,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        });
      }
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

  Widget title() {
    return Column(
      children: <Widget>[
        new Container(
            padding: EdgeInsets.only(left: 35.0, bottom: 10.0),
            alignment: Alignment.centerLeft,
            child: new Text("Lets Go",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500, fontSize: 30.0))),
        new Container(
            padding: EdgeInsets.only(left: 35.0, right: 35.0),
            child: new Text(
                "it seems as this is your first time using our app. Please enter your Employee ID,    ID Number, and Born Date so We can validate that you are part of our family.",
                style: GoogleFonts.josefinSans(
                    fontSize: 18.0, color: Colors.grey))),
      ],
    );
  }

  Widget formRegister() {
    return Column(
      children: <Widget>[
        TextField(
          controller: empid,
          keyboardType: TextInputType.number,
          obscureText: false,
          cursorColor: Color(0xFF7d7d7d),
          style: GoogleFonts.roboto(fontSize: 15.0, color: Color(0xFF7d7d7d)),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFf7f5f5),
            hintStyle:
                GoogleFonts.roboto(fontSize: 15.0, color: Color(0xFF7d7d7d)),
            contentPadding: EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
            hintText: "Employee ID",
            border: InputBorder.none,
            // focusedBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            //   borderRadius: BorderRadius.circular(7.0),
            // ),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: numberId,
          keyboardType: TextInputType.number,
          obscureText: false,
          cursorColor: Color(0xFF7d7d7d),
          style: GoogleFonts.roboto(fontSize: 15.0, color: Color(0xFF7d7d7d)),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFf7f5f5),
            hintStyle:
                GoogleFonts.roboto(fontSize: 15.0, color: Color(0xFF7d7d7d)),
            contentPadding: EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
            hintText: "ID Number",
            border: InputBorder.none,
            // focusedBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            //   borderRadius: BorderRadius.circular(7.0),
            // ),
          ),
        ),
        SizedBox(height: 20.0),
        DateTimeField(
          controller: bornDate,
          keyboardType: TextInputType.text,
          format: format,
          style: GoogleFonts.roboto(fontSize: 15.0, color: Color(0xFF7d7d7d)),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFf7f5f5),
            hintStyle:
                GoogleFonts.roboto(fontSize: 15.0, color: Color(0xFF7d7d7d)),
            contentPadding: EdgeInsets.fromLTRB(13.0, 13.0, 13.0, 13.0),
            hintText: "Born Date",
            border: InputBorder.none,
            // focusedBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            //   borderRadius: BorderRadius.circular(7.0),
            // ),
          ),
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
        ),
        SizedBox(
          height: 20,
        ),
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
            new Container(padding: EdgeInsets.all(35.0), child: formRegister()),
          ],
        )));
  }
}

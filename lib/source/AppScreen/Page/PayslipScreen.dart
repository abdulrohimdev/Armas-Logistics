import 'package:flutter/material.dart';
import 'package:Armas/source/AppScreen/Page/subPagePayslip/MainPayslip.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class PayslipScreen extends StatefulWidget {
  @override
  _PayslipScreenState createState() => _PayslipScreenState();
}

class _PayslipScreenState extends State<PayslipScreen> {
  var now = new DateTime.now();
  int year;
  TextEditingController yearDate = new TextEditingController();

  tuningYear() async {
    // _selectDate(context);
    await showModalBottomSheet<int>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return _buildItemPicker();
      },
    );
  }

  Widget _buildItemPicker() {
    return Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(50.0),
              topRight: const Radius.circular(50.0))),
      height: MediaQuery.of(context).size.height / 1.5,
      padding: EdgeInsets.only(top: 0.0, left: 50.0, right: 50.0),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 1.5,
          ),
          Container(
            height: 5.0,
            width: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            // color:Colors.grey,
          ),
          SizedBox(
            height: 50.0,
          ),
          // Text("Input Year", style: GoogleFonts.josefinSans(fontSize: 25.0)),
          TextField(
            controller: yearDate,
            cursorColor: Color(0xFF7d7d7d),
            autofocus: true,
            keyboardType: TextInputType.number,
            style: GoogleFonts.roboto(fontSize: 15.0, color: Color(0xFF7d7d7d)),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFf7f5f5),
              hintStyle:
                  GoogleFonts.roboto(fontSize: 15.0, color: Color(0xFF7d7d7d)),
              contentPadding: EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
              hintText: "Enter Year",
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          ButtonTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.red)),
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  year = int.parse(yearDate.text);
                  yearDate.clear();
                });
                Navigator.of(context).pop();
              },
              child: Text(
                "UPDATE",
                style: GoogleFonts.josefinSans(
                    color: Colors.white, fontSize: 17.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          titleSpacing: 0.0,
          elevation: 0.0,
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
                  style: new TextStyle(color: Colors.red)), // Your widgets here
            ],
          ),
          // actions: <Widget>[
          //   IconButton(
          //     onPressed: () => tuningYear(),
          //     icon: Icon(
          //       AntDesign.filter,
          //       color: Colors.black,
          //     ),
          //     padding: EdgeInsets.only(right: 20.0),
          //     tooltip: 'Update Year',
          //   ),
          // ],
        ),
        body: MainPayslip(
          year,
        ));
  }
}

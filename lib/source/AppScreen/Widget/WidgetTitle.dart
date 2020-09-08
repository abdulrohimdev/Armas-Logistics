import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetTitle extends StatefulWidget {
  @override
  _WidgetTitleState createState() => _WidgetTitleState();
}

class _WidgetTitleState extends State<WidgetTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
      padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
      decoration: BoxDecoration(
          color: Color(0xFFebe8e8), borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          Center(
            child: Text("Quote of the day",
                style: GoogleFonts.josefinSans(fontSize: 18.0)),
          ),
          SizedBox(height: 10.0),
          Center(
            child: Text('"Keep Moving Forward!"',
                style: GoogleFonts.josefinSans(fontSize: 25.0)),
          ),
        ],
      ),
    );
  }
}

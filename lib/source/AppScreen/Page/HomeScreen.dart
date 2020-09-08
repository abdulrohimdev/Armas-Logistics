import 'dart:convert';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:device_info/device_info.dart';
// import 'package:flutter_session/flutter_session.dart';
// import 'package:http/http.dart' as http;
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../Widget/WidgetTitle.dart';
import '../Widget/WidgetMenu.dart';
import '../Widget/WidgetAnnouncement.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _line() {
    return Container(
      color: Colors.grey[300],
      width: MediaQuery.of(context).size.width,
      height: 0.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
        child: Column(
          children: <Widget>[
            WidgetTitle(),
            SizedBox(height: 10.0),
            _line(),
            Container(child: WidgetMenu()),
            _line(),
            Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    left: 25.0, right: 25.0, top: 10.0, bottom: 15.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Announcement",
                      style: GoogleFonts.josefinSans(
                          fontSize: 25.0, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      alignment: Alignment.centerRight,
                      child: Text(
                        "See All",
                        style: GoogleFonts.montserrat(fontSize: 18.0,color:Color(0xFF7595bf)),
                      ),
                    ),
                  ],
                )),
            _line(),
            WidgetAnnouncement()
          ],
        ),
      ),
    );
  }
}

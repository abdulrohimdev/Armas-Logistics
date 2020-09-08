import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class WidgetAnnouncement extends StatefulWidget {
  @override
  _WidgetAnnouncementState createState() => _WidgetAnnouncementState();
}

class _WidgetAnnouncementState extends State<WidgetAnnouncement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left:20.0,right:20.0,bottom:10.0,top:20.0),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Image(image: AssetImage("assets/img/headerImage.png"),),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left:20.0,right:20.0),
            width: MediaQuery.of(context).size.width,
            child: new Text("Company Announcement",
              style: GoogleFonts.josefinSans(
                fontSize: 18.0,
                fontWeight: FontWeight.w600 
              )
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left:20.0,top:5.0,right:20.0),
            width: MediaQuery.of(context).size.width,
            child: new Text(
              "What l've announced today, is our new Future Tech Trade Strategy, and this is all about attracting more investment from arround the world into technologies.",
              style: GoogleFonts.montserrat(
                fontSize: 14.0,
                color: Color(0xFF91908e)
              )
            ),
          ),
        ],
      ),
    );
  }
}

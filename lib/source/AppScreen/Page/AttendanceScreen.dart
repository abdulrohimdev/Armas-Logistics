import 'package:Armas/source/AppScreen/Page/subPageAttendance/CheckINAndOut.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:Armas/source/AppScreen/Page/subPageAttendance/MainAttendance.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
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
          actions: <Widget>[
            GestureDetector(
              onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckInAndOut()),
                  );

              },
              child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Check In/Out",
                        style: TextStyle(color: Colors.red,fontSize: 18.0)),
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(child: MainAttendance()));
  }
}

// import 'package:Armas/source/MainScreen/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

// import 'package:shared_preferences/shared_preferences.dart';
import '../Page/PayslipScreen.dart';
import '../Page/AttendanceScreen.dart';


class WidgetMenu extends StatefulWidget {
  @override
  _WidgetMenuState createState() => _WidgetMenuState();
}

class _WidgetMenuState extends State<WidgetMenu> {
  double _fontSize = 12.0;
  double _widthImage = 7.0;
  double _widthContainer = 4.2;

  Widget _onProgress() {
    Fluttertoast.showToast(
        msg: "On Progress",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future _geoLocator() async {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position.latitude);
      print(position.longitude);
      print(position.accuracy);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 105.0,
          padding:
              EdgeInsets.only(top: 0.0, bottom: 0.0, left: 10.0, right: 10.0),
          child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width / _widthContainer,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => AttendanceScreen(),));
                          // _onProgress();
                        },
                        child: Container(
                          child: Center(
                            child: Image(
                              width: MediaQuery.of(context).size.width /
                                  _widthImage,
                              image: AssetImage("assets/img/Attendance.png"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Center(
                          child: Text(
                        "Attendance",
                        style: GoogleFonts.roboto(
                          fontSize: _fontSize,
                        ),
                        textAlign: TextAlign.center,
                      ))
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / _widthContainer,
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PayslipScreen()));
                    },
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Image(
                            width:
                                MediaQuery.of(context).size.width / _widthImage,
                            image: AssetImage("assets/img/payslip.png"),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Center(
                            child: Text(
                          "Payment Slip",
                          style: GoogleFonts.roboto(
                            fontSize: _fontSize,
                          ),
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / _widthContainer,
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      // _onProgress();
                      _geoLocator();
                    },
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Image(
                            width:
                                MediaQuery.of(context).size.width / _widthImage,
                            image: AssetImage("assets/img/Approval.png"),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Center(
                            child: Text(
                          "Approval",
                          style: GoogleFonts.roboto(
                            fontSize: _fontSize,
                          ),
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / _widthContainer,
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      _onProgress();
                    },
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Image(
                            width:
                                MediaQuery.of(context).size.width / _widthImage,
                            image: AssetImage("assets/img/EmployeeData.png"),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Center(
                            child: Text(
                          "Employee Data",
                          style: GoogleFonts.roboto(
                            fontSize: _fontSize,
                          ),
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
        Container(
          height: 105.0,
          padding:
              EdgeInsets.only(top: 0.0, bottom: 0.0, left: 10.0, right: 10.0),
          child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / _widthContainer,
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      _onProgress();
                    },
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Image(
                            width:
                                MediaQuery.of(context).size.width / _widthImage,
                            image: AssetImage("assets/img/paid-leave.png"),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Center(
                            child: Text(
                          "Paid Leave",
                          style: GoogleFonts.roboto(
                            fontSize: _fontSize,
                          ),
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / _widthContainer,
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      _onProgress();
                    },
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Image(
                            width:
                                MediaQuery.of(context).size.width / _widthImage,
                            image: AssetImage("assets/img/sick-1.png"),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Center(
                            child: Text(
                          "Sick Permission",
                          style: GoogleFonts.roboto(
                            fontSize: _fontSize,
                          ),
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / _widthContainer,
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      _onProgress();
                    },
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Image(
                            width:
                                MediaQuery.of(context).size.width / _widthImage,
                            image: AssetImage("assets/img/Permit.png"),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Center(
                            child: Text(
                          "Permit",
                          style: GoogleFonts.roboto(
                            fontSize: _fontSize,
                          ),
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / _widthContainer,
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      _onProgress();
                    },
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Image(
                            width:
                                MediaQuery.of(context).size.width / _widthImage,
                            image: AssetImage("assets/img/Allmenu.png"),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Center(
                            child: Text(
                          "All Menu",
                          style: GoogleFonts.roboto(
                            fontSize: _fontSize,
                          ),
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ],
    );
  }
}

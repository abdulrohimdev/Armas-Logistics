import 'dart:io';
import 'package:Armas/source/AppScreen/utils/LoaderPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Armas/source/AppScreen/Widget/Line.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:Armas/source/AppScreen/utils/listMonth.dart';
import 'package:Armas/source/ApiUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Armas/source/AppScreen/model/GetAttendance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:intl/intl.dart';

class MainAttendance extends StatefulWidget {
  @override
  _MainAttendanceState createState() => _MainAttendanceState();
}

class _MainAttendanceState extends State<MainAttendance> {
  var now = DateTime.now();
  String from;
  String to;
  int dayTo;
  int dayFrom;
  String from_date;
  String to_date;
  DateTime _from;
  DateTime _to;
  bool _enabled = true;
  bool _result = false;
  dynamic list;
  List<dynamic> attendance;

  final TextEditingController field_from = TextEditingController();
  final TextEditingController field_to = TextEditingController();

  var listMonth = ListMonth.fetch();
  Widget _title(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Attendance",
          style: GoogleFonts.montserrat(
              fontSize: 20.0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.left,
        ),
        Text(
          "${from} - ${to}",
          style: GoogleFonts.montserrat(fontSize: 15.0),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Widget itemList() {
    return Container(
      child: Text("hello"),
    );
  }

  Future<GetAttendance> _getAttendance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authTokenID = prefs.getString("authToken");
    final response = await http
        .get(getAttendance + "from=${from_date}&to=${to_date}", headers: {
      'Accept': 'application/json',
      'Auth': authTokenID,
    });
    if (response.statusCode == 200) {
      list = json.decode(response.body);
      attendance = list['results'];
      Future.delayed(Duration(seconds: 1)).then((value) {
        setState(() {
          _enabled = false;
          _result = true;
        });
      });
    } else {
      Future.delayed(Duration(seconds: 1)).then((value) {
        setState(() {
          _enabled = false;
          _result = false;
        });
      });
    }
  }

  listAttendance(context) {
    if(_result){
    return Container(
      padding: EdgeInsets.only(bottom: 30.0),
      height: MediaQuery.of(context).size.height / 1.2,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: attendance.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey[300]))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    padding: EdgeInsets.all(5.0),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                    child: Center(
                      child: Text(
                        "${attendance[index]['date']}",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Plan In"),
                            Text("${attendance[index]['in_plan']}"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Plan Out"),
                            Text("${attendance[index]['out_plan']}"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Act. In"),
                              attendance[index]['is_late'] == "0"
                                  ? Text("${attendance[index]['in_actual']}")
                                  : Text("${attendance[index]['in_actual']}",style:TextStyle(color: Colors.red)),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Act. Out"),
                            Text("${attendance[index]['out_actual']}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
    );
    }
    else
    {
      return Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 4.7),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Image(
                  image: AssetImage('assets/img/file.png'),
                  width: MediaQuery.of(context).size.width / 4),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text("Data Not Found", style: TextStyle(fontSize: 20.0)),
              ),
            ],
          ));

    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      dayTo = now.day;
      dayFrom = dayTo - 6;
      to = "${dayTo} ${listMonth[now.month].title} ${now.year}";
      from = "${dayFrom} ${listMonth[now.month].title} ${now.year}";
      from_date = "${now.year}-${now.month}-${dayFrom}";
      to_date = "${now.year}-${now.month}-${dayTo}";
      _getAttendance();
    });
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(top: 5.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  color: Colors.grey[400],
                  width: MediaQuery.of(context).size.width / 10.0,
                  padding: EdgeInsets.all(2),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: field_from,
                            onTap: () {
                              return DatePicker.showDatePicker(
                                context,
                                onConfirm: (dateTime, selectedIndex) {
                                  field_from.text =
                                      "${dateTime.year}-${dateTime.month}-${dateTime.day}";
                                  setState(() {
                                    _from = dateTime;
                                  });
                                },
                                maxDateTime: DateTime.now(),
                                dateFormat: 'dd-MMMM-yyyy',
                              );
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                labelText: 'From',
                                labelStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: field_to,
                            onTap: () {
                              return DatePicker.showDatePicker(
                                context,
                                onConfirm: (dateTime, selectedIndex) {
                                  field_to.text =
                                      "${dateTime.year}-${dateTime.month}-${dateTime.day}";
                                  setState(() {
                                    _to = dateTime;
                                  });
                                },
                                maxDateTime: DateTime.now(),
                                dateFormat: 'dd-MMMM-yyyy',
                              );
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              labelText: 'To',
                              labelStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 50.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () => {
                      if (from_date != null && to_date != null)
                        {
                          setState(() {
                            _enabled = true;
                            _result = false;
                            from_date = field_from.text;
                            to_date = field_to.text;
                            from =
                                "${_from.day} ${listMonth[_from.month].title} ${_from.year}";
                            to =
                                "${_to.day} ${listMonth[_to.month].title} ${_to.year}";
                            _getAttendance();
                            Navigator.of(context).pop();
                          })
                        }
                    },
                    color: Colors.blue,
                    child: Text("Apply Filter",
                        style: TextStyle(color: Colors.white, fontSize: 15.0)),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(left: 15.0, right: 0.0, top: 0.0, bottom: 10.0),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _title(context),
                GestureDetector(
                  onTap: () {
                    field_from.clear();
                    field_to.clear();
                    _settingModalBottomSheet(context);
                  },
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(AntDesign.filter)),
                ),
              ],
            ),
          ),
          Line(),
          _enabled ? LoaderPage() : listAttendance(context),
        ],
      ),
    );
  }
}

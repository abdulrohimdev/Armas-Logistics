import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Armas/source/AppScreen/model/ListSlipYears.dart';
import 'package:Armas/source/ApiUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:Armas/source/AppScreen/Page/subPagePayslip/DetailSlip.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class MainPayslip extends StatefulWidget {
  int recordObject;

  MainPayslip(this.recordObject);

  @override
  _MainPayslipState createState() => _MainPayslipState(recordObject);
}

class _MainPayslipState extends State<MainPayslip> {
  var now = new DateTime.now();
  int year;
  bool _enabled = true;
  bool _result = false;
  dynamic list;
  List<dynamic> slip;
  _MainPayslipState(this.year);
  TextEditingController yearDate = new TextEditingController();
  String _format = 'yyyy';

  Widget _line() {
    return Container(
      color: Colors.grey[300],
      width: MediaQuery.of(context).size.width,
      height: 0.5,
    );
  }

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
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0))),
      height: MediaQuery.of(context).size.height / 2.5,
      padding: EdgeInsets.only(top: 0.0, left: 45.0, right: 45.0),
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
          ),
          SizedBox(
            height: 20.0,
          ),
          CupertinoTextField(
            controller: yearDate,
            readOnly: true,
            cursorColor: Color(0xFF7d7d7d),
            keyboardType: TextInputType.number,
            style: GoogleFonts.roboto(fontSize: 15.0, color: Color(0xFF7d7d7d)),
            placeholder: "Year",
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Color(0xFFf7f5f5),
            ),
            onTap: () {
              DatePicker.showDatePicker(
                context,
                onConfirm: (dateTime, selectedIndex) {
                  print(dateTime.year);
                },
                maxDateTime: DateTime.now(),
                dateFormat: 'yyyy',
              );
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          ButtonTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.blue)),
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15.0),
            child: RaisedButton(
              color: Colors.blue,
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                  year = int.parse(yearDate.text);
                  thisYear = year;
                  _enabled = true;
                  getSlipYear(year);
                  yearDate.clear();
                });
              },
              child: Text(
                "Apply Filter",
                style: GoogleFonts.josefinSans(
                    color: Colors.white, fontSize: 17.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<ListSlipYears> getSlipYear(thisYear) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authTokenID = prefs.getString("authToken");
    final response = await http.get(listSlipsByYear + "${thisYear}", headers: {
      'Accept': 'application/json',
      'Auth': authTokenID,
    });

    if (response.statusCode == 200) {
      list = json.decode(response.body);
      slip = list['results'];
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

  _buildCard(index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailSlip(
                    int.parse(slip[index]['id']),
                    slip[index]['month'] + ' ' + slip[index]['year'])));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.grey[300], width: 1.0))),
        alignment: Alignment.centerLeft,
        child: ListTile(
          title: Text(slip[index]['month']),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ),
    );
  }

  listSlip(slip) {
    if (_result) {
      return Expanded(
          child: ListView(
        children: List.generate(slip.length, (index) {
          return _buildCard(index);
        }),
      ));
    } else {
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

  _buildCard2(index) {
    return Card(
      margin: EdgeInsets.all(1.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }

  _isLoader() {
    return Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text("Loading...", style: TextStyle(fontSize: 15.0)),
            ),
          ],
        ));
  }

  int thisYear;

  @override
  void initState() {
    super.initState();
    setState(() {
      thisYear = now.year;
      getSlipYear(thisYear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(left: 15.0, right: 0.0, top: 0.0, bottom: 10.0),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Payment Slip",
                      style: GoogleFonts.montserrat(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "${thisYear}",
                      style: GoogleFonts.montserrat(fontSize: 15.0),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => //tuningYear(),
                          DatePicker.showDatePicker(
                        context,
                        onConfirm: (dateTime, selectedIndex) {
                          setState(() {
                            year = dateTime.year;
                            thisYear = year;
                            _enabled = true;
                            getSlipYear(year);
                          });
                        },
                        maxDateTime: DateTime.now(),
                        dateFormat: 'yyyy', 
                      ),
                      icon: Icon(
                        AntDesign.filter,
                        color: Colors.black,
                      ),
                      tooltip: 'Update Year',
                    ),
                  ],
                ),
              ],
            ),
          ),
          _line(),
          _enabled
              ?
              // ? Expanded(
              //     child: Shimmer.fromColors(
              //     baseColor: Colors.grey[300],
              //     highlightColor: Colors.grey[100],
              //     enabled: _enabled,
              //     child: ListView(
              //       children: List.generate(8, (index) {
              //         return _buildCard2(index);
              //       }),
              //     ),
              //   ))
              _isLoader()
              : listSlip(slip),
        ],
      ),
    );
  }
}

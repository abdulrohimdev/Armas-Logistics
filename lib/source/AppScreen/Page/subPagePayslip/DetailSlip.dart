import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../ApiUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class DetailSlip extends StatefulWidget {
  int slipID;
  String name;
  DetailSlip(this.slipID, this.name);
  @override
  _DetailSlipState createState() => _DetailSlipState(slipID, name);
}

class _DetailSlipState extends State<DetailSlip> {
  int slipID;
  String name;
  String fullname;
  
  _DetailSlipState(this.slipID, this.name);
  String empid;
  Map<String, dynamic> data = Map();
  Map<String, dynamic> slipData = Map();
  Map<String, dynamic> deduction = Map();
  bool result = false;
  bool isEmployee = true;
  Future<String> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var auth = prefs.getString('authToken');
    print(auth);
    empid = prefs.getString('employeeID');
    try {
      http.Response response =
          await http.get(detailSlipUri + "${slipID}", headers: {
        'Accept': 'application/json',
        'Auth': auth,
      });

      if (response.statusCode == 200) {
        var list = json.decode(response.body);
        data = list;
        slipData = data['results']['allowance'];
        deduction = data['results']['deduction'];
        Future.delayed(Duration(seconds: 1)).then((value) {
          setState(() {
            fullname = list['results']['employee_name'];
            result = true;
            if(list['results']['employee_type'] == 'mitra'){
              isEmployee = false;
            } 
            else{
              isEmployee = true;
            }
          });
        });
        // print(deduction);
      }
    } catch (e) {}
  }

  _widgetTitle(context) {
    return Container(
        padding: EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                "SLIP GAJI KARYAWAN",
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(fullname,
                    style: TextStyle(fontSize: 13.0, color: Colors.grey)),
                Text("", style: TextStyle(fontSize: 13.0, color: Colors.grey)),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(empid,
                    style: TextStyle(fontSize: 13.0, color: Colors.grey)),
                Text("Periode UM & OT (${name})",
                    style: TextStyle(fontSize: 13.0, color: Colors.grey)),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ));
  }

  _widgetTitleComission(context) {
    return Container(
        padding: EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                "SLIP KOMISI",
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(fullname,
                    style: TextStyle(fontSize: 13.0, color: Colors.grey)),
                Text("", style: TextStyle(fontSize: 13.0, color: Colors.grey)),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(empid,
                    style: TextStyle(fontSize: 13.0, color: Colors.grey)),
                Text("Periode UM & OT (${name})",
                    style: TextStyle(fontSize: 13.0, color: Colors.grey)),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ));
  }

  _widgetAllowance(context) {
    return Container(
        padding: EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("PENDAPATAN", style: TextStyle(fontSize: 14.0)),
              ],
            ),
            Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: slipData.length,
                    itemBuilder: (context, index) {
                      String key = slipData.keys.elementAt(index);
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(key,
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.grey)),
                              Text(slipData[key],
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.grey)),
                            ],
                          ),
                        ],
                      );
                    })),
            SizedBox(
              height: 10.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Total Pendapatan",
                    style: TextStyle(fontSize: 13.0, color: Colors.black)),
                Text(data['results']['total_allowance'],
                    style: TextStyle(fontSize: 13.0, color: Colors.grey)),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ));
  }

  _widgetAllowanceComission(context) {
    return Container(
        padding: EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Penerimaan Komisi", style: TextStyle(fontSize: 14.0)),
              ],
            ),
            Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: slipData.length,
                    itemBuilder: (context, index) {
                      String key = slipData.keys.elementAt(index);
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(key,
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.grey)),
                              Text(slipData[key],
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.grey)),
                            ],
                          ),
                        ],
                      );
                    })),
            SizedBox(
              height: 10.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Total Pendapatan",
                    style: TextStyle(fontSize: 13.0, color: Colors.black)),
                Text(data['results']['total_allowance'],
                    style: TextStyle(fontSize: 13.0, color: Colors.grey)),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ));
  }

  _widgetDeduction(context) {
    return Container(
        padding: EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("POTONGAN", style: TextStyle(fontSize: 14.0)),
              ],
            ),
            Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: deduction.length,
                    itemBuilder: (context, index) {
                      String key = deduction.keys.elementAt(index);
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(key,
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.grey)),
                              Text(deduction[key],
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.grey)),
                            ],
                          ),
                        ],
                      );
                    })),
            SizedBox(
              height: 10.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Total Potongan",
                    style: TextStyle(fontSize: 13.0, color: Colors.black)),
                Text(data['results']['total_deduction'],
                    style: TextStyle(fontSize: 13.0, color: Colors.grey)),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ));
  }

  _widgetDeductionComission(context) {
    return Container(
        padding: EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Potongan Komisi", style: TextStyle(fontSize: 14.0)),
              ],
            ),
            Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: deduction.length,
                    itemBuilder: (context, index) {
                      String key = deduction.keys.elementAt(index);
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(key,
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.grey)),
                              Text(deduction[key],
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.grey)),
                            ],
                          ),
                        ],
                      );
                    })),
            SizedBox(
              height: 10.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Total Potongan",
                    style: TextStyle(fontSize: 13.0, color: Colors.black)),
                Text(data['results']['total_deduction'],
                    style: TextStyle(fontSize: 13.0, color: Colors.grey)),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ));
  }

  _widgetTakeHompay(context) {
    return Container(
        padding: EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
        child: Column(children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Gaji Bersih",
                  style: TextStyle(fontSize: 13.0, color: Colors.black)),
              Text(data['results']['total'],
                  style: TextStyle(fontSize: 13.0, color: Colors.grey)),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
        ]));
  }

  _widgetTakeHompayComission(context) {
    return Container(
        padding: EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
        child: Column(children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Total Komisi Bersih",
                  style: TextStyle(fontSize: 13.0, color: Colors.black)),
              Text(data['results']['total'],
                  style: TextStyle(fontSize: 13.0, color: Colors.grey)),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
        ]));
  }

  Widget _line() {
    return Container(
      color: Colors.grey[300],
      width: MediaQuery.of(context).size.width,
      height: 0.5,
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  _slipEmployee(context){
    return Container(
      child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 0.0, bottom: 15.0,left:15.0),
          alignment: Alignment.centerLeft,
          // color: Color(0xFFe8e8e8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Payment Slip",
                style: GoogleFonts.montserrat(
                    fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
              Text(
                "${name}",
                style: GoogleFonts.montserrat(fontSize: 14.0),
              ),
              SizedBox(height: 10.0,),
              _line(),
            ],
          ),
        ),
        _widgetTitle(context),
        _line(),
        _widgetAllowance(context),
        _line(),
        _widgetDeduction(context),
        _line(),
        _widgetTakeHompay(context)
      ]),
    );
  }

  _slipComission(context){
    return Container(
      child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 0.0, bottom: 15.0,left:15.0),
          alignment: Alignment.centerLeft,
          // color: Color(0xFFe8e8e8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Payment Slip",
                style: GoogleFonts.montserrat(
                    fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
              Text(
                "${name}",
                style: GoogleFonts.montserrat(fontSize: 14.0),
              ),
              SizedBox(height: 10.0,),
              _line(),
            ],
          ),
        ),
        _widgetTitleComission(context),
        _line(),
        _widgetAllowanceComission(context),
        _line(),
        _widgetDeductionComission(context),
        _line(),
        _widgetTakeHompayComission(context)
      ]),
    );

  }

  _thisPage(context) {
    return SingleChildScrollView(
      child: isEmployee ? _slipEmployee(context) : _slipComission(context),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: Color(0xFFe8e8e8),
        backgroundColor: Colors.white,
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
      ),
      body: result ? _thisPage(context) : _isLoader(),
    );
  }
}

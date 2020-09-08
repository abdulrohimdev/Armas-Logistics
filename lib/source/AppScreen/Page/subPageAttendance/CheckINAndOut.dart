// import 'dart:html';

import 'dart:ffi';
import 'dart:convert';
import 'package:Armas/source/AppScreen/utils/LoaderPage.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
// import 'package:geolocation/geolocation.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:Armas/source/ApiUrl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckInAndOut extends StatefulWidget {
  @override
  _CheckInAndOutState createState() => _CheckInAndOutState();
}

class _CheckInAndOutState extends State<CheckInAndOut> {
  MapController controller = new MapController();

  Location location = new Location();
  ProgressDialog progressDialog;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  double latitude;
  double longitude;
  bool _isload = true;

  void _mapLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    await location.getLocation().then((value) => {
          setState(() {
            _isload = false;
            _locationData = value;
            latitude = value.latitude;
            longitude = value.longitude;
          })
        });
  }

  _flutterMap() {
    return new FlutterMap(
      mapController: controller,
      options: new MapOptions(
          center: LatLng(latitude, longitude), minZoom: 16.0, maxZoom: 50.0),
      layers: [
        new TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c']),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 30.0,
              height: 30.0,
              point: new LatLng(latitude, longitude),
              builder: (ctx) => new Container(
                child: Image(
                  image: AssetImage('assets/img/placeholder.png'),
                  width: 10.0,
                  height: 10.0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _checkin() async {
    progressDialog.show();
    var body = jsonEncode({
      "latitude": latitude,
      "longitude": longitude,
      "note": "",
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authTokenID = prefs.getString("authToken");

    http.Response response = await http.post(checkin,
        headers: {
          'Accept': 'application/json',
          'Auth': authTokenID,
        },
        body: body);
    var result = json.decode(response.body);
    print(result);
    if (response.statusCode == 200) {
      Future.delayed(Duration(seconds: 0)).then((value) {
        progressDialog.hide().whenComplete(() => {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height / 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.check, size: 50.0, color: Colors.green),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Check In Sukses",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              height: 40.0,
                              child: RaisedButton(
                                onPressed: () {
                                  progressDialog.hide().whenComplete(() =>  Navigator.pop(context, true));
                                },
                                color: Colors.red,
                                child: Text("Close",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            });
      });
    } else {
      Future.delayed(Duration(seconds: 0)).then((value) {
        progressDialog.hide().whenComplete(() => {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height / 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.error, size: 50.0, color: Colors.red),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              result['message'],
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              height: 40.0,
                              child: RaisedButton(
                                onPressed: () {
                                  progressDialog.hide().whenComplete(() =>  Navigator.pop(context, true));
                                },
                                color: Colors.red,
                                child: Text("Close",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            });
      });
    }
  }

  _checkout() async {
    progressDialog.show();
    var body = jsonEncode({
      "latitude": latitude,
      "longitude": longitude,
      "note": "",
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authTokenID = prefs.getString("authToken");

    http.Response response = await http.post(checkout,
        headers: {
          'Accept': 'application/json',
          'Auth': authTokenID,
        },
        body: body);
    var result = json.decode(response.body);
    print(result);
    if (response.statusCode == 200) {
      Future.delayed(Duration(seconds: 0)).then((value) {
        progressDialog.hide().whenComplete(() => {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height / 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.check, size: 50.0, color: Colors.green),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Check Out Sukses",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              height: 40.0,
                              child: RaisedButton(
                                onPressed: () {
                                  progressDialog.hide().whenComplete(() =>  Navigator.pop(context, true));
                                },
                                color: Colors.red,
                                child: Text("Close",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            });
      });
    } else {
      Future.delayed(Duration(seconds: 0)).then((value) {
        progressDialog.hide().whenComplete(() => {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height / 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.error, size: 50.0, color: Colors.red),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              result['message'],
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              height: 40.0,
                              child: RaisedButton(
                                onPressed: () {
                                  progressDialog.hide().whenComplete(() =>  Navigator.pop(context, true));
                                },
                                color: Colors.red,
                                child: Text("Close",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            });
      });
    }
  }

  Widget _column(context) {
    return Container(
      color: Colors.transparent,
      // padding: EdgeInsets.all(30),
      // alignment: Alignment.center,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: _flutterMap()),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () => {_checkin()},
                color: Colors.green,
                child: Text("Check In", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(
                width: 10.0,
              ),
              RaisedButton(
                onPressed: () => {_checkout()},
                color: Colors.red,
                child: Text("Check Out", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _mapLocation();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,
        isDismissible: false, type: ProgressDialogType.Normal);
    progressDialog.style(message: "Loading");

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        titleSpacing: 0.0,
        elevation: 0.0,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15.0),
            child: IconButton(
              color: Colors.blue,
              iconSize: 30.0,
              icon: Icon(Icons.refresh),
              onPressed: () {
                controller.move(LatLng(latitude, longitude), 16.0);
              },
            ),
          )
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context, true),
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.red,
                size: 35.0,
              ),
            ),
            new Text('Checkin/Out',
                style: new TextStyle(color: Colors.red)), // Your widgets here
          ],
        ),
      ),
      body: _isload ? LoaderPage() : _column(context),
    );
  }
}

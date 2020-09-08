import 'package:flutter/material.dart';
import '../AuthScreen/AccountConnection.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {

  Widget mainImage(context) {
    var assetImage = AssetImage('assets/img/logo.png');
    var image = Image(
      image: assetImage,
      width: MediaQuery.of(context).size.width / 1.05,
      height: MediaQuery.of(context).size.height / 2.00,
    );
    return new Container(
      // width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 10,right:0.0), child: image);
  }

  Widget title() {
    return new Container(
        child: new Center(
            child: Text('MyArmas',
                style:
                    new TextStyle(fontSize: 32.0, color: Color(0xFFe64c4c)))));
  }

  Widget subtitle() {
    return new Container(
        child: new Center(
            child: Text('All about administrative activity now in your hand',
                textAlign: TextAlign.center,
                style:
                    new TextStyle(fontSize: 14.0, color: Color(0xFFe64c4c)))));
  }

  Widget buttonNext(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccountConnection()),
          );
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 30),
            margin: EdgeInsets.all(23.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 2)
                ],
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xffff6e6e), Color(0xffe64c4c)])),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                    child: new Text('Get Started',
                        style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ))),
                new Center(
                    child: new Icon(
                  Icons.keyboard_arrow_right,
                  size: 25.0,
                  color: Colors.white,
                ))
              ],
            )));
  }

  Widget _thisPage(context) {
      return SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20, left: 20.0),
        child: new Container(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            mainImage(context),
            title(),
            subtitle(),
            buttonNext(context)
          ],
        )),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _thisPage(context),
    );        
  }
}

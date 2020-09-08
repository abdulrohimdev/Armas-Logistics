import 'package:flutter/material.dart';

class LoaderPage extends StatefulWidget {
  @override
  _LoaderPageState createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:MediaQuery.of(context).size.height / 3),
      alignment: Alignment.center,
      child: Column(children: [
        CircularProgressIndicator(),
        SizedBox(height: 20,),
        Text("Loading..."),
      ],),
    );
  }

}
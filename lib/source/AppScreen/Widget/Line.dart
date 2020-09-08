import 'package:flutter/material.dart';

class Line extends StatefulWidget {
  @override
  _LineState createState() => _LineState();
}

class _LineState extends State<Line> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      width: MediaQuery.of(context).size.width,
      height: 0.5,
    );

  }
}
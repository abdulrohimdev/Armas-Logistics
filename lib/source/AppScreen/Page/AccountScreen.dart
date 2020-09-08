import 'package:Armas/source/AuthScreen/PasswordConnectionWithoutBack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Widget _line() {
    return Container(
      color: Colors.grey[300],
      width: MediaQuery.of(context).size.width,
      height: 0.5,
    );
  }

  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('isLogedIn', false);
    });
    print(prefs.getBool("isLogedIn"));
    Fluttertoast.showToast(
        msg: "You have been signed out.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SigninWithPasswordWithoutBack()),
    );
  }

  _confirmLogout() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Do you want to end the session in this application?"),
          title: Text("Confirmation",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('CANCEL'),
            ),
            RaisedButton(
              onPressed: () {
                _logout();
              },
              color: Colors.red,
              child: Text('YES'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0.6,
        // bottomOpacity: 0.1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text('Account Settings',
                style: new TextStyle(color: Colors.red)),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: ListTile(
              title: Text('Abdul Rohim'),
              subtitle: Text('Name'),
            ),
          ),
          _line(),
          Container(
            child: ListTile(
              title: Text('abdulrohim739@gmail.com'),
              subtitle: Text('Email'),
            ),
          ),
          _line(),
          Container(
            child: ListTile(
              title: Text('Change Password'),
              trailing: Icon(AntDesign.right,size: 18.0,),
            ),
          ),
          _line(),
          Container(
            child: ListTile(
              title: Text('Disconnect Device'),
              trailing: Icon(AntDesign.right,size: 18.0,),
            ),
          ),
          _line(),
          GestureDetector(
            onTap: () {
              _confirmLogout();
            },
            child: Container(
              child: ListTile(
                title: Text('Logout'),
                trailing: Icon(AntDesign.poweroff,size: 18.0,),
              ),
            ),
          ),
          _line(),
        ],
      ),
    );
  }
}

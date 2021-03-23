import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topRight,
        margin: EdgeInsets.symmetric(vertical: 35, horizontal: 4),
        child: RawMaterialButton(
          onPressed: () {Navigator.pop(context);},
          elevation: 2.0,
          fillColor: Colors.white,
          child: Icon(
            Icons.pause,
            size: 35.0,
          ),
          padding: EdgeInsets.all(10.0),
          shape: CircleBorder(
            side: BorderSide(
                width: 1, color: Colors.red, style: BorderStyle.solid),
          ),
        ));
  }
}

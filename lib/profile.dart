import 'package:flutter/material.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorsLibrary.whiteColor,
        child: Column(children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue,
                    Colors.red,
                  ],
                )
            ),),
          RawMaterialButton(
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
          )
        ])
    );
  }
}
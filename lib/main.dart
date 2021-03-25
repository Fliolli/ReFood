import 'package:flutter/material.dart';

import 'base.dart';

void main() => runApp(ReFoodApp());

class ReFoodApp extends StatelessWidget {
  static const String _title = 'ReFood';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        theme: ThemeData(
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.pink[300],
          accentColor: Colors.pink[200],
          textSelectionHandleColor: Colors.green[700],
          textTheme: TextTheme(
            caption: TextStyle(fontSize: 4.0, fontWeight: FontWeight.bold),
            headline5: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            subtitle1: TextStyle(
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal),
            bodyText2: TextStyle(
                fontSize: 15.5,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal),
          ),
        ),
        home: Base());
  }
}
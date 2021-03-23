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
          primaryColor: Colors.deepOrange[400],
          accentColor: Colors.green[400],
          textSelectionHandleColor: Colors.green[700]),
      home:Base()
    );
  }
}


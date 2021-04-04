import 'package:flutter/material.dart';

import 'screens/homeScreen.dart';

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
            splashColor: Colors.pink[200],
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            })),
        home: HomeScreen());
  }
}

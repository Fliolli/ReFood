import 'package:flutter/material.dart';
import 'package:flutter_test_app/rootScreen.dart';
import 'package:flutter_test_app/services/Authentication.dart';
import 'package:sizer/sizer.dart';

class ReFoodApp extends StatelessWidget {
  ReFoodApp({this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(//return LayoutBuilder
        builder: (context, constraints) {
      return OrientationBuilder(//return OrientationBuilder
          builder: (context, orientation) {
        SizerUtil(); //initialize SizerUtil
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: title,
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
            home: RootScreen(auth: Authentication()));
      });
    });
  }
}

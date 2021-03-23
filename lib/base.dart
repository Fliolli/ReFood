import 'package:flutter/material.dart';
import 'package:flutter_test_app/profile.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'BottomNav.dart';

class Base extends StatefulWidget {
  Base({Key key}) : super(key: key);

  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(children: <Widget>[
        SizedBox.expand(child: YandexMap()),
        DraggableScrollableSheet(
            initialChildSize: 0.8,
            maxChildSize: 1,
            minChildSize: 0.1,
            builder: (BuildContext context, ScrollController scrollController) {
              return Stack(children: <Widget>[
                Container(
                  color: Colors.white,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 25,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(title: Text('Item $index'));
                    },
                  ),
                ),
              ]);
            }),
        Container(
          alignment: Alignment.topLeft,
            margin: EdgeInsets.symmetric(vertical: 35, horizontal: 4),
            child: RawMaterialButton(
              onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );},
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
            )),
            Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.symmetric(vertical: 35, horizontal: 4),
                child: RawMaterialButton(
                  onPressed: () {},
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
                )),
      ])
          //_widgetOptions.elementAt(_selectedIndex),
          ),
      bottomNavigationBar: BottomNavCustom(),
    );
  }
}

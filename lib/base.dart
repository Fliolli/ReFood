import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/profile.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'BottomNav.dart';

class Base extends StatefulWidget {
  Base({Key key}) : super(key: key);

  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int _selectedIndex = 0;

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
        Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.symmetric(vertical: 100, horizontal: 15),
            child: FloatingActionButton(
              onPressed: () {},
              child: const Icon(
                Icons.navigation,
                color: ColorsLibrary.primaryColor,
              ),
              mini: true,
              backgroundColor: ColorsLibrary.whiteColor,
              heroTag: "navigation",
            )),
        DraggableScrollableSheet(
            initialChildSize: 0.78,
            maxChildSize: 1,
            minChildSize: 0.1,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: ColorsLibrary.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 25,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text('Item $index'));
                  },
                ),
              );
            }),
        Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.symmetric(vertical: 35, horizontal: 10),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
              child: const Icon(Icons.menu, color: ColorsLibrary.middleBlack),
              backgroundColor: ColorsLibrary.whiteColor,
              heroTag: "menu",
            )),
        Container(
          alignment: Alignment.topRight,
          margin: EdgeInsets.symmetric(vertical: 35, horizontal: 10),
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.shopping_cart_outlined,
                color: ColorsLibrary.middleBlack),
            backgroundColor: ColorsLibrary.whiteColor,
            heroTag: "cart",
          ),
        )
      ])
          //_widgetOptions.elementAt(_selectedIndex),
          ),
      bottomNavigationBar: BottomNavCustom(),
    );
  }
}

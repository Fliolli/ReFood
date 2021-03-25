import 'package:flutter/material.dart';
import 'resources/ColorsLibrary.dart';

class BottomNavCustom extends StatefulWidget {
  @override
  _BottomNavCustomState createState() => _BottomNavCustomState();
}

class _BottomNavCustomState extends State<BottomNavCustom> {
  int selectedIndex = 0;

  List<NavigationItem> items = [
    NavigationItem(
        Icon(Icons.home), Text('Главная'), ColorsLibrary.primaryColor),
    NavigationItem(
        Icon(Icons.search), Text('Поиск'), ColorsLibrary.primaryColor),
    NavigationItem(
        Icon(Icons.favorite), Text('Фавориты'), ColorsLibrary.primaryColor)
  ];

  Widget _buildItem(NavigationItem item, bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      height: 60,
      width: isSelected ? 140 : 60,
      padding: EdgeInsets.only(left: 12, right: 12),
      decoration: isSelected
          ? BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.all(Radius.circular(50)))
          : null,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconTheme(
                data: IconThemeData(
                  size: 28,
                  color: isSelected
                      ? ColorsLibrary.whiteColor
                      : ColorsLibrary.neutralGray,
                ),
                child: item.icon,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: isSelected
                    ? DefaultTextStyle.merge(
                    style: TextStyle(color: ColorsLibrary.whiteColor),
                    child: item.title)
                    : Container(),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: ColorsLibrary.lightGray, blurRadius: 6)
      ]),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var itemIndex = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = itemIndex;
              });
            },
            child: _buildItem(item, selectedIndex == itemIndex),
          );
        }).toList(),
      ),
    );
  }
}

class NavigationItem {
  final Icon icon;
  final Text title;
  final Color color;

  NavigationItem(this.icon, this.title, this.color);
}
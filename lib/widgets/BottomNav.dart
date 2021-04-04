import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/ColorsLibrary.dart';
import '../utils/PlatformUtils.dart';
import 'NavigationItem.dart';

class BottomNavCustom extends StatefulWidget {
  const BottomNavCustom({
    Key key,
  }) : super(key: key);

  @override
  _BottomNavCustomState createState() => _BottomNavCustomState();
}

class _BottomNavCustomState extends State<BottomNavCustom> {
  int selectedIndex = 0;

  final List<NavigationItem> items = [
    NavigationItem(
        selectByPlatform(
          CupertinoIcons.home,
          Icons.home_rounded,
        ),
        Text('Главная'),
        ColorsLibrary.primaryColor),
    NavigationItem(
        selectByPlatform(
          CupertinoIcons.search,
          Icons.search_rounded,
        ),
        Text('Поиск'),
        ColorsLibrary.primaryColor),
    NavigationItem(
        selectByPlatform(
          CupertinoIcons.suit_heart,
          Icons.favorite_rounded,
        ),
        Text('Фавориты'),
        ColorsLibrary.primaryColor)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        const BoxShadow(color: ColorsLibrary.lightGray, blurRadius: 6)
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
            child: buildNavigationItem(item, selectedIndex == itemIndex),
          );
        }).toList(),
      ),
    );
  }
}

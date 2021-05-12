import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../resources/ColorsLibrary.dart';
import '../utils/PlatformUtils.dart';
import '../resources/StylesLibrary.dart';
import 'package:flutter_test_app/screens/GoodItemInfoScreen.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;

Widget buildGoodCardItemTrimmed(
    GoodCardItemTrimmed goodCardItemTrimmed, BuildContext context) {
  return Card(
    margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
    shadowColor: ColorsLibrary.neutralGray,
    color: ColorsLibrary.whiteColor,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GoodItemInfoScreen(
                goodType: global.GoodType.trimmed,
                id: goodCardItemTrimmed._id,
                image: goodCardItemTrimmed._image,
                name: goodCardItemTrimmed._name,
                price: goodCardItemTrimmed._price,
                unit: goodCardItemTrimmed._unit,
                isFree: goodCardItemTrimmed._isFree,
              ),
            ));
      },
      child: Container(
          padding: const EdgeInsets.all(4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(goodCardItemTrimmed._image.toString(),
                      height: 90, width: 90, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.59,
                      child: Text(
                        goodCardItemTrimmed._name,
                        style: selectByPlatform(
                                StylesLibrary.IOSPrimaryBlackTextStyle,
                                StylesLibrary.AndroidPrimaryBlackTextStyle)
                            .merge(const TextStyle(fontSize: 17)),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.59,
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "Масса: ${global.foodItem.mass} кг.",
                        style: selectByPlatform(
                            StylesLibrary.optionalBlackTextStyle,
                            StylesLibrary.optionalBlackTextStyle)
                            .merge(const TextStyle(fontSize: 13)),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width *  0.59,
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "Оценка: ${global.foodItem.mark}",
                        style: selectByPlatform(
                            StylesLibrary.optionalBlackTextStyle,
                            StylesLibrary.optionalBlackTextStyle)
                            .merge(const TextStyle(fontSize: 13)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: SizedBox(
                        width: 120,
                        child: Text(
                          goodCardItemTrimmed._isFree
                              ? 'бесплатно'
                              : '${goodCardItemTrimmed._price.toString()} р. ${goodCardItemTrimmed._unit}',
                          style: selectByPlatform(
                                  StylesLibrary.optionalBlackTextStyle,
                                  StylesLibrary.optionalBlackTextStyle)
                              .merge(const TextStyle(
                                  fontSize: 12,
                                  wordSpacing: -4,
                                  letterSpacing: -0.5)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    ),
  );
}

class GoodCardItemTrimmed {
  final int _id;
  String _image;
  String _name;
  double _price;
  String _unit;
  double _mass;
  int _mark;
  bool _isFree;

  GoodCardItemTrimmed(this._id, this._image, this._name, this._price,
      this._unit, this._mass, this._mark, this._isFree);
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../resources/ColorsLibrary.dart';
import '../utils/PlatformUtils.dart';
import '../resources/StylesLibrary.dart';
import 'package:flutter_test_app/screens/OrderItemInfoScreen.dart';

Widget buildOrderCardItem(OrderCardItem orderCardItem, BuildContext context) {
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
              builder: (context) => OrderItemInfoScreen(
                id: orderCardItem._id,
                image: orderCardItem._image,
                name: orderCardItem._name,
                price: orderCardItem._price,
                unit: orderCardItem._unit,
                ownerName: orderCardItem._ownerName,
                ownerProfileImage: orderCardItem._ownerProfileImage,
                isFree: orderCardItem._isFree,
                ownerRating: orderCardItem._ownerRating,
              ),
            ));
      },
      splashColor: ColorsLibrary.lightOrange,
      child: Container(
          padding: const EdgeInsets.all(4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(orderCardItem._image.toString(),
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
                        orderCardItem._name,
                        style: selectByPlatform(
                                StylesLibrary.IOSPrimaryBlackTextStyle,
                                StylesLibrary.AndroidPrimaryBlackTextStyle)
                            .merge(const TextStyle(fontSize: 17)),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 3),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(
                                  orderCardItem._ownerProfileImage.toString(),
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child:
                                Row(mainAxisSize: MainAxisSize.max, children: <
                                    Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  width: 100,
                                  child: Text(
                                    orderCardItem._ownerName,
                                    style: selectByPlatform(
                                            StylesLibrary
                                                .optionalBlackTextStyle,
                                            StylesLibrary
                                                .optionalBlackTextStyle)
                                        .merge(const TextStyle(fontSize: 13)),
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.star_border_rounded,
                                color: ColorsLibrary.lightOrange,
                              ),
                              SizedBox(
                                width: 30,
                                child: Text(
                                  orderCardItem._ownerRating.toString(),
                                  style: selectByPlatform(
                                          StylesLibrary.optionalBlackTextStyle,
                                          StylesLibrary.optionalBlackTextStyle)
                                      .merge(const TextStyle(fontSize: 14)),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              selectByPlatform(
                                  CupertinoIcons.location, Icons.location_pin),
                              color: ColorsLibrary.neutralGray,
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 12),
                              width: 55,
                              child: Text(
                                '${orderCardItem._distance.toString()} км.',
                                style: selectByPlatform(
                                        StylesLibrary.optionalBlackTextStyle,
                                        StylesLibrary.optionalBlackTextStyle)
                                    .merge(const TextStyle(
                                        fontSize: 12,
                                        wordSpacing: -2,
                                        letterSpacing: -0.5)),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Text(
                                orderCardItem._isFree
                                    ? 'бесплатно'
                                    : '${orderCardItem._price.toString()} р. за ${orderCardItem._unit}',
                                style: selectByPlatform(
                                        StylesLibrary.optionalBlackTextStyle,
                                        StylesLibrary.optionalBlackTextStyle)
                                    .merge(TextStyle(
                                        color: orderCardItem._isFree
                                            ? ColorsLibrary.greenColor
                                            : ColorsLibrary.middleBlack,
                                        fontSize: 12,
                                        wordSpacing: -4,
                                        letterSpacing: -0.5)),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              )
            ],
          )),
    ),
  );
}

class OrderCardItem {
  int _id;
  String _image;
  String _name;
  int _price;
  String _unit;
  double _distance;
  String _ownerName;
  double _ownerRating;
  String _ownerProfileImage;
  bool _isFree;

  OrderCardItem(
      this._id,
      this._image,
      this._name,
      this._price,
      this._unit,
      this._distance,
      this._ownerName,
      this._ownerRating,
      this._ownerProfileImage,
      this._isFree);
}

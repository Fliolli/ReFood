import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../resources/ColorsLibrary.dart';
import '../utils/PlatformUtils.dart';
import '../resources/StylesLibrary.dart';

Widget buildFavoriteCardItem(FavoriteCardItem favoriteCardItem, BuildContext context) {
  return Card(
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      shadowColor: ColorsLibrary.neutralGray,
      color: ColorsLibrary.whiteColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(favoriteCardItem._ownerProfileImage.toString(),
                        height: 90, width: 90, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 12, left: 8),
                        width: MediaQuery.of(context).size.width * 0.59,
                        child: Text(
                          favoriteCardItem._ownerName,
                          style: selectByPlatform(
                                  StylesLibrary.IOSPrimaryBlackTextStyle, StylesLibrary.AndroidPrimaryBlackTextStyle)
                              .merge(const TextStyle(fontSize: 17)),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8),
                        child: Row(children: <Widget>[
                          SizedBox(
                            width: 120,
                            child: Text(
                              "Рейтинг продавца: ",
                              style: selectByPlatform(
                                      StylesLibrary.optionalBlackTextStyle, StylesLibrary.optionalBlackTextStyle)
                                  .merge(const TextStyle(fontSize: 14)),
                            ),
                          ),
                          Icon(
                            Icons.star_border_rounded,
                            color: ColorsLibrary.lightOrange,
                          ),
                          SizedBox(
                            width: 30,
                            child: Text(
                              favoriteCardItem._ownerRating.toString(),
                              style: selectByPlatform(
                                      StylesLibrary.optionalBlackTextStyle, StylesLibrary.optionalBlackTextStyle)
                                  .merge(const TextStyle(fontSize: 14)),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )));
}

class FavoriteCardItem {
  int _id;
  String _ownerName;
  double _ownerRating;
  String _ownerProfileImage;

  FavoriteCardItem(
    this._id,
    this._ownerName,
    this._ownerRating,
    this._ownerProfileImage,
  );
}

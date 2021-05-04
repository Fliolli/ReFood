import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/widgets/InteractiveLabelItem.dart';
import '../utils/PlatformUtils.dart';
import 'package:flutter_test_app/widgets/OrderCardBookmarkItem.dart';
import 'package:flutter_test_app/widgets/CustomTextField.dart';
import 'package:flutter_test_app/widgets/TitleGoodPropertyItem.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart' as strings;

class NewGoodScreen extends StatefulWidget {
  @override
  _NewGoodScreenState createState() => _NewGoodScreenState();
}

class _NewGoodScreenState extends State<NewGoodScreen> {
  final nameTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final expirationDateTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final whenToPickUpTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsLibrary.whiteColor,
          elevation: 0,
          title: Text(createGood,
              style: StylesLibrary.strongBlackTextStyle
                  .merge(const TextStyle(fontSize: 16))),
          leading: CloseButton(
            color: ColorsLibrary.primaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(children: [
          Column(children: <Widget>[
            buildTitleGoodPropertyItem(nameOfGood, context),
            buildCustomTextField(
                CustomTextField(
                    50,
                    30,
                    TextInputType.name,
                    TextInputAction.next,
                    1,
                    1,
                    'Что выставить на витрину?', (String value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите название товара';
                  }
                  return null;
                }, nameTextController),
                context),
            buildTitleGoodPropertyItem(seller, context),
            buildCustomTextField(
                CustomTextField(
                    50,
                    30,
                    TextInputType.name,
                    TextInputAction.next,
                    1,
                    1,
                    'Что выставить на витрину?', (String value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите название товара';
                  }
                  return null;
                }, nameTextController),
                context),
            buildTitleGoodPropertyItem(descriptionOfGood, context),
            buildCustomTextField(
                CustomTextField(
                  130,
                  30,
                  TextInputType.multiline,
                  TextInputAction.newline,
                  6,
                  1,
                  'Опишите товар, обозначьте его доступное количество..',
                      (String value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите описание товара';
                    }
                    return null;
                  }, descriptionTextController
                ),
                context),
            buildTitleGoodPropertyItem(expirationDate, context),
            InkWell(
              child: buildCustomTextField(
                  CustomTextField(
                      50,
                      30,
                      TextInputType.multiline,
                      TextInputAction.newline,
                      1,
                      1,
                      'Обозначьте срок годности продукта..',
                          (String value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите срок годности';
                        }
                        return null;
                      }, expirationDateTextController
                  ),
                  context),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext builder) {
                        return Container(
                          height:
                          MediaQuery.of(context).copyWith().size.height /
                              3,
                        );
                      });
                }
            ),
            buildTitleGoodPropertyItem(price, context),
            buildCustomTextField(
                CustomTextField(
                    50,
                    30,
                    TextInputType.number,
                    TextInputAction.done,
                    1,
                    1,
                    'Обозначьте цену..',
                        (String value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите цену товара';
                      }
                      return null;
                    }, priceTextController
                ),
                context),
            buildTitleGoodPropertyItem(whenToPickUp, context),
            buildCustomTextField(
                CustomTextField(75,
                    30,
                    TextInputType.multiline,
                    TextInputAction.newline,
                    3,
                    1,
                    'Обозначьте время, когда вам удобно передать товар..',
                        (String value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите удобное время';
                      }
                      return null;
                    }, whenToPickUpTextController
                ),
                context),
            buildTitleGoodPropertyItem(whereToPickUp, context),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              height: 45,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorsLibrary.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(35)),
              ),
              child: InkWell(
                onTap: () {},
                child: Container(child: Center(child: Text(
                  strings.create,
                  style: selectByPlatform(
                      StylesLibrary.IOSPrimaryWhiteTextStyle,
                      StylesLibrary.AndroidPrimaryWhiteTextStyle)
                      .merge(const TextStyle(
                      color: ColorsLibrary.whiteColor, fontSize: 17)),
                ),)

                  ),
                ),
              ),
          ]),
        ]));
  }
}

class NewGood {
  String image;
  String name;
  int price;
  String unit;
  String ownerName;
  String ownerProfileImage;
  String description;
  String location;
  String pickUpTimes;
  DateTime expirationDate;
  bool isFree;

  NewGood(
      this.image,
      this.name,
      this.price,
      this.unit,
      this.ownerName,
      this.ownerProfileImage,
      this.description,
      this.location,
      this.pickUpTimes,
      this.expirationDate,
      this.isFree);
}

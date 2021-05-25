import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_test_app/models/persistant/UserAnalyticModel.dart';
import 'package:flutter_test_app/models/persistant/UserModel.dart';
import 'package:flutter_test_app/providers/UserAnalyticProvider.dart';
import 'package:flutter_test_app/providers/UserProvider.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/services/Authentication.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;
import 'package:flutter_test_app/utils/PlatformUtils.dart';
import 'package:flutter_test_app/widgets/CustomTextField.dart';

class LoginSignUpScreen extends StatefulWidget {
  LoginSignUpScreen({this.auth, this.onSignedIn});

  final BaseAuthentication auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginSignUpScreenState();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _nameTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _nameTextController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  String _errorMessage = "";

  // this will be used to identify the form to show
  FormMode _formMode = FormMode.LOGIN;
  bool _isIos = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: selectByPlatform(true, false),
        title: Text('ReFood'),
        elevation: 0,
        backgroundColor: ColorsLibrary.primaryColor,
      ),
      body: ListView(
        children: [Column(
          children: <Widget>[formWidget(_formMode), loginButtonWidget(), secondaryButton(), errorWidget(), progressWidget()],
        ),]
      ),
    );
  }

  Widget progressWidget() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget formWidget(FormMode formMode) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _formMode == FormMode.SIGNUP ? _nameWidget() : Container(),
          _emailWidget(formMode),
          _passwordWidget(),
        ],
      ),
    );
  }

  Widget _emailWidget(FormMode formMode) {
    return Padding(
        padding: formMode == FormMode.LOGIN ? const EdgeInsets.only(top: 24) : const EdgeInsets.only(top: 8),
      child: buildCustomTextField(
          CustomTextField(50, MediaQuery.of(context).size.width, 30, TextInputType.emailAddress, TextInputAction.next, 1,
              1, 'Электронный адрес', (String value) {
                if (value == null || value.isEmpty) {
                  return 'Введите почту';
                }
                return null;
              }, _emailTextController),
          context)
    );
  }

  Widget _passwordWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: buildCustomTextField(
          CustomTextField(50, MediaQuery.of(context).size.width, 30, TextInputType.visiblePassword, TextInputAction.next, 1,
              1, 'Пароль', (String value) {
                if (value == null || value.isEmpty) {
                  return 'Введите пароль';
                }
                return null;
              }, _passwordTextController),
          context),
    );
  }

  Widget _nameWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: buildCustomTextField(
          CustomTextField(50, MediaQuery.of(context).size.width, 30, TextInputType.visiblePassword, TextInputAction.next, 1,
              1, 'Имя', (String value) {
                if (value == null || value.isEmpty) {
                  return 'Введите имя';
                }
                return null;
              }, _nameTextController),
          context),
    );
  }

  Widget loginButtonWidget() {
    return Padding(
        padding: const EdgeInsets.only(right:  16, left: 16, top: 24,),
        child: ProgressButton(
          progressWidget: CircularProgressIndicator(backgroundColor: ColorsLibrary.whiteColor),
          color: ColorsLibrary.primaryColor,
          width: MediaQuery.of(context).size.width,
          height: 50,
          borderRadius: 30,
          onPressed: () {
            _validateAndSubmit();
          },
          defaultWidget: Text(_formMode == FormMode.LOGIN ? 'Войти' : 'Зарегистрироваться',
              style: selectByPlatform(
                  StylesLibrary.IOSPrimaryWhiteTextStyle, StylesLibrary.AndroidPrimaryWhiteTextStyle)
                  .merge(const TextStyle(color: ColorsLibrary.whiteColor, fontSize: 17))),
        ));
  }

  Widget secondaryButton() {
    return new FlatButton(
      child: _formMode == FormMode.LOGIN
          ? new Text('Создать аккаунт', style: selectByPlatform(
          StylesLibrary.IOSPrimaryBlackTextStyle, StylesLibrary.AndroidPrimaryBlackTextStyle).merge(TextStyle(color: ColorsLibrary.middleBlack)))
          : new Text('Уже есть аккаунт? Авторизуйтесь', style: selectByPlatform(
    StylesLibrary.IOSPrimaryBlackTextStyle, StylesLibrary.AndroidPrimaryBlackTextStyle).merge(TextStyle(color: ColorsLibrary.middleBlack))),
      onPressed: _formMode == FormMode.LOGIN ? showSignUpForm : showLoginForm,
    );
  }

  void showSignUpForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void showLoginForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  Widget errorWidget() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(fontSize: 13.0, color: Colors.red, height: 1.0, fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      String userId = "";
      try {
        if (_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_emailTextController.text, _passwordTextController.text);
          await global.userProvider.getCurrentUser();
        } else {
          userId = await widget.auth.signUp(_emailTextController.text, _passwordTextController.text);
          UserModel userItem = UserModel(
              id: userId,
              name: _nameTextController.text,
              profileImage: await global.userProvider.chooseUserDefaultImage(),
              rating: 0,
              aboutMe: "",
              countOfInFavorites: 0,
              magazineItems: [],
              favoritesIDs: [],
              addressDescription: "",
              addressID: "",
              orderItems: []);
          await global.userProvider.addUserItem(userItem);
          await global.userProvider.getCurrentUser();
          UserAnalyticModel userAnalyticModel =
              UserAnalyticModel(earnedBadgesIDs: [], lessCO2Value: 0, savedMassValue: 0, savedPositionsCount: 0);
          await UserAnalyticProvider().addUserAnalyticItem(userItem, userAnalyticModel);
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null) {
          widget.onSignedIn();
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.toString();
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

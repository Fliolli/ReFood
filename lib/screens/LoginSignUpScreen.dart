import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/models/persistant/UserAnalyticModel.dart';
import 'package:flutter_test_app/models/persistant/UserModel.dart';
import 'package:flutter_test_app/providers/UserAnalyticProvider.dart';
import 'package:flutter_test_app/providers/UserProvider.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/services/Authentication.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;

class LoginSignUpScreen extends StatefulWidget {
  LoginSignUpScreen({this.auth, this.onSignedIn});

  final BaseAuthentication auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginSignUpScreenState();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _name;
  String _errorMessage = "";

  // this will be used to identify the form to show
  FormMode _formMode = FormMode.LOGIN;
  bool _isIos = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorsLibrary.primaryColor,
      ),
      body: Column(
        children: <Widget>[
          formWidget(),
          loginButtonWidget(),
          secondaryButton(),
          errorWidget(),
          progressWidget()
        ],
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

  Widget formWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _formMode == FormMode.SIGNUP ? _nameWidget() : Container(),
          _emailWidget(),
          _passwordWidget(),
        ],
      ),
    );
  }

  Widget _emailWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Enter Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email cannot be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget _passwordWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password cannot be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget _nameWidget() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Name',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Name cannot be empty' : null,
        onSaved: (value) => _name = value.trim(),
      ),
    );
  }

  Widget loginButtonWidget() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: new MaterialButton(
          elevation: 5.0,
          minWidth: 200.0,
          height: 42.0,
          color: Colors.blue,
          child: _formMode == FormMode.LOGIN
              ? new Text('Login',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white))
              : new Text('Create account',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white)),
          onPressed: _validateAndSubmit,
        ));
  }

  Widget secondaryButton() {
    return new FlatButton(
      child: _formMode == FormMode.LOGIN
          ? new Text('Create an account',
              style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
          : new Text('Have an account? Sign in',
              style:
                  new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
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
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
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
          userId = await widget.auth.signIn(_email, _password);
          await global.userProvider.getCurrentUser();
        } else {
          userId = await widget.auth.signUp(_email, _password);
          UserModel userItem = UserModel(
              id: userId,
              name: _name,
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
          UserAnalyticModel userAnalyticModel = UserAnalyticModel(
              earnedBadgesIDs: [],
              lessCO2Value: 0,
              savedMassValue: 0,
              savedPositionsCount: 0);
          await UserAnalyticProvider()
              .addUserAnalyticItem(userItem, userAnalyticModel);
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

import 'package:flutter/material.dart';
import 'package:flutter_test_app/screens/HomeScreen.dart';
import 'package:flutter_test_app/screens/LoginSignUpScreen.dart';
import 'package:flutter_test_app/services/Authentication.dart';

class RootScreen extends StatefulWidget {
  RootScreen({this.auth});

  final BaseAuthentication auth;

  @override
  State<StatefulWidget> createState() => new _RootScreenState();
}

enum AuthenticationStatus {
  NOT_DETERMINED,
  LOGGED_OUT,
  LOGGED_IN,
}

class _RootScreenState extends State<RootScreen> {
  AuthenticationStatus authStatus = AuthenticationStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
        user?.uid == null ? AuthenticationStatus.LOGGED_OUT : AuthenticationStatus.LOGGED_IN;
      });
    });
  }

  void _onLoggedIn() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthenticationStatus.LOGGED_IN;
    });
  }

  void _onSignedOut() {
    setState(() {
      authStatus = AuthenticationStatus.LOGGED_OUT;
      _userId = "";
    });
  }

  Widget progressScreenWidget() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthenticationStatus.NOT_DETERMINED:
        return progressScreenWidget();
        break;
      case AuthenticationStatus.LOGGED_OUT:
        return new LoginSignUpScreen(
          auth: widget.auth,
          onSignedIn: _onLoggedIn,
        );
        break;
      case AuthenticationStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new HomeScreen(
            userId: _userId,
            auth: widget.auth,
            onSignedOut: _onSignedOut,
          );
        } else
          return progressScreenWidget();
        break;
      default:
        return progressScreenWidget();
    }
  }
}
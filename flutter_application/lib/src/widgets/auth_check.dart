import 'package:flutter/material.dart';
import 'package:flutter_application/src/pages/loginPage.dart';
import 'package:flutter_application/src/pages/mainPage.dart';
import 'package:flutter_application/src/services/auth_services.dart';
import "package:provider/provider.dart";

class AuthCheck extends StatefulWidget {
  AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading)
      return loading();
    else if (auth.usuario == null)
      return LoginPage();
    else
      return MainPage(title: '');
  }

  loading() {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}

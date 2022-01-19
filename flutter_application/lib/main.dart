import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application/src/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/src/pages/qrcodePage.dart';
import 'package:flutter_application/src/pages/singupPage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'src/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then(
    (_) => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  final _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }

          return MaterialApp(
            title: 'NF-DosGu ',
            theme: AppTheme.lightTheme.copyWith(),
            debugShowCheckedModeBanner: false,

            home: QRCodePage(),
            //oginPage(),
            // routes: Routes.getRoute(),
            // initialRoute: '/',
          );
        });
  }
}

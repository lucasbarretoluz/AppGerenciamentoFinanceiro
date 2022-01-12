import 'package:flutter/material.dart';
import 'package:flutter_application/src/pages/homePage.dart';
import 'package:flutter_application/src/pages/mainPage.dart';
import 'package:flutter_application/src/pages/qrcodePage.dart';
import 'package:flutter_application/src/widgets/calendar.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => MainPage(
            title: '',
          ),
      '/home': (_) => MyHomePage(title: ''),
      '/calendar': (_) => TableEventsExample(),
      '/qr': (_) => QRCodePage(),
    };
  }
}

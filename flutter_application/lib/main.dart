import 'package:flutter/material.dart';
import 'package:flutter_application/src/config/route.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'src/themes/theme.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NF-DosGu ',
      theme: AppTheme.lightTheme.copyWith(
          // textTheme: GoogleFonts.mulishTextTheme(

          //   Theme.of(context).textTheme,
          // ),
          ),
      debugShowCheckedModeBanner: false,
      routes: Routes.getRoute(),
      // onGenerateRoute: (RouteSettings settings) {
      //   if (settings.name.contains('detail')) {
      //     return CustomRoute<bool>(
      //         builder: (BuildContext context) => ProductDetailPage());
      //   } else {
      //     return CustomRoute<bool>(
      //         builder: (BuildContext context) => MainPage());
      //   }
      // },
      initialRoute: '/',
    );
  }
}

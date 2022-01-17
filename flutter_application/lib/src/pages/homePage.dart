// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/src/themes/light_color.dart';
import 'package:flutter_application/src/themes/theme.dart';
import 'package:flutter_application/src/widgets/calendar.dart';
import 'package:flutter_application/src/widgets/extentions.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     height: MediaQuery.of(context).size.height - 210,
  //     child: SingleChildScrollView(
  //       physics: BouncingScrollPhysics(),
  //       dragStartBehavior: DragStartBehavior.down,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: <Widget>[
  //           TableEventsExample(),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget build (BuildContext context){
    return Scaffold(
      body: Container(
        child: TableEventsExample(),
      ),
    );
  }
  
}

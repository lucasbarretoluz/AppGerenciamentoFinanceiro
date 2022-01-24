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
  late double height, width;

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

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                 SizedBox(height: 16),
                Text(
                  'Home',
                  style: TextStyle(
                      color: LightColor.orange,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox( height: 20,),
                Container(
                  child: TableEventsExample(),
                  height: height * .52,
                  width: width * .9,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                SizedBox( height: 10,),
                Container(
                  height: height * .25,
                  width: width * .9,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  // Widget build (BuildContext context){
  //   return Scaffold(
  //     body: Container(
  //       child: TableEventsExample(),
  //     ),
  //   );
  // }

}

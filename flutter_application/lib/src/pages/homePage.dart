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
  late double heightScreen, widthScreen;

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
    heightScreen = MediaQuery.of(context).size.height;
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                 SizedBox(height: heightScreen * .16), //testar para deixar responsivo
                Text(
                  'Home',
                  style: TextStyle(
                      color: LightColor.orange,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox( height: heightScreen * .20,), //testar para deixar responsivo
                Container(
                  child: TableEventsExample(),
                  height: heightScreen * .52,
                  width: widthScreen * .9,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                SizedBox( height:  heightScreen * .10,),  //testar para deixar responsivo
                Container(
                  height: heightScreen * .25,
                  width: widthScreen * .9,
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

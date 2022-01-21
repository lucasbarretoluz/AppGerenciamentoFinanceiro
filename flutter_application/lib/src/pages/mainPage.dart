import 'package:flutter/material.dart';
import 'package:flutter_application/src/pages/qrcodePage.dart';
import 'package:flutter_application/src/themes/light_color.dart';
import 'package:flutter_application/src/themes/theme.dart';
import 'package:flutter_application/src/widgets/BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:flutter_application/src/widgets/calendar.dart';
import 'package:flutter_application/src/widgets/extentions.dart';

import 'config.dart';
import 'homePage.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isHomePageSelected = true;
  int intPageSelected = 0;

  get child => null;
  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RotatedBox(
            quarterTurns: 4,
            child: _icon(Icons.sort, color: Colors.black54),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff8f8f8),
                      blurRadius: 10,
                      spreadRadius: 10),
                ],
              ),
            ),
          ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)))
        ],
      ),
    );
  }

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

  void onBottomIconPressed(int index) {
    switch (index) {
      case 0:
        setState(() {
          intPageSelected = 0;
        });
        return;
      case 1:
        setState(() {
          intPageSelected = 1;
        });
        return;
      case 2:
        setState(() {
          intPageSelected = 2;
        });
        break;
      case 3:
        setState(() {
          intPageSelected = 3;
        });
        break;
      default:
    }
  }

  Widget thePage(int intPageSelected) {
    List<Widget> paginas = [
      MyHomePage(
        title: '',
      ),
      TableEventsExample(),
      QRCodePage(),
      ConfigPage()
    ];

    return paginas[intPageSelected];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: AppTheme.fullHeight(context) - 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xfffbfbfb),
                      Color(0xfff7f7f7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // _appBar(),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        switchInCurve: Curves.easeInToLinear,
                        switchOutCurve: Curves.easeOutBack,
                        child: thePage(intPageSelected),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomBottomNavigationBar(
                onIconPresedCallback: onBottomIconPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}

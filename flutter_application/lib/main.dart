import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/src/config/route.dart';
import 'package:flutter_application/src/pages/mainPage.dart';
import 'package:flutter_application/src/services/auth_services.dart';
import 'package:flutter_application/src/widgets/auth_check.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'src/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  ); //inicializa o firebase
  initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthService()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NF-DosGu ',
      theme: AppTheme.lightTheme.copyWith(),
      debugShowCheckedModeBanner: false,

      home: AuthCheck(),
      // routes: Routes.getRoute(),
      // initialRoute: '/',
    );
  }
}

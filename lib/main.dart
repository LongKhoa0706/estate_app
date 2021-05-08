
import 'package:estate_app/src/router/router.dart';

import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/screen/register_screen/registerscreen.dart';
import 'package:estate_app/src/screen/resutl_search_screen.dart';
import 'package:estate_app/src/screen/splashscreen/splashscreen.dart';
import 'package:estate_app/src/screen/verify_code_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterLibphonenumber().init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: ResutlSearchScreen(),
      initialRoute: SplashScreens,
      onGenerateRoute: Routerr.onGenerateRouter,
    );
  }
}

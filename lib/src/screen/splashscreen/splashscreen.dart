import 'dart:async';

import 'package:estate_app/src/animation/fadeanimation.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/service/share_pref.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_update/in_app_update.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String email;
  AppUpdateInfo _updateInfo;
  bool isLoading = false;

  void getAccount() async {
    email = await SharedPrefService.getString(key: Constant.KEY_TOKEN);
    // String password = await SharedPrefService.get(key: 'password');
  }

  Future<void> checkForUpdate() async {
    setState(() {
      isLoading = true;
    });
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) => showToast.displayToast(e.toString(), Colors.red));

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAccount();
    Timer(Duration(seconds: 2), () {
      if (email == null) {
        Navigator.pushReplacementNamed(context, OnboadingScreens);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, DashBoardScreens, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().initScreen(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding:
            EdgeInsets.symmetric(vertical: SizeConfig().getScreenHeight(20)),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            FadeAnimation(
              .9,
              Container(
                  child: SvgPicture.asset(
                'assets/logo/logo.svg',
                fit: BoxFit.cover,
              )),
            ),
            // RaisedButton(
            //   child: Text("Check"),
            //   onPressed: (){
            //     checkForUpdate();
            //   },
            // ),

          ],
        ),
      ),
    );
  }
}

import 'dart:async';

// import 'package:connectivity/connectivity.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:estate_app/src/networkings/apiClient.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/screen/dashboard/tab/home/hometab.dart';
import 'package:estate_app/src/screen/dashboard/tab/profile/profile_tab.dart';
import 'package:estate_app/src/service/share_pref.dart';
import 'package:estate_app/src/utils/DoubleBackToClose.dart';
import 'package:estate_app/src/utils/endpoint.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/screen/contract_screen/contractscreen.dart';
import 'package:estate_app/src/screen/detailinformationscreen.dart';
import 'package:estate_app/src/screen/dashboard/tab/noticication/notificationtab.dart';

import 'package:estate_app/src/screen/dashboard/tab/social/socialtab.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/utils/toast.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  // StreamSubscription<ConnectivityResult> _connectivitySubscription;
  // final Connectivity _connectivity = Connectivity();
  String result = '';
  bool isShow = false;
  var Colorsval = Colors.red;
  static int currentIndex = 0;
  List<Widget> listScreen() => [
      HomeTab(),
      // SocialTab(),
      ContractScreen(),
      ProfileTab(),
  ];

  void getAccount() async {
    String email = await SharedPrefService.getString(key: 'account');
    // String password = await SharedPrefService.get(key: 'password');
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // CheckStatus();
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      showToast.displayToast("Chạm lần nữa để thoát", Colors.red);
      return Future.value(false);
    }
    return Future.value(true);
  }
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = listScreen();
    return Scaffold(
      // // backgroundColor: Colorsval,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: currentIndex !=0 ?null : FloatingActionButton(
      //   backgroundColor: kColorPrimary,
      //   onPressed: () {
      //     Navigator.pushNamed(context, AddProjectScreens,arguments: null);
      //   },
      //   child: Icon(Icons.add),
      // ),
      bottomNavigationBar:SizedBox(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0.0,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          unselectedItemColor: Colors.grey[400],
          selectedItemColor: kColorPrimary,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[

            _buildBottomNavigationBarItem(Icons.home,"Trang chủ"),
            // _buildBottomNavigationBarItem(Icons.group,"Cộng đồng"),
            _buildBottomNavigationBarItem(Icons.headset_mic, "Liên hệ"),
            _buildBottomNavigationBarItem(Icons.person, "Thông tin"),
          ],
        ),
      ),
      body:WillPopScope(
        onWillPop: onWillPop,
        child: Stack(
          children: [
            Visibility(
              visible: true,
              child: IndexedStack(index: currentIndex, children: children),
            ),
             // Visibility(
             //   visible: !isShow,
             //   child: Center(
             //     child: Column(
             //       mainAxisAlignment: MainAxisAlignment.center,
             //       children: [
             //         Text("Không thể truy cập internet"),
             //       ],
             //     ),
             //   )
             // )
          ],
        ),
      ),
    );
  }
}
_buildBottomNavigationBarItem(IconData iconData, String text) {
  return BottomNavigationBarItem(

    title: Text(text,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
      icon: Icon(
        iconData,
        size: SizeConfig().getScreenWidth(18),
      ),
     );
}


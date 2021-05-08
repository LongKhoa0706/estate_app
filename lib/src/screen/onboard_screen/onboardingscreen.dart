import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/screen/login_screen/loginscreen.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/screen/dashboard/dashboard.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;

  final swiperController = SwiperController();

  List<String> listImage = [
    'assets/onboard/onboard1.png',
    'assets/onboard/onboard2.png',
    'assets/onboard/onboard3.png',
  ];

  List<String> listTitle = [
    "Kết nối ",
    "Tìm kiếm ",
    "Tra cứu tin tức",
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: SizeConfig().getScreenHeight(30)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, LoginScreens);
                  },
                  child: Align(
                      alignment: Alignment.topRight, child: Text("Skip"))),
            ),
            Expanded(
              child: Swiper(
                loop: false,
                itemCount: 3,
                index: currentIndex,
                onIndexChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                controller: swiperController,
                pagination: SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(
                    right: 10,
                    bottom: SizeConfig().getScreenHeight(30),
                  ),
                  builder: DotSwiperPaginationBuilder(
                    activeColor: kColorPrimary,
                    color: Colors.orange[200],
                    size: 8
                  ),
                ),
                itemBuilder: (context, index) {
                  return IntroItem(
                    title: listTitle[index],
                    image: listImage[index],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: kColorPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  onPressed: () {
                    currentIndex !=2 ? swiperController.next() :  Navigator.pushReplacementNamed(context, LoginScreens);
                  },
                  child: currentIndex != 2
                      ? Text(
                          "Tiếp tục",
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          "Bắt đầu ",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IntroItem extends StatelessWidget {
  final String image;
  final String title;

  const IntroItem({Key key, this.image, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

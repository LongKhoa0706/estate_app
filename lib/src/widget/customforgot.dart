import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomForgot extends StatelessWidget {
  final String title;
  final String titleAppBar;
  final String imageAssets;
  final Widget child;
  final VoidCallback onPressed;

  const CustomForgot({Key key, @required this.title,@required this.titleAppBar,@required this.imageAssets, this.child, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,size: 18,color: Colors.black,),
              onPressed: onPressed),
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(titleAppBar,
            style: TextStyle(
              color: kColorPrimary,
                fontFamily: kFontBold
            ),),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                    width: double.infinity,
                    height: 200,
                    child: SvgPicture.asset(imageAssets,),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),),
                ),
                SizedBox(
                  height: 30,
                ),
                child
              ],
            ),
          ),
        )
    );
  }
}

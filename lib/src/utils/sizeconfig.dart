import 'package:flutter/cupertino.dart';

class SizeConfig{
 static MediaQueryData mediaQueryData;
 static double sizeWidth;
  static  double sizeHeight;

  void initScreen(BuildContext context){
    mediaQueryData = MediaQuery.of(context);
    sizeHeight = mediaQueryData.size.height;
    sizeWidth = mediaQueryData.size.width;
  }

  double getScreenHeight(double inputHeight){
    double screenHeght = SizeConfig.sizeHeight;
    //812 height designer use
    return (inputHeight / 812.0) * screenHeght;
  }

  double getScreenWidth(double intputWidth){
    //375 height designer use

    double screenWidth = SizeConfig.sizeWidth;
    return (intputWidth / 375.0 ) * screenWidth;
  }

}
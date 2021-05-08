import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(

                          icon: Icon(Icons.arrow_back_ios,size: 15,),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                      alignment: Alignment.topLeft,),
                      TextView(
                        sizeText: 22,
                        text: "Trợ giúp ",
                        textColor: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(0.0),

                        leading: SvgPicture.asset('assets/icon/iconsupport3.svg'),
                        title:  TextView(
                          text: "Dành cho người bán",
                          textColor: Colors.black,
                          sizeText: 20,
                          fontWeight: FontWeight.w200,
                        ),
                        subtitle: TextView(
                          text: "Trả lời các câu hỏi và hướng dẫn để làm sao bài đăng nổi bật nhất...",
                          textColor: Colors.black,
                          sizeText: 12,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(0.0),

                        leading: SvgPicture.asset('assets/icon/iconsupport2.svg'),
                        title:  TextView(
                          text: "Dành cho người mua",
                          textColor: Colors.black,
                          sizeText: 20,
                          fontWeight: FontWeight.w200,
                        ),
                        subtitle: TextView(
                          text: "Trả lời các câu hỏi và hướng dẫn để làm sao bài đăng nổi bật nhất...",
                          textColor: Colors.black,
                          sizeText: 12,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Container(

                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                        child: TextView(
                          sizeText: 15,
                          text: "Hoặc gọi điện cho trung tâm CSKH của chúng tôi để nhận được sử trợ giúp nhanh nhất",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(18),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kColorPrimary,
                        ),
                        child: Center(
                          child: TextView(
                            sizeText: 25,
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                            text: "0978161344",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/logo/logo.png'),

                                )
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    text: "Công Ty cổ phần Billionaire Group",
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),

                                  _buildIconStatus(Icons.location_on_rounded,"Tầng 16-Landmark5-205 Nguyễn Hữu Cảnh-p22-Q.Bình Thạnh,Tp,HCM"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _buildIconStatus(Icons.info,"https://billionaire-group.net"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _buildIconStatus(Icons.email,"info@gmail.com")
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  _buildIconStatus(IconData iconData,String title){
    return  Row(

      children: [
        Icon(iconData,size: 16,color: Colors.grey,),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextView(
            text: title,
            fontWeight: FontWeight.w200,
          ),
        )
      ],
    );
  }
}

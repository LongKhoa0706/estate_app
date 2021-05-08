import 'package:flutter/material.dart';

class NotificationTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Text("Thông Báo",style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold
              ),),
              
              Text("Chức năng đang phát triển ")
              // ListView.separated(itemBuilder: (_,index){
              //   return Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 10),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Container(
              //           width: 35,
              //           height: 35,
              //           decoration: BoxDecoration(
              //             color: Colors.red,
              //             shape: BoxShape.circle,
              //           ),
              //         ),
              //         const SizedBox(
              //           width: 10,
              //         ),
              //         Text(
              //               "abc vừa mới đăng thông tin",
              //               style: TextStyle(
              //                 color: Colors.black,
              //               ),
              //             ),
              //           ],
              //     ),
              //   );
              // },
              //   physics: NeverScrollableScrollPhysics(),
              //   separatorBuilder: (BuildContext context, int index) => Divider(height: 1),
              //   itemCount: 30,
              //   shrinkWrap: true,),
            ],
          ),
        )
      ),
    );
  }
}

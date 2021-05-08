import 'package:estate_app/src/utils/const.dart';
import 'package:flutter/material.dart';

class ContractScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // List<String> listImage = [];
    // for(int i = 1; i < 5; i ++){
    //   String linkImage = 'assets/contract/image$i.jpg';
    //   listImage.add(linkImage);
    // }
    // List<String>listTitle = [
    //   'BILLIONAIRE HỒ CHÍ MINH ',
    //   'BILLIONAIRE CẦN THƠ ',
    //   'BILLIONAIRE LONG AN ',
    //   'BILLIONAIRE VĨNH LONG ',
    // ];
    // List<String> listAddress = [
    //     'Landmart5, Vinhomes Central park, 208 Nguyễn Hữu Cảnh, P.22, Q. Bình Thạnh, TPHCM',
    //     '',
    //     '',
    //     'Đường 3/2, Cái Vồn, TX Bình Minh, Vĩnh Long',
    // ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorPrimary,
        title: Text("Liên hệ"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text("Công ty cổ phần Billionaire",style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.call),
                        SizedBox(
                          width: 10,
                        ),
                        Text('02873036859'),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(Icons.email),
                        SizedBox(
                          width: 10,
                        ),
                        Text('info@billionaire-group.vn'),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: Text('Landmark 5, Vinhomes Central Park , 208 Nguyễn Hữu Cảnh, P.22, Q. Bình Thạnh, TP. Hồ Chí Minh')),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Icon(Icons.person_outline,size: 20,),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey,
                        width: 0.5
                    ),
                    borderRadius: BorderRadius.circular(5)
                ),
                height: 50,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Tên"),
              SizedBox(
                height: 15,
              ),
              Icon(Icons.email,size: 20,),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey,
                        width: 0.5
                    ),
                    borderRadius: BorderRadius.circular(5)
                ),
                height: 50,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text("Email"),
              SizedBox(
                height: 15,
              ),
              Icon(Icons.edit,size: 20,),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey,
                    )
                ),
                height: 150,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Mô tả"),
              SizedBox(
                height: 15,
              ),
              // Center(
              //   child: RaisedButton(
              //     color: kcolorGreen3,
              //     onPressed: (){
              //
              //     },
              //     child: Text("Gửi",style: TextStyle(
              //         color: Colors.white
              //     ),),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
  _buildInfoContract(IconData iconData,String title){
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Icon(iconData,size: 17,color: kColorPrimary,),
          const SizedBox(
            width: 8,
          ),
          Expanded(child: Text(title)),
        ],
      ),
    );

  }
}

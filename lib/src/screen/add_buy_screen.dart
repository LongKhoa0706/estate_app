import 'package:estate_app/src/bloc/add_new/add_new_bloc.dart';
import 'package:estate_app/src/model/city.dart';
import 'package:estate_app/src/model/new.dart';
import 'package:estate_app/src/repositories/repositories/city_repositories.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/toast.dart';
import 'package:estate_app/src/utils/validator.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBuyScreen extends StatefulWidget {
  @override
  _AddBuyScreenState createState() => _AddBuyScreenState();
}

class _AddBuyScreenState extends State<AddBuyScreen> {
  final nameController = TextEditingController();
  final phoneController  = TextEditingController();
  CityRepositories cityRepositories = CityRepositories();
  AddNewBloc addNewBloc = AddNewBloc();
  Address selectCity;
  Address selectDistrict;
  Address selectWard;
  // Address selectCity;

  final address  = StringBuffer();
  List<Address> listCity = List();
  List<Address> listDistrict = List();
  List<Address> listWard = List();
  bool isLoading = false;

  void getData() async {
    isLoading = true;
    setState(() {

    });
    listCity = await cityRepositories.getAllCity();
    isLoading = false;
    setState(() {

    });
    selectCity = listCity[0];
  }

  List<String> listDropdown = [
    'Đất nền',
    'Nhà phố',
    'Căn hộ',
    'Biệt thự',
    'Chung cư ',
    'Nhà trọ',
    'Cho thuê',
  ];


  String value;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  void createNews(){
    New news = New(
      username: nameController.text,
      phone: phoneController.text,
      type: value,
      location: selectCity.title + " "+  selectDistrict.title + " " +selectWard.title,
    );
    addNewBloc.add(AddNewEventSubmit(news));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addNewBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    if ( selectCity != null && selectDistrict != null && selectWard != null) {
      List<String> listCode = [selectCity.title,selectDistrict.title,selectWard.title];
      if (listCode.isNotEmpty) {
        for(int i = 0 ; i < 3;i++ ){
          print(listCode[0] + listCode[1] + listCode[2]  );
          address.write(listCode[0] + listCode[1] + listCode[2] );
        }
        // listCode.forEach((element) {
        //   address.write(element+",");
        // });
        // print(address.toString());
      }
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,
            size: 15,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        title: Text("Đăng bài",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: BlocListener<AddNewBloc,AddNewState>(
              cubit: addNewBloc,
              listener: (context,state){
                if (state is AddNewStateSuccess) {
                  showToast.displayToast("Đăng tin thành công", Colors.green);
                  Navigator.pop(context,true);
                }
                if (state is AddNewStateFail) {
                  showToast.displayToast("Đăng tin thất bại", Colors.red);
                }
                if (state is AddNewStateLoading) {
                  return WidgetsBinding.instance.addPostFrameCallback((_) =>Loading());
                }  
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  TextForm(
                    textEditingController: nameController,
                    validator: (String value){
                      return  Validator().validatorInput(value);
                    },
                    keyBoardType: TextInputType.text,
                    title: "Tên liên hệ",
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextForm(
                    textEditingController: phoneController,
                    validator: (String value){
                      return  Validator().validatorPhone(value);
                    },
                    keyBoardType: TextInputType.number,
                    title: "Số điện thoại",
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text("Địa chỉ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: 10),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.grey.withOpacity(.3),
                        ),
                        BoxShadow(
                          offset: Offset(-2, 1),
                          blurRadius: 10,
                          color: Color(0xffb8bfce).withOpacity(.1),
                        )
                      ],
                    ),
                    child:  DropdownButtonHideUnderline(
                      child: DropdownButton<Address>(
                          items: listCity.map((e) => DropdownMenuItem<Address>(
                            value: e,
                            child: Text(e.title),
                          )).toList(),
                          value: selectCity,
                          isExpanded: true,
                          style: TextStyle(fontSize: 15,color: Colors.black),
                          onChanged: (Address valuee) async {
                            setState(() {
                              selectCity = valuee;
                            });
                            listDistrict = await cityRepositories.getDistrictByCity(selectCity.iD);
                            selectDistrict = null;
                            setState(() {

                            });
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          padding: EdgeInsets.symmetric(horizontal: 10),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(1, 1),
                                blurRadius: 2,
                                color: Colors.grey.withOpacity(.3),
                              ),
                              BoxShadow(
                                offset: Offset(-2, 1),
                                blurRadius: 10,
                                color: Color(0xffb8bfce).withOpacity(.1),
                              )
                            ],
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Address>(
                                items: listDistrict.map((e) => DropdownMenuItem<Address>(
                                  value: e,
                                  child: Text(e.title),
                                )).toList(),
                                value: selectDistrict,
                                isExpanded: true,
                                hint: Text("Quận/huyện"),
                                style: TextStyle(fontSize: 15,color: Colors.black),
                                onChanged: (Address valuee) async {
                                  setState(() {
                                    selectDistrict = valuee;
                                  });
                                  listWard = await cityRepositories.getWardByDistrict(selectDistrict.iD);
                                  selectWard = null;
                                  setState(() {

                                  });
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(1, 1),
                                blurRadius: 2,
                                color: Colors.grey.withOpacity(.3),
                              ),
                              BoxShadow(
                                offset: Offset(-2, 1),
                                blurRadius: 10,
                                color: Color(0xffb8bfce).withOpacity(.1),
                              )
                            ],
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Address>(
                                items: listWard.map((e) => DropdownMenuItem<Address>(
                                  value: e,
                                  child: Text(e.title),
                                )).toList(),
                                value: selectWard,
                                isExpanded: true,
                                hint: Text("Xã"),
                                style: TextStyle(fontSize: 15,color: Colors.black),
                                onChanged: (Address valuee) async {
                                  setState(() {
                                    selectWard = valuee;
                                  });
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Loại hình cần thuê",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.grey.withOpacity(.3),
                        ),
                        BoxShadow(
                          offset: Offset(-2, 1),
                          blurRadius: 10,
                          color: Color(0xffb8bfce).withOpacity(.1),
                        )
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          items: listDropdown.map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          )).toList(),
                          value: value,
                          isExpanded: true,
                          style: TextStyle(fontSize: 15,color: Colors.black),
                          hint: Text("Vui lòng chọn thể loại "),
                          onChanged: (String valuee){
                            setState(() {
                              value = valuee;
                            });
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: RaisedButton(
                      color: kColorPrimary,
                      onPressed: createNews,
                      child: Text("Đăng",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:  16
                        ),),

                    ),
                  )
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
class TextForm extends StatelessWidget {
  final String hintText;
  final FormFieldValidator<String> validator;
  final TextInputType keyBoardType;
  final TextEditingController textEditingController;
  final String title;

  const TextForm({Key key,  this.textEditingController, this.validator, this.keyBoardType, this.title, this.hintText}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),),
        SizedBox(
          height: 14,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                blurRadius: 2,
                color: Colors.grey.withOpacity(.3),
              ),
              BoxShadow(
                offset: Offset(-2, 1),
                blurRadius: 10,
                color: Color(0xffb8bfce).withOpacity(.1),
              )
            ],
          ),
          child: TextFormField(
            validator: validator,
            keyboardType: keyBoardType,
            controller: textEditingController,
            decoration: InputDecoration(
              border: InputBorder.none
            ),
          ),
        ),
      ],
    );
  }
}


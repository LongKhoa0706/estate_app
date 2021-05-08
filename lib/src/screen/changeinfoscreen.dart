import 'dart:math';

import 'package:estate_app/src/bloc/update_user/update_user_bloc.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/screen/detailinformationscreen.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/toast.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChangeInfoScreen extends StatefulWidget {
 final Users user;

  const ChangeInfoScreen({Key key, this.user}) : super(key: key);

  @override
  _ChangeInfoScreenState createState() => _ChangeInfoScreenState();
}

class _ChangeInfoScreenState extends State<ChangeInfoScreen> {
  TextEditingController nameController;
  TextEditingController phoneController;
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController;
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController infoController;
  TextEditingController emailController;

  UpdateUserBloc updateUserBloc = UpdateUserBloc();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    // dateController.dispose();
    updateUserBloc.close();
    infoController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void updateUser() {
    print(dateController.text);
    updateUserBloc.add(UpdateUserInforEvent(nameController.text,dateController.text,infoController.text,firstNameController.text,lastNameController.text));

  }

 @override
  void initState() {
    firstNameController = TextEditingController(text: widget.user.firstname);
    lastNameController = TextEditingController(text: widget.user.lastname);
    dateController = TextEditingController(text: widget.user.birthDay);
    emailController = TextEditingController(text: widget.user.email);
    nameController = TextEditingController(text: widget.user.username);
    phoneController = TextEditingController(text: widget.user.phone);
    infoController = TextEditingController(text: widget.user.personalInfo);
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1700),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var dateFormat = new DateFormat('dd-MM-yyyy');
        String formattedDate = dateFormat.format(picked);
        dateController.value = TextEditingValue(text: formattedDate);
        // var inputFormat = DateFormat('dd/MM/yyyy HH:mm');
        // var inputDate = inputFormat.parse(picked.toString()); // <-- Incoming date
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UpdateUserBloc,UpdateUserState>(
        cubit: updateUserBloc,
        builder: (BuildContext context,state){
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    IconButton(
                        alignment: Alignment.topLeft,
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                        ),
                        onPressed: () => Navigator.pop(context)),
                    Text(
                      "Đổi Thông Tin",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    _buildTitle("Tên đăng nhập "),
                    SizedBox(
                      height: 13,
                    ),
                    InkWell(
                      onTap: (){
                        showToast.displayToast("Không thể thay đổi tên đăng nhập", Colors.red);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                              width: .3,
                            )),
                        child: TextFormField(
                          readOnly: true,
                          controller: nameController,
                          decoration: InputDecoration(
                            enabled: false,
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.person,
                              size: 20,
                              color: kColorPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildTitle("Họ"),
                    SizedBox(
                      height: 13,
                    ),
                    Container(
                      width: double.infinity,
                      height: 45,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                            width: .3,
                          )),
                      child: TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person,
                            size: 20,
                            color: kColorPrimary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildTitle("Tên "),

                    SizedBox(
                      height: 13,
                    ),
                    Container(
                      width: double.infinity,
                      height: 45,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                            width: .3,
                          )),
                      child: TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person,
                            size: 20,
                            color: kColorPrimary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildTitle("Số điện thoại"),
                    SizedBox(
                      height: 13,
                    ),
                  InkWell(
                    onTap: (){
                      showToast.displayToast("Không thể thay đổi số điện thoại", Colors.red);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                            width: .3,
                          )),
                      child: TextFormField(
                        readOnly: true,
                        controller: phoneController,
                        decoration: InputDecoration(
                          enabled: false,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.phone,
                            size: 20,
                            color: kColorPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 20,
                    ),
                    _buildTitle("Email"),
                    SizedBox(
                      height: 13,
                    ),
                    InkWell(
                      onTap: (){
                        showToast.displayToast("Không thể thay đổi email", Colors.red);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                              width: .3,
                            )),
                        child: TextFormField(
                          readOnly: true,
                          controller: emailController,
                          decoration: InputDecoration(
                            enabled: false,
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.email,
                              size: 20,
                              color: kColorPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _buildTitle("Ngày sinh"),
                    SizedBox(
                      height: 13,
                    ),

                    Container(
                  width: double.infinity,
                  height: 45,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                        width: .3,
                      )
                  ),
                  child:TextFormField(
                    onTap: (){
                      _selectDate(context);
                    },
                    controller: dateController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.date_range,size: 20,color: kColorPrimary,),
                    ),
                  ),
                ),
                    SizedBox(
                      height: 15,
                    ),
                    _buildTitle("Giới thiệu"),
                    SizedBox(
                      height: 13,
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                            width: .3,
                          )
                      ),
                      child: TextField(
                        controller: infoController,
                        expands: false,
                        onTap: (){
                          FocusScope.of(context).unfocus();
                        },
                        maxLines: null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Giới thiệu "
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),

                    BlocListener<UpdateUserBloc,UpdateUserState>(
                      cubit: updateUserBloc,
                      listener: (context,state){
                        if (state is UpdateUserStateFail) {
                          // Navigator.pop(context);
                          showToast.displayToast(state.error, Colors.red);
                        }

                        if (state is UpdateUserStateSuccess) {
                          Navigator.pop(context,true);
                          showToast.displayToast("Thành công", Colors.green);
                        }
                      },
                      child: BlocBuilder<UpdateUserBloc,UpdateUserState>(
                        cubit: updateUserBloc,
                        builder: (_,state){
                          if (state is UpdateUserStateLoading) {
                            return Loading();
                          }
                          return    Center(
                            child: SizedBox(
                              width: 200,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: kColorPrimary,
                                onPressed:(){
                                  updateUser();
                                },
                                child: Text('Cập nhật',style: TextStyle(
                                    color: Colors.white
                                ),),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
          );
        },
      )
    );
  }

  _buildTitle(String title){
    return  Text('$title:',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
      ),);
  }

  _buildTextField(IconData icon,
      TextEditingController textEditingController){
    return Container(
      width: double.infinity,
      height: 45,
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.grey,
            width: .3,
          )
      ),
      child:TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(icon,size: 20,color: kColorPrimary,),
        ),
      ),
    );
  }
}

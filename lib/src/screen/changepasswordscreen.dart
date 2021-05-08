import 'package:estate_app/src/bloc/update_password/update_password_bloc.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/validator.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final oldPasswordController = TextEditingController();
  FToast fToast;
  final formState = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();

  final rePasswordController = TextEditingController();
  UpdatePasswordBloc updatePasswordBloc = UpdatePasswordBloc();


  @override
  void initState() {
    // TODO: implement initState
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  showToast(String message,Color color) {
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: color,
        ),
        child: Text(message,style: TextStyle(color: Colors.white)
        ));
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

   submit()  {
    if (formState.currentState.validate()) {
      if (newPasswordController.text == rePasswordController.text) {
          updatePasswordBloc.add(UpdatePasswordEventSubmit(oldPasswordController.text, newPasswordController.text));
          oldPasswordController.clear();
          newPasswordController.clear();
          rePasswordController.clear();
      }else{
        showToast('Mật khẩu không trùng khớp',Colors.red);
      }
    }
  }

  @override
  void dispose() {
    updatePasswordBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UpdatePasswordBloc,UpdatePasswordState>(
        listener: (previous,state){
          if (state is UpdatePasswordStateFail) {
            showToast(state.error,Colors.red);
          }
          if (state is UpdatePasswordStateSuccess) {
            showToast(state.message,Colors.green);
          }
          if (state is UpdatePasswordStateLoading) {
            return Center(
              child: Loading(),
            );
          }
        },
        cubit: updatePasswordBloc,
        child: Form(
          key: formState,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                IconButton(
                    alignment: Alignment.topLeft,
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 15,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Text(
                  "Thay Đổi Mật Khẩu ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                buildTextFiel("Mật khẩu hiện tại", oldPasswordController,(value){
                  return Validator().validatorPassword(value);
                }),
                SizedBox(
                  height: 20,
                ),
                buildTextFiel("Mật khẩu mới", newPasswordController,(value){
                  return Validator().validatorPassword(value);
                }),
                SizedBox(
                  height: 20,
                ),
                buildTextFiel("Nhập lại mật khẩu", rePasswordController,(value){
                  return Validator().validatorPassword(value);
                }),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 45,
                    child: RaisedButton(
                      color: kColorPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: submit,
                      child: Text('Xác Nhận',
                        style: TextStyle(
                            color: Colors.white
                        ),),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),

    );
  }

  Widget buildTextFiel(String title,TextEditingController controller,FormFieldValidator validator){
    return TextFormField(
      obscureText: true,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: kColorPrimary,
          fontSize: 14
        ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kColorPrimary),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          labelText: title,
        border: UnderlineInputBorder(
            borderSide:  BorderSide(
                color: kColorPrimary
            )
        )
      ),

    );
  }
}

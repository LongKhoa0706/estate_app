import 'package:estate_app/src/bloc/change_password/change_password_bloc.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/utils/toast.dart';
import 'package:estate_app/src/utils/validator.dart';
import 'package:estate_app/src/widget/customforgot.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:estate_app/src/widget/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPassScreen extends StatefulWidget {
  final String email;

  const NewPassScreen({Key key, this.email}) : super(key: key);

  @override
  _NewPassScreenState createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ChangePasswordBloc changePasswordBloc = ChangePasswordBloc();

  void changePassword(){
    if (formKey.currentState.validate()) {
      print(widget.email);
      changePasswordBloc.add(ChangePasswordEventSubmit(widget.email, passwordController.text, rePasswordController.text));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    changePasswordBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return CustomForgot(
        title: "Vui lòng nhập mật khẩu mới",
        child: Form(
          key:formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Mật khẩu mới",style: TextStyle(
                fontFamily: kFontBold
              ),),
              TextFormField(
                controller: passwordController,
                autocorrect: true,
                validator: (value){
                  return Validator().validatorPassword(value);
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey,width: 1.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey,width: 1.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text("Nhập lại mật khẩu",
              style: TextStyle(
                fontFamily: kFontBold
              ),),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: rePasswordController,
                autocorrect: true,
                validator: (value){
                  return Validator().validatorPassword(value);
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey,width: 1.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey,width: 1.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  child: BlocListener<ChangePasswordBloc,ChangePasswordState>(
                    listener: (context,state){
                      if (state is ChangePasswordStateLoading) {
                        return Loading();
                      }
                      if (state is ChangePasswordStateFail) {
                        return showToast.displayToast(state.error, Colors.red);
                      }
                      if (state is ChangePasswordStateSuccess) {
                         showToast.displayToast("Thay đổi mật khẩu thành công",Colors.green);
                        Navigator.pushNamedAndRemoveUntil(context, LoginScreens, (route) => false);
                      }
                    },
                    cubit: changePasswordBloc,
                    child: RaisedButton(
                      color: kColorPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      onPressed: changePassword,
                      child: Text("Thay đổi",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontFamily: kFontBold
                        ),),
                    ),
                  )
                ),
              )
            ],
          ),
        ),
        titleAppBar: "Tạo mật khẩu mới",
        imageAssets: "assets/forgot/forgot3.svg",
        onPressed: () {  },);
  }
}

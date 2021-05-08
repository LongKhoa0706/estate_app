import 'package:estate_app/src/bloc/auth/auth_bloc.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/utils/toast.dart';
import 'package:estate_app/src/widget/customforgot.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:estate_app/src/widget/text.dart';
import 'package:estate_app/src/widget/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPassScreen extends StatefulWidget {
  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final emailController = TextEditingController();
  AuthBloc authBloc = AuthBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    authBloc.close();
    emailController.dispose();
    super.dispose();
  }

  void submit()  {
    authBloc.add(AuthEvenForgotPassword(emailController.text));
   // await Future.delayed(Duration(seconds: 2));
   //  Navigator.pushReplacementNamed(context, VerifyEmailScreens,arguments: emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return CustomForgot(imageAssets:"assets/icon/sendemail.svg",
      titleAppBar: "Quên mật khẩu ",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 15,
          ),
          BlocListener<AuthBloc,AuthState>(
            cubit: authBloc,
            listener: (previous,state){
              if (state is AuthStateFaire) {
                showToast.displayToast(state.error, Colors.red);
              }
              if (state is AuthStateSuccess) {
                Navigator.pushNamedAndRemoveUntil(context, VerifyEmailScreens, (route) => false,arguments: emailController.text);
              }
            },
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "abc@gmail.com"
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<AuthBloc,AuthState>(
                  cubit: authBloc,
                  builder: (BuildContext ctx,state){
                    if (state is AuthStateLoading) {
                      return Loading();

                    }
                    return RaisedButton(
                      color: kColorPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: (){
                        submit();
                      },
                      child: TextView(
                        text: "Gửi ",
                        textColor: Colors.white,
                        fontWeight: FontWeight.w200,

                      )
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
      title: "Vui lòng nhập địa chỉ email của bạn \n để nhận liên kết đặt lại mật khẩu",
      onPressed: () => Navigator.pop(context),);
  }
}

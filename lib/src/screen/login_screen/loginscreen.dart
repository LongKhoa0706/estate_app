
import 'package:estate_app/src/animation/fadeanimation.dart';
import 'package:estate_app/src/bloc/auth/auth_bloc.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/screen/dashboard/dashboard.dart';
import 'package:estate_app/src/service/share_pref.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/utils/validator.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:estate_app/src/widget/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthBloc authBloc = AuthBloc();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);

  }

  @override
  void dispose() {
    authBloc.close();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  showToast(String message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.red,
      ),
      child: Text(message,style: TextStyle(color: Colors.white)
    ));
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
  saveAccount(String email,String password) async {
    await SharedPrefService.setString(key: 'account',value:email );
    await SharedPrefService.setString(key: 'password',value: password);
  }

  login() async {
    if (formKey.currentState.validate()) {
      await saveAccount(emailController.text, passwordController.text);
      if(FocusScope.of(context).isFirstFocus) {
        FocusScope.of(context).requestFocus(new FocusNode());
      }
      authBloc.add(AuthEventLogin(emailController.text, passwordController.text));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc,AuthState>(
        listener: (previous,state){
          if (state is AuthStateFaire) {
            showToast(state.error.toString());
          }
          if (state is AuthStateSuccess) {
            Navigator.pushNamedAndRemoveUntil(context, DashBoardScreens, (_) => false);
          }
        },
        cubit: authBloc,
        child:  Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  SvgPicture.asset('assets/logo/logo.svg'),
                  FadeAnimation(.9, Form(
                    key: formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Text("Đăng Nhập ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig().getScreenWidth(23),
                              fontWeight: FontWeight.bold
                          ),),
                        SizedBox(
                          height: 20,
                        ),
                        TextForm(
                          keyBoardType: TextInputType.emailAddress,
                          textEditingController: emailController,
                          hintText: "Tên đăng nhập,email,số điện thoại",
                          validator: (value){
                            return Validator().validatorEmailLogin(value);
                          },
                          obscure: false,
                          iconData: Icons.person,),
                        SizedBox(
                          height: 13,
                        ),
                        TextForm(
                          obscure: true,
                          textEditingController: passwordController,
                          hintText: 'Mật khẩu ',
                          iconData: Icons.lock,
                          validator: (value){
                            return Validator().validatorPassword(value);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: BlocBuilder(
                                  cubit: authBloc,
                                  builder: (BuildContext ctx,state){
                                    if (state is AuthStateLoading) {
                                      return Loading();
                                    }
                                    return RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      color: kColorPrimary,
                                      onPressed: login,
                                      child: Text("Đăng Nhập ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),),
                                    );
                                  },
                                )
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        _buildTextSupport("Bạn chưa có tài khoản?", "Đăng ký ",() => Navigator.pushNamed(context, RegisterScreens)),

                        SizedBox(
                          height: 10,
                        ),
                        _buildTextSupport("Quên mật khẩu?", "Quên",() => Navigator.pushNamed(context, ForgotPasswordScreens)),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

Widget _buildTextSupport(String text,String text1,VoidCallback onTap){
  return  GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        Text(text,style: TextStyle(
            color: Colors.grey.withOpacity(.8)
        ),),
        SizedBox(
          width: 10,
        ),
        Text(text1,style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold
        ),)
      ],
    ),
  );
}

Widget _buildIconSocial(IconData iconSocial,Color color){
  return  Container(
    width: 37,
    height: 40,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Icon(iconSocial,size: 13,color: Colors.white,),
  );
}
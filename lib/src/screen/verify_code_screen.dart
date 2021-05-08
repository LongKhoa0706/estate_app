import 'dart:async';
import 'dart:ui';

import 'package:estate_app/src/bloc/auth/auth_bloc.dart';
import 'package:estate_app/src/bloc/very_code_phone/very_code_phone_bloc.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyCodeScreen extends StatefulWidget {
  final Users users;

  const VerifyCodeScreen({Key key, this.users}) : super(key: key);

  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> with SingleTickerProviderStateMixin {


  final code1Controller = TextEditingController();
  final code2Controller = TextEditingController();
  final code3Controller = TextEditingController();
  final code4Controller = TextEditingController();
  final code5Controller = TextEditingController();
  final code6Controller = TextEditingController();
  FocusNode inputNode1 = FocusNode();
  FocusNode inputNode2 = FocusNode();
  FocusNode inputNode3 = FocusNode();
  FocusNode inputNode4 = FocusNode();
  FocusNode inputNode5 = FocusNode();
  FocusNode inputNode6 = FocusNode();
  String valueCode1;
  String valueCode2;
  String valueCode3;
  String valueCode4;
  String valueCode5;

  VeryCodePhoneBloc veryCodePhoneBloc = VeryCodePhoneBloc();
  AuthBloc authBloc = AuthBloc();
  Repositories repositories = Repositories();
  AnimationController _controller;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    authBloc.close();
    code1Controller.dispose();
    code2Controller.dispose();
    code3Controller.dispose();
    code4Controller.dispose();
    code5Controller.dispose();
    veryCodePhoneBloc.close();
  }

  void verifyCode(){
    List<String> listCode = [code1Controller.text,code2Controller.text,code3Controller.text,code4Controller.text,code5Controller.text,code6Controller.text];
    final code  = StringBuffer();
    listCode.forEach((element) {
      code.write(element);
    });
    authBloc.add(AuthEvenVerifyCodeEmail(widget.users.email, code.toString()));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Mã xác nhận",
          style: TextStyle(
              color: Colors.black,
              fontSize: 16
          ),),

        leading: IconButton(
          padding: EdgeInsets.all(0.0),
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 16,),
        ),
      ),
      body:BlocListener<AuthBloc,AuthState>(
        cubit:authBloc ,
        listener: (previous,state){
          if (state is AuthStateSuccess) {
            Navigator.pushReplacementNamed(context, LoginScreens);
          }
          if (state is AuthStateFaire) {
            showToast.displayToast(state.error, Colors.red);
          }
        },
        child: BlocListener<VeryCodePhoneBloc,VeryCodePhoneState>(
          listener: (previous,state){
            if (state is VeryCodePhoneStateSuccess) {
              authBloc.add(AuthEventRegisterSubmit(widget.users));
              Navigator.pushNamedAndRemoveUntil(context, NewPassScreens , (route) => false,arguments: widget.users.email);
            }
            if (state is VeryCodePhoneStateFail) {
              showToast.displayToast("Mã xác thực không hợp lệ", Colors.red);
            }
          },
          cubit:veryCodePhoneBloc ,
          child:  Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: SvgPicture.asset('assets/veriphone.svg'),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Nhập mã xác nhận",textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDigitCode(code1Controller, inputNode1, (value1) {
                    if (value1 == null) {
                      print("AAAAA"+value1.toString());
                    }else{
                      print(value1);
                      inputNode1.nextFocus();
                      valueCode1 = value1;
                    }
                  }),
                  _buildDigitCode(code2Controller, inputNode2, (value2) {
                    inputNode2.nextFocus();
                    valueCode2 = value2;

                  }),
                  _buildDigitCode(code3Controller, inputNode3, (value3) {
                    inputNode3.nextFocus();
                    valueCode3 = value3;

                  }),
                  _buildDigitCode(code4Controller, inputNode4, (value4) {
                    inputNode4.nextFocus();
                    valueCode4 = value4;
                  }),
                  _buildDigitCode(code5Controller, inputNode5, (value5) {
                    inputNode5.nextFocus();
                    valueCode5 = value5;

                  }),
                  _buildDigitCode(code6Controller, inputNode6, (value) {

                    List<String> listCode = [valueCode1,valueCode2,valueCode3,valueCode4,valueCode5,value];
                    final code  = StringBuffer();
                    listCode.forEach((element) {
                      code.write(element);
                    });
                    veryCodePhoneBloc.add(VeryCodePhoneEventSubmit(code.toString()));
                  }) ,
                ],
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: (){
                  repositories.authRepositories.start();
                },
                child: Center(
                  child: Text("Không nhận được mã? Gửi lại"),
                ),
              ),
              // Center(
              //   child: Countdown(
              //     animation: StepTween(
              //       begin: 1 * 60,
              //       end: 0,
              //     ).animate(_controller),
              //   ),
              // ),
            ],
          ),
        ),
      )
    );
  }

  _buildDigitCode(TextEditingController editingController,FocusNode focusNode,@required ValueChanged onChange){
    return Container(
      width: SizeConfig().getScreenWidth(40),
      height: SizeConfig().getScreenWidth(40),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              width: .2,
              color: Colors.grey
          )

      ),
      child: TextFormField(
        maxLines: 1,
        focusNode: focusNode,
        onChanged: onChange,
        keyboardType: TextInputType.number,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;
  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText = '${clockTimer.inMinutes.remainder(60).toString()} : ${(clockTimer.inSeconds.remainder(60) % 60).toString()}';

    return Text(
      "$timerText",
    );
  }
}


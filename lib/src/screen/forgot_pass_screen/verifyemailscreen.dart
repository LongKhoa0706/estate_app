import 'package:estate_app/src/bloc/auth/auth_bloc.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/utils/toast.dart';
import 'package:estate_app/src/widget/customforgot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;

  const VerifyEmailScreen({Key key, this.email}) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  AuthBloc authBloc = AuthBloc();
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
  String valueCode6;

  @override
  void dispose() {
    authBloc.close();
    // TODO: implement dispose
    super.dispose();
  }

  void verifyCode(){
    List<String> listCode = [valueCode1,valueCode2,valueCode3,valueCode4,valueCode5,valueCode6];
    final code  = StringBuffer();
    listCode.forEach((element) {
      code.write(element);
    });
    authBloc.add(AuthEvenVerifyCodeEmail(widget.email, code.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return CustomForgot(imageAssets:"assets/icon/recivemail.svg",
      titleAppBar: "Xác Nhận Email ",
      title: "Vui lòng nhập 4 mã số vừa được gửi \n  ${widget.email}",
      onPressed: () {
        Navigator.maybePop(context);
      },
      child: BlocListener<AuthBloc,AuthState>(
        cubit: authBloc,
        listener: (previous,state){
          if (state is AuthStateFaire) {
            showToast.displayToast(state.error, Colors.red);
          }
          if (state is AuthStateSuccess) {
            Navigator.pushNamedAndRemoveUntil(context, NewPassScreens, (route) => false,arguments: widget.email);
          }
        },
        child: BlocBuilder<AuthBloc,AuthState>(
          cubit: authBloc,
          builder: (BuildContext context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  child: Row(
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
                      _buildDigitCode(code6Controller, inputNode6, (value6) {
                        valueCode6 = value6;
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Chưa nhận được mã? "),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Gửi lại",style: TextStyle(
                      color: kColorPrimary,
                    ),)
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),

                Center(
                  child: RaisedButton(
                    color: kColorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: (){
                      verifyCode();
                    },
                    child: Text("Xác nhận ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                )
              ],
            );
          },
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

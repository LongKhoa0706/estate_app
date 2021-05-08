import 'package:estate_app/src/bloc/auth/auth_bloc.dart';
import 'package:estate_app/src/bloc/verify_phone/verify_phone_bloc.dart';
import 'package:estate_app/src/model/job.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/service/share_pref.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/utils/toast.dart';
import 'package:estate_app/src/utils/validator.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:estate_app/src/widget/text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthBloc authBloc = AuthBloc();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  VerifyPhoneBloc verifyPhoneBloc = VerifyPhoneBloc();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  Repositories repositories = Repositories();
  Users user;
  List<Job> listJob = List();
  Job selectJob;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void registerUser(){
    if(formKey.currentState.validate()){
       user = Users(
        email: emailController.text,
        passwords: passwordController.text,
        phone: phoneController.text,
        firstname: firstNameController.text,
        lastname: lastNameController.text,
        username: userNameController.text,
        job: Job(id: selectJob.id),
      );
       verifyPhoneBloc.add(VerifyPhoneEventSubmit(phoneController.text,emailController.text));
    }else{

    }
  }
  void getData() async {

    setState(() {

    });
    listJob = await repositories.userRepositories.getAllJob();

    setState(() {

    });
    selectJob = listJob[0];

  }

  @override
  void dispose() {
    authBloc.close();
    phoneController.dispose();
    userNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    verifyPhoneBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<VerifyPhoneBloc,VerifyPhoneState>(
        cubit: verifyPhoneBloc,
        listener: (previous,state){
          if (state is VerifyPhoneStateFail) {
            showToast.displayToast(state.error, Colors.red);
          }
          if (state is VerifyPhoneStateSuccess) {
            showToast.displayToast("Đăng ký thành công ", Colors.green);
            Navigator.pushNamed(context,VerifyCodeScreens,arguments: user);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig().getScreenHeight(40),
                ),
                IconButton(alignment: Alignment.topLeft,
                    icon: Icon(Icons.arrow_back_ios,size: 16,),
                    onPressed: (){
                      Navigator.pop(context);

                    }),
                Container(
                  height: SizeConfig().getScreenHeight(100),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo/logo.png'),
                      )
                  ),
                ),

                Form(
                  key: formKey,
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Text("Đăng Ký ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: SizeConfig().getScreenWidth(23),
                            fontWeight: FontWeight.bold
                        ),),
                      SizedBox(
                        height: 20,
                      ),
                      TextForm(
                        validator: (value){
                          return Validator().validatorUserName (value);
                        },
                        obscure: false,
                        textEditingController: userNameController,
                        hintText: "User name",
                        iconData: Icons.person,),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextForm(
                              validator: (value){
                                return Validator().validatorInput(value);
                              },
                              obscure: false,
                              textEditingController: firstNameController,
                              hintText: "Họ",
                              iconData: Icons.person,),
                          ),
                          SizedBox(
                            width: 13,
                          ),
                          Expanded(
                            child: TextForm(
                              validator: (value){
                                return Validator().validatorInput(value);
                              },
                              obscure: false,
                              textEditingController: lastNameController,
                              hintText: "Tên",
                              iconData: Icons.person,),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextForm(
                        validator: (value){
                          return Validator().validatorEmail(value);
                        },
                        obscure: false,
                        textEditingController: emailController,
                        hintText: "Email ",
                        iconData: Icons.email,),
                      SizedBox(
                        height: 16,
                      ),

                      TextForm(
                        validator: (value){
                          return Validator().validatorPassword(value);
                        },
                        obscure: true,
                        textEditingController: passwordController,
                        hintText: "Mật khẩu ",
                        iconData: Icons.lock,),
                      SizedBox(
                        height: 16,
                      ),
                      TextForm(
                        validator: (value){
                          return Validator().validatorPhone(value);
                        },
                        obscure: false,
                        keyBoardType: TextInputType.phone,
                        textEditingController: phoneController,
                        hintText: "Số điện thoại ",
                        iconData: Icons.phone,),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Job>(
                            hint: Text("Chọn nghề nghiệp"),
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black
                            ),
                            items: listJob
                                .map((e) => DropdownMenuItem<Job>(
                              child: Text(e.jobName),
                              value: e,
                            ))
                                .toList(),
                            onChanged: (Job city) async {
                              setState(() {
                                selectJob = city;
                              });
                            },
                            value: selectJob,),
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: kColorPrimary,
                            onPressed: (){
                              registerUser();
                            },
                            child: Text("Đăng Ký ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

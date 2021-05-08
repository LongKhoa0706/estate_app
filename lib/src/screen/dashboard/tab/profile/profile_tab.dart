import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:estate_app/src/bloc/auth/auth_bloc.dart';
import 'package:estate_app/src/bloc/update_image_bloc.dart';
import 'package:estate_app/src/bloc/user/user_bloc.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:estate_app/src/repositories/repositories/user_repositories.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/screen/dashboard/tab/social/socialtab.dart';
import 'package:estate_app/src/screen/detailinformationscreen.dart';
import 'package:estate_app/src/screen/favoritescreen.dart';
import 'package:estate_app/src/service/share_pref.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/widget/containercard.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:estate_app/src/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatefulWidget {

  @override
  _ProfileTabState createState() => _ProfileTabState();
}
class _ProfileTabState extends State<ProfileTab> {
  String token ='';
  UpdateImageBloc updateImageBloc = UpdateImageBloc();
  UserBloc userBloc = UserBloc();
  Repositories repositories = Repositories();
  UserRepositories userRepositories = UserRepositories();

  void getToken() async {
    token = await SharedPrefService.getString(key: Constant.KEY_TOKEN);
  }

  File _image;
  final picker = ImagePicker();

  Future openGallary() async {
    final pipickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pipickedFile != null) {
        _image = File(pipickedFile.path);
        print(_image.path);
      } else {
        print('No image selected.');
      }
    });
    Navigator.pop(context);
  }
  Future openCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget decideImageView(Users user) {
    if (user.urlAvata != null) {
      return   ClipOval(
        child: Container(
          height: SizeConfig().getScreenHeight(230),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
          ),
          width: double.infinity,
          child: Image.network(
            user.urlAvata ,
            fit: BoxFit.cover,
          ),
        ),
      );
    }else{
      return BlocBuilder<UpdateImageBloc,UpdateImageState>(
        cubit: updateImageBloc,
        builder: (_,state){
          if (state is UpdateImageStateSuccess) {
            return   Container(
              height: SizeConfig().getScreenHeight(230),
              decoration: BoxDecoration(
                  shape: BoxShape.circle
              ),
              width: double.infinity,
              child: Image.network(
                state.urlImage,
                fit: BoxFit.cover,
              ),
            );
          }
          if (state is UpdateImageLoading) {
            return Loading();
          }
          return  Container(
            height: SizeConfig().getScreenHeight(230),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),

            child: Image.network(
             "https://icon-library.com/images/facebook-user-icon/facebook-user-icon-17.jpg" ,
              fit: BoxFit.cover,
            ),
          );
        },
      );
    }
  }
  void updateImage() async {
    await userRepositories.updateImageUser(_image);
  }
  @override
  void dispose() {
    userBloc.close();
    updateImageBloc.close();

    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _buildItemUpdateImage(IconData icon,String title){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon,color: Colors.grey,),
            SizedBox(
              width: 10,
            ),
            Text(title),
          ],
        ),
      );
    }
    showBottomShettingg(){
      return showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )
          ),
          context: context, builder: (_){
        return Container(
          height: 130,
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  openCamera();
                },
                child: _buildItemUpdateImage( Icons.camera_alt, "Chụp ảnh"),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: (){
                openGallary();
                },
                child: _buildItemUpdateImage(Icons.photo_rounded, "Chọn hình"),
              )

            ],
          ),
        );
      });
    }

    void removeToken()async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('account');
      await preferences.remove('password');
      await preferences.remove(Constant.KEY_TOKEN);
    }

    _buildDialogLogout(){
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Đăng xuất tài khoản',
        desc: 'Bạn có chắc muốn đăng xuất tài khoản này không? ',
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          await  repositories.authRepositories.logoutUser();
          removeToken();
          Navigator.pushNamedAndRemoveUntil(context, LoginScreens, (route) => false);
        },
      )..show();
    }

    userBloc.add(UserEventFetchData());

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig().getScreenHeight(30),
                ),

                Stack(
                  children: [

                    BlocBuilder<UserBloc,UserState>(
                      cubit: userBloc,
                      builder: (_,state){
                        if (state is UserStateFail) {
                          return Text(state.error);
                        }
                        if (state is UserStateLoading) {
                          return Loading();
                        }
                        if (state is UserStateSuccess) {
                          print(state.user.email);
                          return   Center(
                            child: Container(
                              width: SizeConfig().getScreenWidth(160),
                              height: SizeConfig().getScreenHeight(160),
                              child: decideImageView(state.user),
                            ),
                          );
                        }
                        return Text("a");
                      },
                    ),

                  ],
                ),
                SizedBox(
                  height: SizeConfig().getScreenHeight(30),
                ),
                _buildRow("Trang cá nhân  ",Icons.person_outline,()=> Navigator.pushNamed(context, DetailInforScreens,arguments: userBloc.iduser )),
                SizedBox(
                  height: 15,
                ),
                _buildRow("Nội dung yêu thích dự án",Icons.favorite_border,
                        ()=>Navigator.pushNamed(context, FavoriteScreens)),
                SizedBox(
                  height: 15,
                ),
                // _buildRow("Liên hệ",Icons.call,()=>Navigator.pushNamed(context, ContractScreens)),
                //
                // SizedBox(
                //   height: 15,
                // ),
                _buildRow("Thay đổi mật khẩu",Icons.lock, ()=>Navigator.pushNamed(context,ChangePasswordScreens)),
                SizedBox(
                  height: 15,
                ),
                _buildRow("Đăng xuất ",Icons.power_settings_new, ()=>_buildDialogLogout()),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_buildRow(String  title,IconData iconData,VoidCallback ontap){
  return  GestureDetector(

    onTap: ontap,
    child: Row(
      children: [
        Icon(iconData,color: kColorPrimary,size: 22,),
        SizedBox(
          width: 10,
        ),
        TextView(
          textColor: Colors.black,
          text: title,
          sizeText: 19,
          fontWeight: FontWeight.w200,
        ),
      ],
    ),
  );
}

_buildSetting(String title,IconData iconData){
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Row(
      children: [
        Icon(iconData,color: kColorPrimary,size: 22,),
        SizedBox(
          width: 10,
        ),
        Expanded(child: Text(title)),
        Icon(Icons.arrow_forward_ios,size: 12,)
      ],
    ),
  );

}

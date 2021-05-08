import 'dart:io';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:estate_app/src/bloc/update_image_bloc.dart';
import 'package:estate_app/src/bloc/user/user_bloc.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/screen/changeinfoscreen.dart';
import 'package:estate_app/src/screen/post_tab.dart';
import 'package:estate_app/src/screen/project_tab.dart';
import 'package:estate_app/src/service/share_pref.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/formatdate.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/utils/toast.dart';
import 'package:estate_app/src/widget/containercard.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DetailInformationScreen extends StatefulWidget {
  final int idUser;
  const DetailInformationScreen({Key key, this.idUser}) : super(key: key);
  @override
  _DetailInformationScreenState createState() => _DetailInformationScreenState();
}
class _DetailInformationScreenState extends State<DetailInformationScreen> {
  UserBloc userBloc = UserBloc();
  UpdateImageBloc updateImageBloc = UpdateImageBloc();
  bool showIcon = true;


  List<Widget> tabbar() =>  [
    PostTab(idUser: widget.idUser ,),
    ProjectTab(idUser: widget.idUser ,),
  ];

  @override
  void dispose() {
    userBloc.close();
    updateImageBloc.close();
    // TODO: implement dispose
    super.dispose();
  }

  File _image;
  final picker = ImagePicker();

  Future openGallary() async {
    final pipickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pipickedFile != null) {
        _image = File(pipickedFile.path);
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
        print(_image.path);
      } else {
        print('No image selected.');
      }
    });
  }
  Future<Null> refreshData() async {
    userBloc.add(UserEventFetchDetailData(widget.idUser));
}

  Future getIdUser() async {
    int idUser = await SharedPrefService.getInt(key: Constant.KEY_IDUSER);
    return idUser;
  }

  void get() async{
    int id = await getIdUser();
    if (widget.idUser == id) {
      showIcon = true;
    } else{
      showIcon = false;
    }
  }

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();

  }
  void onTapFunction(Users user) async {
    final reLoadPage = await  Navigator.pushNamed(context, ChangeInfoScreens,arguments: user);
    if (reLoadPage) {
      print('true');
      setState(() {});
    }else{
      print('false');
    }
  }


  @override
  Widget build(BuildContext context) {
    updateImageBloc.add(UploadImageEvent(_image));
    userBloc.add(UserEventFetchDetailData(widget.idUser));

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshData,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(0.0),
            child: BlocBuilder<UserBloc,UserState>(
              cubit: userBloc,
              builder: (BuildContext context, state){
                if (state is UserStateLoading) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: Loading()),
                      ],
                    );
                }
                if (state is UserStateFail) {
                  print(state.error);
                  showToast.displayToast(state.error, Colors.red);

                }
                if (state is UserStateSuccess) {
                  Users user = state.user;
                  var dateFormat = new DateFormat('dd-MM-yyyy');
                  String formattedDate = user.birthDay == null ? "Chưa cập nhật" :dateFormat.format(DateTime.parse(user.birthDay));
                  return Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1266&q=80",
                                    ),
                                    fit: BoxFit.cover
                                  )
                                ),
                                child:   Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  IconButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.arrow_back_ios,size: 20,),
                                      ),
                                      Visibility(
                                        visible: showIcon,
                                        child: IconButton(icon: Icon(Icons.edit,size: 20,), onPressed: (){
                                          onTapFunction(user);
                                        },
                                      ),
                                      ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: SizeConfig().getScreenHeight(100)),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: ClipOval(
                                    child: InkWell(
                                      onTap: (){
                                        showIcon ? showBottomShettingg() : null;
                                      },
                                      child: Container(
                                        width: SizeConfig().getScreenWidth(120),
                                        height: SizeConfig().getScreenHeight(120),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: user.urlAvata == null ? ClipOval(
                                          child: Container(
                                            height: SizeConfig().getScreenHeight(230),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            width: double.infinity,
                                            child: Image.network(
                                              "https://icon-library.com/images/facebook-user-icon/facebook-user-icon-17.jpg" ,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ) : decideImageView(user),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          )
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     IconButton(
                          //       onPressed: (){
                          //         Navigator.pop(context);
                          //       },
                          //       icon: Icon(Icons.arrow_back_ios,size: 18,),
                          //     ),
                          //     Visibility(
                          //       visible: showIcon,
                          //       child: IconButton(icon: Icon(Icons.edit,size: 18,), onPressed: (){
                          //         onTapFunction(user);
                          //       },
                          //     ),
                          //     ),
                          //   ],
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(top: SizeConfig().getScreenHeight(10)),
                          //   child: Align(
                          //     alignment: Alignment.topCenter,
                          //     child: ClipOval(
                          //       child: InkWell(
                          //         onTap: (){
                          //           showIcon ? showBottomShettingg() : null;
                          //         },
                          //         child: Container(
                          //           width: SizeConfig().getScreenWidth(120),
                          //           height: SizeConfig().getScreenHeight(120),
                          //           decoration: BoxDecoration(
                          //             shape: BoxShape.circle,
                          //           ),
                          //           child: user.urlAvata == null ? ClipOval(
                          //             child: Container(
                          //               height: SizeConfig().getScreenHeight(230),
                          //               decoration: BoxDecoration(
                          //                 shape: BoxShape.circle,
                          //               ),
                          //               width: double.infinity,
                          //               child: Image.network(
                          //                 "https://icon-library.com/images/facebook-user-icon/facebook-user-icon-17.jpg" ,
                          //                 fit: BoxFit.cover,
                          //               ),
                          //             ),
                          //           ) : decideImageView(user),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
,

                           SizedBox(
                            height: SizeConfig().getScreenHeight(15),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: buildText(user),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ContainerCard(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildInfor("Sản phẩm", "0"),
                                  // _buildInfor("Đang theo dõi ", "0"),
                                  // _buildInfor("Người theo dõi ", "0"),
                                ],
                              ) ,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ContainerCard(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Thông tin cá nhân",style: TextStyle(
                                          color: kColorPrimary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeConfig().getScreenWidth(14)
                                      ),),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      buildDetailInfor(user.email, Icons.email),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      buildDetailInfor(user.phone, Icons.phone),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      buildDetailInfor(formattedDate, Icons.date_range),
                                    ],
                                  ),
                                )
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                showIcon ? onTapFunction(user) : null;
                              },
                              child: ContainerCard(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Giới thiệu",style: TextStyle(
                                          color: kColorPrimary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeConfig().getScreenWidth(14)
                                      ),),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(user.personalInfo == null ? 'Trống' : user.personalInfo),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          DefaultTabController(

                              length: 2,
                              child: Column(
                                children: [
                                  TabBar(
                                    tabs: [
                                      Tab(
                                          child: Text("Bài Đăng ",
                                            style: TextStyle(
                                              color: kColorPrimary,
                                              fontWeight: FontWeight.bold,
                                            ),)
                                      ),
                                      Tab(
                                          child: Text("Dự Án  ",
                                            style: TextStyle(
                                              color: kColorPrimary,
                                              fontWeight: FontWeight.bold,
                                            ),)
                                      ),
                                    ],
                                    indicatorColor: kColorPrimary,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: TabBarView(
                                      physics: NeverScrollableScrollPhysics(),
                                      children: tabbar(),
                                    ),
                                  )
                                ],
                              )
                          )
                        ],
                      )
                  );
                }
                return Text('a',style: TextStyle(
                  fontSize: 44
                ),);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfor(String title,String number){
    return  Column(
      children: [
        Text(number,style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),),
        const SizedBox(
          height: 5,
        ),
        Text(title,style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold
        ),),
      ],
    );
  }

  Widget buildDetailInfor(String title,IconData iconData){
    return  Row(
      children: [
        Icon(iconData,size: 16,color: kColorPrimary,),
        const SizedBox(
          width: 8,
        ),
        Text(title,style: TextStyle(fontSize: 13),)
      ],
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

  Widget buildText(Users user) {
    Widget child;
    if (user.username != null) {
      if (user.firstname == null && user.lastname == null) {
        child = Text(
          user.username,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig().getScreenHeight(18)),
        );
      }else{
        child = Text(
          user.firstname + " " + user.lastname,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig().getScreenHeight(18)),
        );
      }
    }
    return Container(child: child,);
  }

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

  Widget decideImageView(Users user) {
    if (user.urlAvata != null) {
      return   Container(
        height: SizeConfig().getScreenHeight(230),
        decoration: BoxDecoration(
            shape: BoxShape.circle
        ),
        width: double.infinity,
        child: Image.network(
          user.urlAvata ,
          fit: BoxFit.cover,
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
          return Text('a');
        },
      );
    }
  }



}

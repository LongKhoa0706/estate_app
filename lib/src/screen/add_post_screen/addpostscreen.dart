import 'dart:io';

import 'package:estate_app/src/bloc/add_post/add_post_bloc.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/toast.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AddPostScreen extends StatefulWidget {
  final Users user;

  const AddPostScreen({Key key, this.user}) : super(key: key);
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final forcus = FocusNode();
  List<Asset> listImageProject = List<Asset>();
  File _image;
  final contentController = TextEditingController();
  AddPostBloc addPostBloc = AddPostBloc();
  @override
  void dispose() {
    addPostBloc.close();
    // TODO: implement dispose
    super.dispose();
  }
  final picker = ImagePicker();
  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    List <File> fileImageArray = [];

    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: listImageProject,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      listImageProject = resultList;

    });
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      children: List.generate(listImageProject.length, (index) {
        Asset asset = listImageProject[index];
        return Padding(
          padding: const EdgeInsets.all(3),
          child: AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          ),
        );
      }),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 16,),
        ),

        title: Text("Đăng Tin",
        style: TextStyle(
          color: Colors.black
        ),),
        actions: [
         BlocBuilder<AddPostBloc,AddPostState>(
           cubit: addPostBloc,
           builder: (BuildContext ctx,state){
             if (state is AddPostStateLoading) {
               return Loading();
             }
             return  InkWell(
               onTap: (){
                 addPostBloc.add(AddPostEventSubmit(contentController.text, listImageProject));
               },
               child: Row(
                 children: [
                   Icon(Icons.send,size: 16,color: kColorPrimary,),
                   SizedBox(
                     width: 5,
                   ),
                   Text("Đăng Bài",style: TextStyle(color: kColorPrimary ),)
                 ],
               ),
             );
           },
         ),

        ],
      ),
      body: BlocListener<AddPostBloc,AddPostState>(
        cubit: addPostBloc,
        listener: (previous,state){
          if (state is AddPostStateSuccess) {
            showToast.displayToast("Thêm Bài Thành Công", Colors.green);
            Navigator.pushNamedAndRemoveUntil(context, DashBoardScreens, (route) => false);
          }
        },
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    FocusScope.of(context).requestFocus();
                  },
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      child: Column(
                        children: [
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Container(
                          //       width:55,
                          //       height: 55,
                          //       decoration: BoxDecoration(
                          //         color: Colors.red,
                          //         shape: BoxShape.circle,
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          //     Padding(
                          //       padding: EdgeInsets.only(top: 8),
                          //       child:   Column(
                          //         children: [
                          //           Text("Long Khoa",
                          //             style: TextStyle(
                          //                 color: Colors.black,
                          //                 fontWeight: FontWeight.bold,
                          //                 fontSize: 16
                          //             ),)
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  controller: contentController,
                                  expands: false,
                                  onTap: (){
                                    FocusScope.of(context).unfocus();
                                  },
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Bạn muốn chia sẻ điều gì? "
                                  ),
                                ),
                                buildGridView(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.add_photo_alternate,
                        color: kColorPrimary,
                      ),
                      onTap: (){
                        loadAssets();
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.camera_alt,
                      color: kColorPrimary,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

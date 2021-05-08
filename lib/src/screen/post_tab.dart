import 'dart:ui';

import 'package:estate_app/src/bloc/get_my_post/get_my_post_bloc.dart';
import 'package:estate_app/src/model/post.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/screen/commentpostscreen.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/formatdate.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PostTab extends StatefulWidget {
  final int idUser;

  const PostTab({Key key, this.idUser}) : super(key: key);
  @override
  _PostTabState createState() => _PostTabState();
}

class _PostTabState extends State<PostTab>  {
  int currentIndex;
  GetMyPostBloc getMyPostBloc = GetMyPostBloc();

  @override
  void dispose() {
    getMyPostBloc.close();
    // ;print('huy');
    // WidgetsBinding.instance.removeObserver(this)
    // TODO: implement dispose
    super.dispose();
  }

  final swiperController = SwiperController();

  List<String> listImage = [
    'assets/onboard/onboard1.png',
    'assets/onboard/onboard2.png',
    'assets/onboard/onboard3.png',
  ];

  @override
  Widget build(BuildContext context) {
    getMyPostBloc.add(GetMyPostEventFetch(widget.idUser));
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
      ),
      child: BlocBuilder<GetMyPostBloc,GetMyPostState>(
        cubit: getMyPostBloc,
        builder: (BuildContext ctx,state){
          if (state is GetMyPostStateLoading) {
            return Loading();
          }

          if (state is GetMyPostStateSuccess) {
            return state.listMyPost.length == 0 ?Column(
              children: [
                Container(width: 100,height: 130,child: SvgPicture.asset('assets/nodata.svg',fit: BoxFit.cover,)),
                SizedBox(
                  height: 10,
                ),
                Text("Chưa có dữ liệu ")
              ],
            ) :ListView.builder(
              itemCount: state.listMyPost.length,
              shrinkWrap: true,
              padding: EdgeInsets.all(0.0),
              itemBuilder: (_,index){
                Post post = state.listMyPost[index];
                String date = Format().formatDate(post.createdAt);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(4, 4),
                          blurRadius: 10,
                          color: Colors.grey.withOpacity(.3),
                        ),
                        BoxShadow(
                          offset: Offset(-3, 0),
                          blurRadius: 15,
                          color: Color(0xffb8bfce).withOpacity(.1),
                        )
                      ],
                      // borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(

                                    image: DecorationImage(
                                        image: post.user.urlAvata == null ? AssetImage('assets/avatar_image.png') : NetworkImage(post.user.urlAvata),
                                      fit: BoxFit.cover
                                    ),
                                    shape: BoxShape.circle
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(post.user.username,style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),),

                                  Text(date,style: TextStyle(fontSize: 12),),
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: (){
                                  // showBottomShet tingg(project.id);
                                },
                                child: Icon(Icons.more_horiz),),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Container(
                          height: SizeConfig().getScreenHeight(400),
                          decoration: BoxDecoration(
                          ),
                          child:  Swiper(
                            loop: false,
                            itemCount: post.postImage.length,
                            onIndexChanged: (index) {
                            },
                            controller: swiperController,
                            pagination: SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.only(
                                right: 10,
                                bottom: SizeConfig().getScreenHeight(10),
                              ),
                              builder: post.postImage.length == 0 ?  DotSwiperPaginationBuilder(
                                  activeColor: kColorPrimary,
                                  color: Colors.black,
                                  size: 5
                              ) : DotSwiperPaginationBuilder(
                                  activeColor: kColorPrimary,
                                  color: Colors.orange[200],
                                  size: 5
                              ),
                            ),
                            itemBuilder: (context, index) {
                              post.postImage.map((e) => print('so luong hinh' + e.toString()));
                              return post.postImage.length == 0 ? SizedBox() : ListView(
                                physics: NeverScrollableScrollPhysics(),
                                children: post.postImage.map((e) => Image.network(e,fit: BoxFit.cover,)).toList(),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(13),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(post.postContent,style: TextStyle(
                                color: kColorPrimary,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),),
                              SizedBox(
                                height: 5,
                              ),
                              // Text(post.,overflow: TextOverflow.ellipsis,style: TextStyle(
                              //     fontSize: 12
                              // ),),
                              SizedBox(
                                height: 15 ,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      child:
                                      Icon(Icons.favorite_border,size: 17,),
                                      onTap: (){
                                        Navigator.pushNamed(context, ListLikePostScreens,arguments: post.id);

                                      },),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(post.countLike.toString()),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  InkWell(
                                      onTap: (){
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (_) {
                                            return CommentPostScreen(idPost:post,);
                                          },
                                        );
                                      },
                                      child:
                                        Icon(
                                        Icons.mode_comment_outlined,
                                        size: 17,)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(post.countComment.toString()),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return Text('a');
        },
      ),
    );
  }
}

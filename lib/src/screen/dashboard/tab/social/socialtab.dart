import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:estate_app/src/bloc/get_all_post/get_all_post_bloc.dart';
import 'package:estate_app/src/bloc/user/user_bloc.dart';
import 'package:estate_app/src/model/post.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/screen/commentpostscreen.dart';
import 'package:estate_app/src/screen/commentscreen.dart';
import 'package:estate_app/src/screen/listlikepostscreen.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/widget/comment.dart';
import 'package:estate_app/src/widget/containercard.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:estate_app/src/widget/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class SocialTab extends StatefulWidget {
  @override
  _SocialTabState createState() => _SocialTabState();
}

class _SocialTabState extends State<SocialTab> {
  GetAllPostBloc getAllPostBloc = GetAllPostBloc();
  UserBloc userBloc = UserBloc();
  Users user;
   ScrollController scrollcontroller = new ScrollController();

  bool scroll_visibility = true;

  @override
  void dispose() {
    getAllPostBloc.close();
    userBloc.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    getAllPostBloc.add(GetAllPostEventFetchData());
    userBloc.add(UserEventFetchData());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    scrollcontroller.addListener(() {
      if (scrollcontroller.position.userScrollDirection == ScrollDirection.reverse) {
        if (scroll_visibility)
          setState(() {
            scroll_visibility = false;
          });
      }
      if (scrollcontroller.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!scroll_visibility)
          setState(() {
            scroll_visibility = true;
          });
      }
    });
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              AnimatedContainer(
                  duration: Duration(milliseconds: 800),
                  height: scroll_visibility ? null : 0.0,
                  child:   Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10,left: 5,right: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cộng Đồng ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              BlocBuilder<UserBloc,UserState>(
                                cubit: userBloc,
                                builder: (BuildContext ctx,state){
                                  if (state is UserStateSuccess) {
                                    user = state.user;
                                    return Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: user.urlAvata == null ? AssetImage('assets/avatar_image.png') : NetworkImage(user.urlAvata),
                                            fit: BoxFit.cover,
                                          )
                                      ),
                                    );
                                  }
                                  return SizedBox();
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey,
                                        width: .3
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: TextFormField(
                                      onTap: ()=>Navigator.pushNamed(context, AddPostScreens,arguments: user),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              fontSize:12
                                          ),
                                          hintText: "Bạn muốn chia sẻ điều gì?"
                                      ),
                                      showCursor: false,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
              Expanded(
                child: BlocBuilder<GetAllPostBloc,GetAllPostState>(
                  cubit: getAllPostBloc,
                  builder: (BuildContext ctx,state){
                    if (state is GetAllPostStateLoading) {
                      return Loading();
                    }
                    if (state is GetAllPostStateSuccess) {
                      return  RefreshIndicator(
                        onRefresh: () async {
                          getAllPostBloc.add(GetAllPostEventFetchData());

                        },
                        child: ListView.builder(
                          controller: scrollcontroller,
                          itemCount: state.listPost.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (_,int index){
                            List<String> listImage = [];
                            Post post = state.listPost[index];
                            final time = DateTime.parse(post.createdAt).toLocal();
                            String date = DateFormat("dd-MM-yyyy hh:mm:ss").format(time);
                            final timeline = timeago.format(time, locale: 'en_short');
                            return InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, DetailPostScreens,arguments: post);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: post.user.urlAvata == null ? AssetImage('assets/avatar_image.png') :
                                                        NetworkImage(post.user.urlAvata),
                                                    fit: BoxFit.cover
                                                  )
                                                ),
                                              ),
                                              onTap: (){
                                                Navigator.pushNamed(context, DetailInforScreens,arguments: post.user.id);
                                              },
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(post.user.username,style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                  onTap: (){
                                                    Navigator.pushNamed(context, DetailInforScreens,arguments: post.user.id);
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(timeline,style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey
                                                ),),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                          onTap: (){
                                            Navigator.pushNamed(context, DetailPostScreens,arguments: post);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8,right: 8),
                                            child: Text(post.postContent),
                                          )),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      _buildImage(post),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      buildReact(post: post,)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Text('a');
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(Post post){
    Widget child;
    if (post.postImage.length == 1) {
      child = Container(
        width: double.infinity,
        child: _loadImage(post.postImage[0]),
      );
    }
    if (post.postImage.length == 2) {
      child = GridView.builder(
          padding: EdgeInsets.only(top: 5),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 8 /10,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (_,index){
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(right: 4),
              child: _loadImage(post.postImage[index]),
            );
          });
    }
    if (post.postImage.length == 3) {
      child = Column(
        children: [
          Container(
            width: double.infinity,
            height: SizeConfig().getScreenHeight(180),
            child: _loadImage(post.postImage[0]),
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: SizeConfig().getScreenHeight(150),                  child: _loadImage(post.postImage[1]),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Expanded(
                child: Container(
                  height: SizeConfig().getScreenHeight(150),
                  child: _loadImage(post.postImage[2]),
                ),
              ),
            ],
          )
        ],
      );
    }
    if (post.postImage.length == 4) {
      child = GridView.builder(
          padding: EdgeInsets.only(top: 5,bottom: 5),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 5 /5,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (_,index){
            return Container(
              margin: EdgeInsets.only(right: 4,bottom: 3),
              child: _loadImage(post.postImage[index]),
            );
          });
    }

    if (post.postImage.length >=5) {
      child = Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 140,
                  child: _loadImage(post.postImage[0]),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Expanded(
                child: Container(
                  height: 140,
                  child: _loadImage(post.postImage[1]),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: SizeConfig().getScreenHeight(150),
                  child: _loadImage(post.postImage[2]),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Expanded(
                child: Container(
                  height: SizeConfig().getScreenHeight(150),
                  child: _loadImage(post.postImage[3]),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Expanded(
                child: Container(
                  height: SizeConfig().getScreenHeight(150),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(post.postImage[4]),
                        fit: BoxFit.cover,
                      ),
                  ),
                  child: Container(
                    color: Colors.black45,
                    child: Center(
                      child: Text(
                        '+ ${post.postImage.length}',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    }
    return Container(child: child,);
  }

  _loadImage(String urlImage){
    return CachedNetworkImage(
      imageUrl: urlImage,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Center(child: CircularProgressIndicator(value: downloadProgress.progress,)),
      errorWidget: (context, url, error) => urlImage == null ? Icon(Icons.ac_unit_rounded) : SizedBox() ,
    );
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 800));
    getAllPostBloc.add(GetAllPostEventFetchData());

    return true;
  }

}

class buildReact extends StatefulWidget {
  final Post post;

  const buildReact({Key key, this.post}) : super(key: key);
  @override
  _buildReactState createState() => _buildReactState();
}

class _buildReactState extends State<buildReact> {
  bool isLike = false;
   Repositories repositories = Repositories();
   int index;
   int countLike = 0;
   int countComment =0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              if(widget.post.isLiked){
                setState(() {
                  widget.post.isLiked = false;
                  repositories.postRepositories.likePost(widget.post.id,  false);
                  widget.post.countLike -=1;
                });
              }else{
                setState(() {
                  widget.post.isLiked = true;
                  repositories.postRepositories.likePost(widget.post.id,  true);
                  widget.post.countLike +=1;
                });
              }
            },
            child: Icon(widget.post.isLiked?Icons.favorite : Icons.favorite_border,
              size: 20,
              color: widget.post.isLiked ? kColorPrimary : Colors.grey,),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, ListLikePostScreens,arguments: widget.post.id);
            },
            child: Text(widget.post.countLike.toString(),style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold
            ),),
          ),
          SizedBox(
            width: 25,
          ),
          InkWell(
            onTap: (){
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) {
                  return CommentPostScreen(idPost:widget.post,);
                },
              );
            },
            child: Row(
              children: [
                Icon(Icons.mode_comment_outlined, color: Colors.grey,size: 20),
                SizedBox(
                  width: 10,
                ),
                Text(widget.post.countComment.toString(),
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold
                ),),
              ],
            ),
          ),
          SizedBox(
            width: 6,
          ),

          Text(countComment ==0 ? '' :countComment.toString(),),
        ],
      ),
    );
  }
}


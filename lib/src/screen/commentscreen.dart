import 'package:estate_app/src/bloc/comment_project/comment_project_bloc.dart';
import 'package:estate_app/src/bloc/list_comment_project/list_comment_project_bloc.dart';
import 'package:estate_app/src/bloc/list_reply_comment/list_reply_comment_bloc.dart';
import 'package:estate_app/src/model/comment.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/screen/list_like_comment_post_screen.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentScreen extends StatefulWidget {
  final Project idProject;

  const CommentScreen({Key key, this.idProject, }) : super(key: key);
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  ListCommentProjectBloc listCommentProjectBloc = ListCommentProjectBloc();
  CommentProjectBloc commentProjectBloc = CommentProjectBloc();
  final commentController = TextEditingController();
  int a = 0;

  @override
  void dispose() {
    listCommentProjectBloc.close();
    commentProjectBloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    listCommentProjectBloc.add(ListCommentProjectEventFetch(widget.idProject.id));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white60,
              ),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 15,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Bình luận ",style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),),

                  SizedBox(
                    width: 8,
                  ),
                  BlocListener<ListCommentProjectBloc,ListCommentProjectState>(
                    cubit: listCommentProjectBloc,
                    listener: (previous,state){
                      if (state is ListCommentProjectStateSuccess) {
                        a = state.listComment.length;
                        print(a);
                      }
                    },
                    child: BlocBuilder<ListCommentProjectBloc,ListCommentProjectState>(
                      cubit: listCommentProjectBloc,
                      builder: (BuildContext context, state) {
                        return Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.circle,
                          ),
                          child: Text(a.toString()),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            BlocBuilder<ListCommentProjectBloc,ListCommentProjectState>(
              cubit: listCommentProjectBloc,
              builder: (BuildContext ctx,state){
                if (state is ListCommentProjectStateSuccess) {
                  print('thanh cong');
                }
                if (state is ListCommentProjectStateLoading) {
                  return Loading();
                }
                if (state is ListCommentProjectStateSuccess) {
                  return  Expanded(
                      child: ListView.separated(
                          itemBuilder: (_,index){
                            Comment comment = state.listComment[index];
                            final time = DateTime.parse(comment.createdAt).toLocal();
                            String date = DateFormat("dd-MM-yyyy hh:mm:ss").format(time);
                            final timeline = timeago.format(time, locale: 'en_short');
                            return InkWell(
                              onLongPress: (){

                              },
                              onTap: (){
                                Navigator.pushNamed(context, DetailInforScreens,arguments: comment.user.id);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: comment.user.urlAvata == null ?
                                                AssetImage('assets/avatar_image.png') : NetworkImage(comment.user.urlAvata),
                                                fit: BoxFit.cover
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 13,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(comment.user.username,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                ),),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(timeline,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize:12
                                                ),),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(comment.commentContent),
                                          SizedBox(
                                            height: 14,
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 5),
                                                  child: Text('Trả lời ',style: TextStyle(
                                                      color: Colors.grey
                                                  ),),
                                                ),
                                                onTap: (){
                                                  Navigator.pushNamed(context, ReplyCommentScreens,arguments: comment);
                                                },
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(

                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: (){

                                                        },
                                                        child: Icon(Icons.favorite_border,size: 20,),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 2),
                                                        child: Text(comment.countLike.toString(),style: TextStyle(
                                                          fontSize: 14,
                                                        ),),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onTap: (){
                                                  Navigator.pushNamed(context, ListLikeCommentPostScreens,arguments: comment.id);
                                                },
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.mode_comment_outlined,size: 20,),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 2),
                                                        child: Text(comment.countComment.toString(),style: TextStyle(
                                                          fontSize: 14,
                                                        ),),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onTap: (){
                                                  Navigator.pushNamed(context, ReplyCommentScreens,arguments: comment);
                                                },
                                              )
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => Divider(height: 30,color: Colors.grey,thickness: 0.2,endIndent: 20,indent: 20,),
                          itemCount: state.listComment.length)
                  );
                }
                return Text('a');
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: BlocListener<CommentProjectBloc,CommentProjectState>(
                  cubit: commentProjectBloc,
                  listener: (previous,state){
                    if (state is CommentProjectStateFail) {
                      print(state.error);
                    }
                    if (state is CommentProjectStateSuccess) {
                      listCommentProjectBloc.add(ListCommentProjectEventFetch(widget.idProject.id));
                    }
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Thêm bình luận.......",
                              hintStyle: TextStyle(
                                  fontSize: 13
                              )
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.send),
                          onPressed: submit
                      ),
                    ],
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
  void submit(){
    commentProjectBloc.add(CommentProjectEventSubmit(widget.idProject.id, commentController.text,0));
    commentController.clear();
  }
}

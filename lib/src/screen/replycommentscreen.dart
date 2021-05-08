import 'package:estate_app/src/bloc/comment_project/comment_project_bloc.dart';
import 'package:estate_app/src/bloc/list_reply_comment/list_reply_comment_bloc.dart';
import 'package:estate_app/src/model/comment.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReplyCommentScreen extends StatefulWidget {
  final Comment comment;

  const ReplyCommentScreen({Key key, this.comment}) : super(key: key);

  @override
  _ReplyCommentScreenState createState() => _ReplyCommentScreenState();
}

class _ReplyCommentScreenState extends State<ReplyCommentScreen> {
  ListReplyCommentBloc listReplyCommentBloc = ListReplyCommentBloc();
  CommentProjectBloc commentProjectBloc = CommentProjectBloc();
  final commentController = TextEditingController();

  @override
  void initState() {

    listReplyCommentBloc.add(ListReplyCommentEventFetchData(widget.comment.newsId, widget.comment.id));
    super.initState();
  }

  @override
  void dispose() {
    listReplyCommentBloc.close();
    // TODO: implement dispose
    commentProjectBloc.close();
    super.dispose();
  }

  void submit() {
    commentProjectBloc.add(CommentProjectEventSubmit(widget.comment.newsId,commentController.text,widget.comment.id));
    commentController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 16,
          ),
          onPressed: () {
            Navigator.pop(context,true);
          },
        ),
        title: Text(
          'Trả lời',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
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
                                image: widget.comment.user.urlAvata == null
                                    ? AssetImage('assets/avatar_image.png')
                                    : NetworkImage(widget.comment.user.urlAvata),
                                fit: BoxFit.cover),
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
                              Text(
                                widget.comment.user.username,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'a',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(widget.comment.commentContent),

                          Row(
                            children: [
                              InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Trả lời ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                onTap: () {

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
                                        onTap: () {},
                                        child: Icon(
                                          Icons.favorite_border,
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Text(
                                          widget.comment.countLike.toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {},
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            Expanded(
              child: BlocBuilder<ListReplyCommentBloc,ListReplyCommentState>(
                cubit: listReplyCommentBloc,
                builder: (BuildContext ctx,state){
                  if (state is ListReplyCommentStateLoading) {
                    return Loading();
                  }
                  if (state is ListReplyCommentStateSuccess) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.listReplyComment.length,
                      itemBuilder: (_,index){
                        Comment comment = state.listReplyComment[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 40,bottom: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: comment.user.urlAvata == null
                                            ? AssetImage('assets/avatar_image.png')
                                            : NetworkImage(comment.user.urlAvata),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(comment.user.username,style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),),
                                    Text(comment.commentContent),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Text('aq');
                },
              )
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child:BlocListener<CommentProjectBloc,CommentProjectState>(
                    cubit: commentProjectBloc,
                    listener: (previous,state){
                      if(state is CommentProjectStateSuccess){

                      }
                      if (state is CommentProjectStateSuccess) {
                        listReplyCommentBloc.add(ListReplyCommentEventFetchData(widget.comment.newsId, widget.comment.id));
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
                        onPressed: submit,
                      ),
                    ],
                  ),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }


}

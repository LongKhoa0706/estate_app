import 'package:estate_app/src/bloc/list_like_comment/list_like_comment_bloc.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListLikeCommentPostScreen extends StatefulWidget {
  final int idComment;

  const ListLikeCommentPostScreen({Key key, this.idComment}) : super(key: key);

  @override
  _ListLikeCommentPostScreenState createState() => _ListLikeCommentPostScreenState();
}

class _ListLikeCommentPostScreenState extends State<ListLikeCommentPostScreen> {
  ListLikeCommentBloc likeCommentBloc = ListLikeCommentBloc();

  @override
  void dispose() {
    likeCommentBloc.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    likeCommentBloc.add(ListLikeCommentEventFetching(widget.idComment));
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            IconButton(icon: Icon(Icons.arrow_back_ios,size: 16,),
                alignment: Alignment.topLeft,
                onPressed: () {
                  Navigator.pop(context);
                }),
            Text("Lượt thích ", style: TextStyle(
                color: Colors.black,
                fontSize: 27,
                fontWeight: FontWeight.bold
            ),),
            Expanded(
              child: BlocBuilder<ListLikeCommentBloc,ListLikeCommentState>(
                cubit: likeCommentBloc,
                builder: (BuildContext ctx,state){
                  if (state is ListLikeCommentStateLoading) {
                    return Loading();
                  }
                  if (state is ListLikeCommentStateSuccess) {
                    print(state.listLikeComment.length);
                    return  ListView.builder(
                      itemCount: state.listLikeComment.length,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shrinkWrap: true,
                      itemBuilder: (_,index){
                        Users user = state.listLikeComment[index];
                        return  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: user.urlAvata == null ? AssetImage('assets/avatar_image.png') :
                                    NetworkImage(user.urlAvata),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(user.username.toString(),),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Text('v');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

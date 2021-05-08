import 'package:estate_app/src/bloc/list_like_post/list_like_post_bloc.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListLikePostScreen extends StatefulWidget {
  final int idPost;

  const ListLikePostScreen({Key key, this.idPost}) : super(key: key);

  @override
  _ListLikePostScreenState createState() => _ListLikePostScreenState();
}

class _ListLikePostScreenState extends State<ListLikePostScreen> {
  ListLikePostBloc listLikePostBloc = ListLikePostBloc();

  @override
  void dispose() {
    listLikePostBloc.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listLikePostBloc.add(ListLikePostEventFetchData(widget.idPost));
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
                child: BlocBuilder<ListLikePostBloc,ListLikePostState>(
                  cubit: listLikePostBloc,
                  builder: (BuildContext ctx,state){
                    if (state is ListLikePostStateLoading) {
                      return Loading();
                    }
                    if (state is ListLikePostStateSuccess) {

                      return  ListView.builder(
                        itemCount: state.listLikeUser.length,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shrinkWrap: true,
                        itemBuilder: (_,index){
                          Users user = state.listLikeUser[index];
                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: user.urlAvata == null ? AssetImage('assets/avatar_image.png') :
                                      NetworkImage(user.urlAvata),
                                      fit: BoxFit.cover
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
                    return Text('a');
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}

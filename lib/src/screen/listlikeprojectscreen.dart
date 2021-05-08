import 'package:estate_app/src/bloc/list_like_project/list_like_project_bloc.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListLikeProjectScreen extends StatefulWidget {
  final int idProject;

  const ListLikeProjectScreen({Key key, this.idProject}) : super(key: key);

  @override
  _ListLikeProjectScreenState createState() => _ListLikeProjectScreenState();
}

class _ListLikeProjectScreenState extends State<ListLikeProjectScreen> {
  ListLikeProjectBloc listLikeProjectBloc = ListLikeProjectBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    listLikeProjectBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    listLikeProjectBloc.add(ListLikeProjectEventFetchData(widget.idProject));
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
                child: BlocBuilder<ListLikeProjectBloc,ListLikeProjectState>(
                  cubit: listLikeProjectBloc,
                  builder: (BuildContext ctx,state){
                    if (state is ListLikeProjectStateLoading) {
                      return Loading();
                    }
                    if (state is ListLikeProjectStateSuccess) {
                      return  ListView.builder(
                        itemCount: state.listUser.length,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shrinkWrap: true,
                        itemBuilder: (_,index){
                          Users user = state.listUser[index];
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

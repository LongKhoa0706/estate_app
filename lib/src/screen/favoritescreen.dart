import 'package:estate_app/src/bloc/my_favorite/my_favorite_bloc.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  MyFavoriteBloc myFavoriteBloc = MyFavoriteBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    myFavoriteBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myFavoriteBloc.add(MyFavoriteEventFetchData());
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            IconButton(
                alignment: Alignment.topLeft,
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                ),
                onPressed: () => Navigator.pop(context)),
            Text(
              "Yêu Thích ",
              style: TextStyle(
                  color: kColorPrimary,
                  fontSize: 26,
                  fontFamily: kFontBold,
                  fontWeight: FontWeight.w200),
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<MyFavoriteBloc,MyFavoriteState>(
              cubit: myFavoriteBloc,
              builder: (BuildContext ctx,state){
                if (state is MyFavoriteStateSuccess) {
                  return state.listMyLike.length == 0 ? Center(
                    child: Column(

                      children: [
                        Container(width: 100,height: 130,child: SvgPicture.asset('assets/nodata.svg',fit: BoxFit.cover,)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Chưa có dữ liệu ")
                      ],
                    ),
                  ) :Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(0.0),
                      itemCount: state.listMyLike.length,
                      shrinkWrap: true,
                      itemBuilder: (_,index){
                        Project project = state.listMyLike[index];
                        return Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(project.newsTitle,  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: kFontBold,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: SizeConfig().getScreenHeight(160),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(project.newsImage[0]),
                                  fit: BoxFit.cover
                                )
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  child: Text('Xem chi tiết',
                                      style:TextStyle(
                                      fontFamily: kFontBold,
                                      color: kColorPrimary,
                                      fontWeight: FontWeight.w200
                                  ) ,),
                                  onTap: (){
                                    Navigator.pushNamed(context, DetailProductScreens,arguments: project.id);
                                  },
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(Icons.arrow_forward_ios,size: 10,color: kColorPrimary,),
                                )
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }

                if (state is MyFavoriteStateFail) {
                  return Text(state.error);
                }
                if (state is MyFavoriteStateLoading) {
                  return Loading();
                }
                return Text('a');
              },
            )
          ],
        ),
      ),
    );
  }
}

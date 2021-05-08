import 'package:estate_app/src/bloc/detail_project/detail_project_bloc.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/screen/commentscreen.dart';
import 'package:estate_app/src/service/share_pref.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/widget/text.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/widget/containercard.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailProductScreen extends StatefulWidget {
  final int idProject;

  const DetailProductScreen({Key key, this.idProject}) : super(key: key);

  @override
  _DetailProductScreenState createState() => _DetailProductScreenState(idProject);
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  DetailProjectBloc detailProjectBloc = DetailProjectBloc();
  int currentIndex = 0;
  final int idProject;
  final swiperController = SwiperController();

  List<String> listImage = [
    'assets/contract/image1.jpg',
    'assets/contract/image2.jpg',
    'assets/contract/image3.jpg',
  ];

  _DetailProductScreenState(this.idProject);

  @override
  void dispose() {
    detailProjectBloc.close();
    // TODO: implement dispose
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    detailProjectBloc.add(DetailProjectEventFetching(idProject));
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: BlocBuilder<DetailProjectBloc,DetailProjectState>(
          cubit: detailProjectBloc,
          builder: (BuildContext ctx, state){
            if (state is DetailProjectStateLoading) {
              return Loading();
            }
            if (state is DetailProjectStateSuccess) {
              Project project = state.project;
              final fortmantter = NumberFormat("#,###","vi_VN");
              var a = fortmantter.format(project.newsPriceFrom);
              return Stack(
                children: [

                  Container(
                    width: double.infinity,
                    height: SizeConfig().getScreenHeight(320),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: SizeConfig().getScreenHeight(50),
                        ),
                        Swiper(
                          loop: project.newsImage.length == 1 ? false : true,
                          autoplay: project.newsImage.length == 1 ? false : true,
                          itemCount: project.newsImage.length,
                          index: currentIndex,
                          controller: swiperController,
                          pagination: SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.only(
                              right: 20,
                              bottom: SizeConfig().getScreenHeight(40),
                            ),
                            builder: DotSwiperPaginationBuilder(
                                activeColor: kColorPrimary,
                                color: Colors.white,
                                size: 8
                            ),
                          ),
                          itemBuilder: (context, index) {
                            return Image.network(project.newsImage[index],fit: BoxFit.cover,);
                          },
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: SizeConfig().getScreenHeight(40)),
                            child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: _buildIconToolBar(Icons.arrow_back_ios,kColorPrimary),
                            )

                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: SizeConfig().getScreenHeight(290)),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(33),topRight: Radius.circular(33)),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30,right: 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 120,
                                    padding: EdgeInsets.only(top: 4,bottom: 4,right: 10),
                                    decoration: BoxDecoration(
                                      color: kColorPrimary,
                                    ),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(project.newsType.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12
                                      ),),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.favorite_border)
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildHeader(project),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,size: 16,color: kColorPrimary,),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child:TextView(
                                          text: '${project.newsStreet.toString()}',
                                          textColor: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          sizeText: null,
                                        ),
                                      )
                                    ],
                                  ),
                                  // Nhà đất chính chủ
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  _buildText(a+'đ'.toString(), null, null, null),
                                  _buildText('${project.newsBuildingDensity} m2', null, null, null),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Divider(color: Colors.grey[350],),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  _buildText("Mô tả ", Colors.black, FontWeight.bold, 16),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  // _buildText(project.newsDescription,
                                  //     Colors.grey[400], null, null),
                                  DescriptionTextWidget(text: project.newsDescription),

                                  ExpansionTile(
                                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                    expandedAlignment: Alignment.topLeft,
                                    childrenPadding: EdgeInsets.all(0.0),
                                    tilePadding: EdgeInsets.all(0.0),
                                    backgroundColor: Colors.white,
                                    title: Text("Thông tin dự án "),
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Tổng mức xây dựng"),
                                          Text(project.newsLandArea.toString()),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Tổng mức xây dựng"),
                                          Text(project.newsInvestment.toString()),
                                        ],
                                      ),const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Tổng mức xây dựng"),
                                          Text(project.newsPriceFrom.toString()),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Tổng mức xây dựng"),
                                          Text(project.newsBuildingDensity.toString()),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Tổng mức xây dựng"),
                                          Text("20"),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Tổng mức xây dựng"),
                                          Text("20"),
                                        ],
                                      ) ,
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Divider(color: Colors.grey[350],),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  _buildReact(project: project,),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  _buildText("Chủ đất", Colors.black, FontWeight.bold, null),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(project.user.urlAvata.toString()),
                                              fit: BoxFit.cover
                                          ),
                                          shape: BoxShape.circle,

                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            _buildText(project.user.username.toString(), Colors.black, FontWeight.bold, null),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildText("Chủ ", Colors.grey[500],null, null),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      _buildIconToolBar(Icons.chat_bubble,kColorPrimary),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      // _buildIconToolBar(Icons.call,Color(0xff2ECC71))
                                      Container(
                                        padding: EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5),
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
                                        ),
                                        child: InkWell(
                                          onTap: ()=>launch('tel:+${project.user.phone.toString()}'),
                                          child: Row(
                                            children: [
                                              Icon(Icons.call,size: 15,color: Color(0xff2ECC71),),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(project.user.phone),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              );
            }
            return Text('a');
          },
        )
      ),
    );
  }
  // _launchPhone(String phone) async {
  //
  //   if (await canLaunch(phone)) {
  //     await launch(phone);
  //   } else {
  //     throw 'Could not launch $phone';
  //   }
  // }

  _buildIconToolBar(IconData iconData,Color iconColor){
    return Container(

      decoration: BoxDecoration(

        shape: BoxShape.circle,
        color: Colors.white,
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
      ),

      padding: EdgeInsets.all(8),
      child: Icon(iconData,size: 15,color: iconColor,),
    );
  }

  _buildHeader(Project project){

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child:  _buildText(project.newsTitle, Colors.black,FontWeight.bold, 20),
        ),
        // Spacer(),
      ],
    );
  }
}

class _buildReact extends StatefulWidget {
  final Project project;

  const _buildReact({Key key, this.project}) : super(key: key);

  @override
  __buildReactState createState() => __buildReactState();
}

class __buildReactState extends State<_buildReact> {
  bool isLike = false;
  Repositories repositories = Repositories();
  int countLike = 0;
  bool check;


  saveLike(bool status) async {
     await SharedPrefService.setBool(key:"liked" ,value: status );
  }
  readLike() async {
      check =  await SharedPrefService.getBool(key: 'liked');
  }

  @override
  Widget build(BuildContext context) {
    return  ContainerCard(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, ListLikeProjectScreens,arguments: widget.project.id);
              },
              child:  _buildText(countLike.toString() +" lượt thích ",
                  Colors.grey, null, null),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: ()  {
                    if(widget.project.isLiked){
                      setState(() {
                        widget.project.isLiked = false;
                        repositories.projectRepositories.likeProject(widget.project.id,  false);
                        widget.project.countLike -=1;
                      });
                    }else{
                      setState(() {
                        widget.project.isLiked = true;
                        repositories.projectRepositories.likeProject(widget.project.id,  true);
                        widget.project.countLike +=1;
                      });
                    }
                  },
                  child: _buildIconStatus(isLike? Icons.thumb_up : Icons.thumb_up_alt_outlined, "Thích"),
                ),
                InkWell(
                  onTap: (){
                    showBottomShettingg();
                  },
                  child:_buildIconStatus(Icons.comment, "Bình luận"),
                ),
                _buildIconStatus(Icons.share, "Chia sẻ ")
              ],
            )
          ],
        ),
      ),
    );
  }
  showBottomShettingg(){
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        context: context,
        builder: (_) {
          return CommentScreen(idProject:widget.project ,);
        });
  }
}

_buildIconStatus(IconData iconData,String title){
  return  Row(
    children: [
      Icon(iconData,size: 16,color: kColorPrimary,),
      SizedBox(
        width: 10,
      ),
      Text(title),
    ],
  );
}

_buildText(String title,Color textColor,FontWeight fontWeight,double textSize,){
  return    Text(title,
    style:
    TextStyle(
      fontSize: textSize,
      fontWeight: fontWeight,
      color: textColor,
    ),);
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({@required this.text});

  @override
  _DescriptionTextWidgetState createState() => new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 50) {
      firstHalf = widget.text.substring(0, 200);
      secondHalf = widget.text.substring(50, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 10.0),
      child: secondHalf.isEmpty
          ? new Text(firstHalf)
          : new Column(
        children: <Widget>[
           Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf)),
           InkWell(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(
                  flag ? "Chi tiết " : "Ẩn ",
                  style: new TextStyle(color: Colors.blue),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
          ),
        ],
      ),
    );
  }

}




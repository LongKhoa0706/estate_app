import 'dart:async';

import 'package:estate_app/src/bloc/comment_project/comment_project_bloc.dart';
import 'package:estate_app/src/bloc/list_comment_project/list_comment_project_bloc.dart';
import 'package:estate_app/src/model/comment.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/screen/mapscreen.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/formatdate.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/utils/string.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:estate_app/src/widget/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/detail_project/detail_project_bloc.dart';
import 'commentscreen.dart';

class DetailProduct extends StatefulWidget {
  final int idProject;

  const DetailProduct({Key key, this.idProject}) : super(key: key);
  @override
  _DetailProductState createState() => _DetailProductState(idProject);
}

void _launchMapsUrl(String originPlaceId, String destinationPlaceId) async {
  String mapOptions = [
    'origin=$originPlaceId',
    'origin_place_id=$originPlaceId',
    'destination=$destinationPlaceId',
    'destination_place_id=$destinationPlaceId',
    'dir_action=navigate'
  ].join('&');
  final url = 'https://www.google.com/maps/dir/api=1&$mapOptions';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _DetailProductState extends State<DetailProduct> {
  final int idProject;
  final swiperController = SwiperController();
  int currentIndex = 0;
  DetailProjectBloc detailProjectBloc = DetailProjectBloc();
  ListCommentProjectBloc listCommentProjectBloc = ListCommentProjectBloc();
  double lat;

  List<String> listImage = [
    'assets/contract/image1.jpg',
    'assets/contract/image2.jpg',
    'assets/contract/image3.jpg',
  ];

  _DetailProductState(this.idProject);
  @override
  void dispose() {
    detailProjectBloc.close();
    listCommentProjectBloc.close();
    // TODO: implement dispose
    super.dispose();
  }

  // Future<Address>convertAddressToLatLn(String address) async{
  //   var addresses = await Geocoder.local.findAddressesFromQuery(address);
  //   var first = addresses.first;
  //   return first;
  // }
  //
  @override
  Widget build(BuildContext context) {

    listCommentProjectBloc.add(ListCommentProjectEventFetch(idProject));
    detailProjectBloc.add(DetailProjectEventFetching(idProject));

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: BlocBuilder<DetailProjectBloc,DetailProjectState>(
          cubit: detailProjectBloc,
          builder: (BuildContext ctx,state){
            if (state is DetailProjectStateLoading) {
              return Loading();
            }
            if (state is DetailProjectStateSuccess) {
              Project project = state.project;
              final formatter = NumberFormat("#,###","vi_VN");
              var money = formatter.format(project.newsPriceFrom);
              List<Marker> _markers = <Marker>[];
              _markers.add(
                  Marker(
                      onTap: (){
                        _launchMapsUrl("10.7876117","106.5734435" );
                      },
                      markerId: MarkerId('SomeId'),
                      position: LatLng(project.lat,project.lng),
                      infoWindow: InfoWindow(
                        title: project.newsTitle,
                      )
                  )
              );

              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 2,
                                  color: Colors.grey.withOpacity(.3),
                                ),
                                BoxShadow(
                                  offset: Offset(-3, 0),
                                  blurRadius: 15,
                                  color: Color(0xffb8bfce).withOpacity(.1),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                              icon: Icon(Icons.arrow_back_ios,color: Colors.grey,size: 16,),
                                              onPressed: (){
                                                Navigator.pop(context);
                                              }),
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: project.user.urlAvata == null ? AssetImage('assets/avatar_image.png') : NetworkImage(project.user.urlAvata),
                                                    fit: BoxFit.cover
                                                )
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: _buildText(project.user.username,15,Colors.black,FontWeight.w700))
                                        ],
                                      ),
                                    ],

                                  ),
                                ),

                                Container(
                                  width: SizeConfig().getScreenWidth(100),
                                  height: SizeConfig().getScreenHeight(70),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(project.newsLogo[0]),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: SizeConfig().getScreenHeight(300),
                            child: Swiper(
                              loop: state.project.newsImage.length == 1 ? false : true,
                              itemCount: project.newsImage.length,
                              autoplay: state.project.newsImage.length == 1 ? false : true,
                              index: currentIndex,
                              controller: swiperController,
                              pagination: SwiperPagination(
                                alignment: Alignment.bottomCenter,
                                margin: EdgeInsets.only(
                                  right: 10,
                                  bottom: 10,
                                ),
                                builder: DotSwiperPaginationBuilder(
                                    activeColor: kColorPrimary,
                                    color: Colors.white.withOpacity(.3),
                                    size: 8),
                              ),
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [

                                    Positioned.fill(child: Image.network(project.newsImage[index],fit: BoxFit.cover,)),
                                    Center(
                                      child: Image.asset('assets/logo/logofame.png',),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child:_buildText(project.newsTitle.toUpperCase(),20,Colors.black,FontWeight.w200),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: InkWell(
                              onTap: ()=>launch('tel:+${project.user.phone.toString()}'),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey,
                                        width: .3
                                    ),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: _buildText("Hotline:${project.user.phone}", 19, kColorPrimary, FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildText("Địa chỉ: ${project.newsStreet}",16,Colors.red,FontWeight.w200),
                                SizedBox(
                                  height: 5,
                                ),
                                _buildText("Thể loại: ${project.newsType}",16,Colors.red,FontWeight.w200),

                                SizedBox(
                                  height: 5,
                                ),
                                _buildText("Diện tích: ${project.newsLandArea}m2",16,Colors.red,FontWeight.w200),

                                SizedBox(
                                  height: 5,
                                ),
                                _buildText("Giá: ${Format().formatMoney(project.newsPriceFrom)}",16,Colors.red,FontWeight.w200),
                                SizedBox(
                                  height: 5,
                                ),
                                _buildText("Ngày đăng: ${Format().formatDate(project.createdAt)}",16,Colors.red,FontWeight.w200),
                                SizedBox(
                                  height: 25,
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child:Image.asset('assets/container_detail.png',fit: BoxFit.cover,),
                                    ),
                                    Positioned(
                                      top: 25.0,
                                      left: 20.0,
                                      right: 20.0,
                                      bottom: 10.0,
                                      child: SingleChildScrollView(
                                          child: Text(project.newsDescription,
                                            style: TextStyle(  fontFamily: kFontBold,
                                              fontWeight: FontWeight.w200,),)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextView(
                                  text: "Xem trên bản đồ ",
                                  sizeText: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14)
                                  ),
                                  width: double.infinity,
                                  height: 250,
                                  child: GoogleMap(
                                    zoomControlsEnabled: false,
                                    compassEnabled: false,
                                    mapToolbarEnabled: false,
                                    myLocationEnabled: false,
                                    markers: Set<Marker>.of(_markers),
                                    myLocationButtonEnabled: false,
                                    mapType: MapType.normal,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(project.lat,project.lng),
                                      zoom: 16.5,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),

                                _buildReact(project: project,),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 10,
                                ),
                                _buildText("Bình luận mới nhất",17,Colors.black,FontWeight.w700),

                                SizedBox(
                                  height: 15,
                                ),
                                BlocBuilder<ListCommentProjectBloc,ListCommentProjectState>(
                                  cubit: listCommentProjectBloc,
                                  builder: (BuildContext ctx,state){
                                    if (state is ListCommentProjectStateSuccess) {
                                      // Comment comment = state.listComment[0];
                                      return state.listComment.length == 0 ? SizedBox() : Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: state.listComment[0].user.urlAvata == null ?
                                                      AssetImage('assets/avatar_image.png') : NetworkImage(state.listComment[0].user.urlAvata),
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
                                                    _buildText(state.listComment[0].user.username,14,Colors.black,FontWeight.w700),
                                                    SizedBox(
                                                      width: 8,
                                                    ),

                                                  ],
                                                ),
                                                _buildText(state.listComment[0].createdAt,10,Colors.grey,null),

                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  width: double.infinity,

                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      border: Border.all(color: Colors.grey,width: .2,)
                                                  ),
                                                  child: DescriptionTextWidget(text: state.listComment[0].commentContent),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      );
                                    }
                                    if (state is ListCommentProjectStateLoading) {
                                      return Loading();
                                    }

                                    return Text('a');

                                  },
                                )

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                launch('tel:+${project.user.phone}');
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.green[400]
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.call,),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Gọi ngay")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                launch('sms:+${project.user.phone}');
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: kColorPrimary
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Icon(Icons.message_outlined),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("SMS")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is DetailProjectStateFail) {
              return Text(state.error);
            }
            return Text('a');
          },
        ),
      ),
    );
  }
}

Widget _buildText(String text,double sizeText,Color textColor,FontWeight fontWeight){
  return Text(text,style: TextStyle(
      fontSize: sizeText,
      color: textColor,
    fontWeight: FontWeight.w300,
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

    if (widget.text.length > 30) {
      firstHalf = widget.text.substring(0, 80);
      secondHalf = widget.text.substring(30, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(

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
                  style: new TextStyle(color: Colors.grey),
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


  @override
  void initState() {
    super.initState();
    countLike = widget.project.countLike;
    if(countLike == 1){
      setState(() {
        isLike = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Row(
          children: [
            InkWell(
              onTap: (){
                if(isLike){
                  setState(() {
                    isLike = false;
                    repositories.projectRepositories.likeProject(widget.project.id, false);
                    // print(widget.project.countLike);
                    countLike -=1;
                  });
                }else{
                  setState(() {
                    isLike = true;
                    repositories.projectRepositories.likeProject(widget.project.id, true);

                    // saveLike(true);
                    countLike +=1;
                  });
                }
              },
              child: Icon(
                isLike? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                color: Color(0xffFBAB19),
                size: 20,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, ListLikeProjectScreens,arguments: widget.project.id);
              },
              child: Text(
                countLike.toString(),
                style: TextStyle(
                  fontFamily: kFontBold,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: (){
            showBottomShettingg();
          },
          child:   _buildIconStatus('Bình luận',Icons.comment_outlined),
        ),
        _buildIconStatus('Chia sẻ ',Icons.share),

      ],
    );
    // return  ContainerCard(
    //   child: Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         InkWell(
    //           onTap: (){
    //             Navigator.pushNamed(context, ListLikeProjectScreens,arguments: widget.project.id);
    //           },
    //           child:  _buildText(countLike.toString() +" lượt thích ",
    //               Colors.grey, null, null),
    //         ),
    //         Divider(),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             InkWell(
    //               onTap: ()  {
    //                 if(isLike){
    //                   setState(() {
    //                     isLike = false;
    //                     repositories.projectRepositories.likeProject(widget.project.id, false);
    //                     print(widget.project.countLike);
    //                     countLike -=1;
    //                   });
    //                 }else{
    //                   setState(() {
    //                     isLike = true;
    //                     repositories.projectRepositories.likeProject(widget.project.id, true);
    //
    //                     saveLike(true);
    //                     countLike +=1;
    //                   });
    //                 }
    //                 // setState(()  {
    //                 //     isLike = !isLike;
    //                 //    repositories.projectRepositories.likeProject(widget.project.id,isLike);
    //                 // });
    //
    //               },
    //               child: _buildIconStatus(isLike? Icons.thumb_up : Icons.thumb_up_alt_outlined, "Thích"),
    //             ),
    //             InkWell(
    //               onTap: (){
    //                 showBottomShettingg();
    //               },
    //               child:_buildIconStatus(Icons.comment, "Bình luận"),
    //             ),
    //             _buildIconStatus(Icons.share, "Chia sẻ ")
    //           ],
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
  _buildIconStatus(String text,IconData icondata){
    return   Row(
      children: [
        Icon(icondata,color: Color(0xffFBAB19),size: 20,),
        SizedBox(
          width: 8,
        ),
        Text(text,style: TextStyle(  fontFamily: kFontBold,
          fontWeight: FontWeight.w200,),),
      ],
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

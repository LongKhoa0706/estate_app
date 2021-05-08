import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:estate_app/src/bloc/favorite_project/favorite_project_bloc.dart';
import 'package:estate_app/src/bloc/get_banner/get_banner_bloc.dart';
import 'package:estate_app/src/bloc/news/news_bloc.dart';
import 'package:estate_app/src/bloc/project_lease/project_lease_bloc.dart';
import 'package:estate_app/src/model/city.dart';
import 'package:estate_app/src/model/favoriteproject.dart';
import 'package:estate_app/src/model/news.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/screen/dashboard/dashboard.dart';
import 'package:estate_app/src/screen/resutl_search_screen.dart';

import 'package:estate_app/src/service/share_pref.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/formatdate.dart';

import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/widget/containercard.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:estate_app/src/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  NewsBloc newsBLoc = NewsBloc();
  ProjectLeaseBloc projectLeaseBloc = ProjectLeaseBloc();
  ProjectLeaseBloc projectLeaseBloc1 = ProjectLeaseBloc();
  ProjectLeaseBloc projectLeaseBloc2 = ProjectLeaseBloc();
  ProjectLeaseBloc projectLeaseBloc3 = ProjectLeaseBloc();
  ProjectLeaseBloc projectLeaseBloc4 = ProjectLeaseBloc();
  ProjectLeaseBloc projectLeaseBloc5 = ProjectLeaseBloc();
  ProjectLeaseBloc projectLeaseBloc6 = ProjectLeaseBloc();
  GetBannerBloc getBannerBloc = GetBannerBloc();
  FavoriteProjectBloc favoriteProjectBloc = FavoriteProjectBloc();
  final searchController = TextEditingController();
  Address selectCity;
  String value;
  String valuePrice;
  ScrollController _scrollController = ScrollController();
  String valueSearch = '';
  int currentIndex = 0;
  String token;
  int projectLenght = 4;
  final swiperController = SwiperController();
  List<Address> listCity = List();
  Repositories repositories = Repositories();
  // double a;
  // double b;
  // double n = 100000;

  List<String> listOptionPrice = [
    'Dưới 500 triệu',
    '500 triệu - 1 tỷ',
    '1 tỷ - 3 tỷ',
    '3 tỷ - 5 tỷ',
    '5 tỷ - 10 tỷ',
    'Trên 10 tỷ',
  ];

  // _showDialogAuth(){
  //   return showDialog(
  //       context: context,
  //       barrierColor: Colors.grey.withOpacity(.3),
  //       barrierDismissible: true,
  //       builder: (ctx){
  //         return Dialog(
  //           child: SizedBox(
  //             height: 160,
  //             child: Center(
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 10),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text("Vui lòng chọn khoản giá",style: TextStyle(
  //                         color: Colors.black,
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 17
  //                     ),),
  //
  //                     FlutterSlider(
  //                       values: [1000000, 10000000000],
  //                       rangeSlider: true,
  //                       max: 10000000000,
  //                       min: 1000000,
  //                       touchSize: 30,
  //                       jump: true,
  //                       step: FlutterSliderStep(step: 1000000),
  //                       handlerAnimation: FlutterSliderHandlerAnimation(
  //                           curve: Curves.elasticOut,
  //                           reverseCurve: Curves.bounceIn,
  //                           duration: Duration(milliseconds: 500),
  //                           scale: 1.5
  //                       ),
  //                       onDragging: (handlerIndex, lowerValue, upperValue) {
  //                         a = lowerValue;
  //                         b = upperValue;
  //                       },
  //                       tooltip: FlutterSliderTooltip(
  //                         textStyle: TextStyle(fontSize: 20, color: kColorPrimary,fontWeight: FontWeight.bold),
  //                         leftPrefix: Icon(Icons.attach_money, size: 19, color: Colors.black45,),
  //                         rightSuffix: Icon(Icons.attach_money, size: 19, color: Colors.black45,),
  //                       ),
  //                     ),
  //
  //                     SizedBox(
  //                       width: 200,
  //                       child: RaisedButton(
  //                         color: kColorPrimary,
  //                         onPressed: (){
  //                           Navigator.pop(context,[a,b]);
  //                         },
  //                         child: Text("Áp dụng",style: TextStyle(
  //                             color: Colors.white,
  //                             fontWeight: FontWeight.bold
  //                         ),),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       }
  //   );
  // }

  void getData() async {

    setState(() {

    });
    listCity = await repositories.cityRepositories.getAllCity();

    setState(() {

    });
    // selectCity = listCity[0];
  }

  void getToken() async {
     token = await SharedPrefService.getString(key: Constant.KEY_TOKEN);
     print(token);
  }

  List<String> listDropdown = [
    'Đất nền',
    'Nhà phố',
    'Căn hộ',
    'Biệt thự',
    'Chung cư ',
    'Nhà trọ',
    'Cho thuê',
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    projectLeaseBloc.close();
    getBannerBloc.close();
    newsBLoc.close();
    favoriteProjectBloc.close();
    super.dispose();

  }

  @override
  void initState() {
    getToken();
    getData();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
     getBannerBloc.add(GetBannerEventFetchData());
     projectLeaseBloc.add(ProjectLeaseEventFetchData("Cho thuê"));
     projectLeaseBloc1.add(ProjectLeaseEventFetchData("Đất nền"));
     projectLeaseBloc2.add(ProjectLeaseEventFetchData("Căn hộ"));
     projectLeaseBloc3.add(ProjectLeaseEventFetchData("Nhà trọ"));
     projectLeaseBloc4.add(ProjectLeaseEventFetchData("Chung cư"));
     projectLeaseBloc5.add(ProjectLeaseEventFetchData("Biệt thự"));
     projectLeaseBloc6.add(ProjectLeaseEventFetchData("Nhà phố"));
     newsBLoc.add(NewsEventFetchingData());
     favoriteProjectBloc.add(FavoriteProjectEventFetchData());

     return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: SizeConfig().getScreenHeight(40),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (String valueSearc){
                      valueSearch = valueSearc;
                      switch(valuePrice){
                        case "Dưới 500 triệu":
                         Navigator.push(context, MaterialPageRoute(builder: (_)=>ResultSearchScreen(minPrice: "1" , maxPrice: "10000000000",title: valueSearc == null ? "4" : valueSearc,provincials: selectCity == null ? "4" : selectCity.title  ,categories: value == null ? "4" : value,)));
                          break;
                        case "500 triệu - 1 tỷ":
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>ResultSearchScreen(minPrice: "500000000" , maxPrice: "1000000000",title: valueSearch == null ? "4" : valueSearc,provincials: selectCity == null ? "4" : selectCity.title  ,categories: value == null ? "4" : value,)));

                          break;
                        case "1 tỷ - 3 tỷ":
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>ResultSearchScreen(minPrice: "1000000000" , maxPrice: "3000000000",title: valueSearc,provincials: selectCity == null ? "4" : selectCity.title  ,categories: value == null ? "Đất nền" : value,)));

                          break;
                        case "3 tỷ - 5 tỷ":
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>ResultSearchScreen(minPrice: "3000000000" , maxPrice: "5000000000",title: valueSearc,provincials: selectCity == null ? "4" : selectCity.title  ,categories: value == null ? "Đất nền" : value,)));

                          break;
                        case "5 tỷ - 10 tỷ":
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>ResultSearchScreen(minPrice: "5000000000" , maxPrice: "1000000000",title: valueSearc,provincials: selectCity == null ? "4" : selectCity.title  ,categories: value == null ? "Đất nền" : value,)));
                          break;
                        case "Trên 10 tỷ":
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>ResultSearchScreen(minPrice: "1000000" , maxPrice: "10000000000",title: valueSearc,provincials: selectCity == null ? "4" : selectCity.title  ,categories: value == null ? "Đất nền" : value,)));

                          break;
                      }
                      // switch(listOptionPrice){
                      //   case "0":
                      //     break;
                      // }

                      // if (listOptionPrice[0]. != null) {
                      //   print("CO");
                      // }else if(listOptionPrice[1] != null){
                      //   print("CO 1");
                      // }
                      // for(int i = 0 ; i <= listOptionPrice.length ; i ++){
                      //   switch(i){
                      //     case 0:
                      //       print("0");
                      //       break;
                      //     case 1:
                      //       print("1");
                      //       break;
                      //     case 2:
                      //       print("2");
                      //       break;
                      //     case 3:
                      //       print("3");
                      //       break;
                      //     case 4:
                      //       print("4");
                      //       break;
                      //     case 5:
                      //       print("5");
                      //       break;
                      //   }
                      // }
                       // Navigator.push(context, MaterialPageRoute(builder: (_)=>ResultSearchScreen(minPrice: a.round().toString() , maxPrice: b.round().toString(),title: valueSearc,provincials: selectCity == null ? "4" : selectCity.title  ,categories: value == null ? "Đất nền" : value,)));
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tìm kiếm sản phẩm',
                        prefixIcon: Icon(Icons.search,color: kColorPrimary,)
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child:   Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: .2,
                                  color: Colors.grey
                              )
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                items: listDropdown.map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Center(child: Text(e)),
                                )).toList(),
                                value: value,
                                isExpanded: true,
                                style: TextStyle(fontSize: 10,color: Colors.black),
                                hint: Center(child: Text("Chọn thể loại ")),
                                onChanged: (String valuee){
                                  setState(() {
                                    value = valuee;
                                  });
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: .2,
                                  color: Colors.grey
                              )
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Address>(
                              hint: Center(child: Text("Chọn tỉnh/thành phố")),
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black
                              ),
                              items: listCity
                                  .map((e) => DropdownMenuItem<Address>(
                                child: Center(child: Text(e.title)),
                                value: e,
                              ))
                                  .toList(),
                              onChanged: (Address city) async {
                                setState(() {
                                  selectCity = city;
                                });
                              },
                              value: selectCity,),
                          ),
                        ),
                      ),


                      // SizedBox(
                      //   width: 8,
                      // ),
                      // Container(
                      //   child: Text("Tìm"),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child:   Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            width: .2,
                            color: Colors.grey
                        )
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          items: listOptionPrice.map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Center(child: Text(e)),
                          )).toList(),
                          value: valuePrice,
                          isExpanded: true,
                          style: TextStyle(fontSize: 11,color: Colors.black),
                          hint: Center(child: Text("Chọn khoản giá")),
                          onChanged: (String valuee){
                            setState(() {
                              valuePrice = valuee;
                            });
                          }),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<GetBannerBloc,GetBannerState>(
                  cubit: getBannerBloc,
                  builder: (BuildContext ctx,state){
                    if (state is GetBannerStateLoading) {
                      return Loading();
                    }

                    if (state is GetBannerStateFail) {
                      return Text(state.error);
                    }

                    if (state is GetBannerStateSuccess) {
                      return SizedBox(
                        height: SizeConfig().getScreenHeight(250),
                        child: Swiper(
                          loop: true,
                          itemCount: state.listImageBanner.length,
                          autoplay: true,
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
                                color: Colors.orange[200],
                                size: 8),
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              width: SizeConfig().getScreenWidth(100),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage( state.listImageBanner[index]),
                                      fit: BoxFit.cover)),
                            );
                          },
                        ),
                      );
                    }
                    return Text('Chưa có hình ảnh ');
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ContainerCard(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, GetAllScreens);
                                },
                                child: builIconCategories(
                                    'assets/icon/iconbuy.svg', "Mua bán")),
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AddProjectScreens,
                                      arguments: null);
                                },
                                child: builIconCategories(
                                    'assets/icon/iconaddd.svg', "Đăng tin")),
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, MapScreens);
                                },
                                child: builIconCategories(
                                    'assets/icon/iconmap.svg', "Xung quanh")),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, GetProjectByTypeScreens,arguments: "Cho thuê");
                                },
                                child: builIconCategories('assets/icon/iconthue.svg', "Cho thuê ")),
                            InkWell(
                                onTap: (){
                                  // print('a');
                                  Navigator.pushNamed(context, BuyScreens);
                                },
                                child: builIconCategories('assets/icon/iconadd.svg', "Cần mua")),
                            InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, NewsScreens);
                                },
                                child: builIconCategories('assets/icon/iconnews.svg', "Tin tức")),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                ContainerCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, GetAllScreens);
                            },
                            child: _buildTitle("Tất cả")),
                        SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<NewsBloc,NewsState>(
                          cubit: newsBLoc,
                          builder: (BuildContext context,state){
                            if (state is NewsStateLoading) {
                              return Loading();
                            }
                            if (state is NewsStateSuccessful) {
                              return state.listProject.length == 0 ? Center(
                                child: Column(
                                  children: [
                                    Container(width: 100,height: 130,child: SvgPicture.asset('assets/nodata.svg',fit: BoxFit.cover,)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Chưa có bài viết")
                                  ],
                                ),
                              ) : SizedBox(
                                height: SizeConfig().getScreenHeight(220),
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    viewportFraction: 0.33,
                                    height: SizeConfig().getScreenHeight(230),
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayCurve: Curves.easeInSine,

                                  ),
                                  items: state.listProject.map((project) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                            return Padding(
                                              padding: const EdgeInsets.only(left: 5),
                                              child: InkWell(
                                                onTap: (){
                                                  Navigator.pushNamed(context, DetailProductScreens,arguments: project.id);
                                                },
                                                child: Container(

                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        child: CachedNetworkImage(
                                                          height: 100,
                                                          width: 150,
                                                          imageUrl: project.newsImage[0],
                                                          fit: BoxFit.cover,
                                                          progressIndicatorBuilder: (context, url, downloadProgress) => Loading(),
                                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                                        ),
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Icon(Icons.arrow_right,size: 16,color: kColorPrimary,),
                                                          Text(project.newsType,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                              color: kColorPrimary,
                                                              fontWeight: FontWeight.bold
                                                          ),),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(project.newsTitle,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold
                                                      ),),

                                                      Text(project.newsDescription,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                          fontSize: 13
                                                      ),)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                      },
                                    );
                                  }).toList(),
                                )
                              );
                            }
                            if (state is NewsStateFail) {
                              return Text(state.err);
                            }
                            return Text('a');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ContainerCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, GetProjectByTypeScreens,arguments: "Cho thuê");
                            },
                            child: _buildTitle("Cho thuê ")),
                        SizedBox(
                          height: 15,
                        ),
                        BlocBuilder<ProjectLeaseBloc,ProjectLeaseState>(
                          cubit: projectLeaseBloc,
                          builder: (BuildContext ctx,state){
                            if (state is ProjectLeaseStateLoading) {
                              return Loading();
                            }
                            if (state is ProjectLeaseStateSuccess) {
                              return  state.listProject.length == 0 ? Center(
                                  child: Column(
                                    children: [
                                      Container(width: 100,height: 130,child: SvgPicture.asset('assets/nodata.svg',fit: BoxFit.cover,)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Chưa có bài viết")
                                    ],
                                  ),
                              ):SizedBox(
                                  height: SizeConfig().getScreenHeight(220),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      viewportFraction: 0.33,
                                      height: SizeConfig().getScreenHeight(230),
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlayCurve: Curves.easeInSine,

                                    ),
                                    items: state.listProject.map((project) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.pushNamed(context, DetailProductScreens,arguments: project.id);
                                              },
                                              child: Container(

                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      child: CachedNetworkImage(
                                                        height: 100,
                                                        width: 150,
                                                        imageUrl: project.newsImage[0],
                                                        fit: BoxFit.cover,
                                                        progressIndicatorBuilder: (context, url, downloadProgress) => Loading(),
                                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Icon(Icons.arrow_right,size: 16,color: kColorPrimary,),
                                                        Text(project.newsType,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                            color: kColorPrimary,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(project.newsTitle,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold
                                                    ),),

                                                    Text(project.newsDescription,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                        fontSize: 13
                                                    ),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  )
                              );
                            }
                            return Text('a');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                ContainerCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, GetProjectByTypeScreens,arguments: "Đất nền");
                            },
                            child: _buildTitle("Đất nền")),
                        SizedBox(
                          height: 15,
                        ),
                        BlocBuilder<ProjectLeaseBloc,ProjectLeaseState>(
                          cubit: projectLeaseBloc1,
                          builder: (BuildContext ctx,state){
                            if (state is ProjectLeaseStateLoading) {
                              return Loading();
                            }
                            if (state is ProjectLeaseStateSuccess) {
                              return  state.listProject.length == 0 ? Center(
                                child: Column(
                                  children: [
                                    Container(width: 100,height: 130,child: SvgPicture.asset('assets/nodata.svg',fit: BoxFit.cover,)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Chưa có bài viết")
                                  ],
                                ),
                              ): SizedBox(
                                  height: SizeConfig().getScreenHeight(220),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      viewportFraction: 0.33,
                                      height: SizeConfig().getScreenHeight(230),
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlayCurve: Curves.easeInSine,

                                    ),
                                    items: state.listProject.map((project) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.pushNamed(context, DetailProductScreens,arguments: project.id);
                                              },
                                              child: Container(

                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      child: CachedNetworkImage(
                                                        height: 100,
                                                        width: 150,
                                                        imageUrl: project.newsImage[0],
                                                        fit: BoxFit.cover,
                                                        progressIndicatorBuilder: (context, url, downloadProgress) => Loading(),
                                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Icon(Icons.arrow_right,size: 16,color: kColorPrimary,),
                                                        Text(project.newsType,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                            color: kColorPrimary,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(project.newsTitle,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold
                                                    ),),

                                                    Text(project.newsDescription,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                        fontSize: 13
                                                    ),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  )
                              );
                            }
                            return Text('a');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ContainerCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, GetProjectByTypeScreens,arguments: "Nhà trọ");
                            },
                            child: _buildTitle("Nhà trọ")),
                        SizedBox(
                          height: 15,
                        ),
                        BlocBuilder<ProjectLeaseBloc,ProjectLeaseState>(
                          cubit: projectLeaseBloc3,
                          builder: (BuildContext ctx,state){
                            if (state is ProjectLeaseStateLoading) {
                              return Loading();
                            }
                            if (state is ProjectLeaseStateSuccess) {
                              return  state.listProject.length == 0 ? Center(
                                child: Column(
                                  children: [
                                    Container(width: 100,height: 130,child: SvgPicture.asset('assets/nodata.svg',fit: BoxFit.cover,)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Chưa có bài viết")
                                  ],
                                ),
                              ):SizedBox(
                                  height: SizeConfig().getScreenHeight(220),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      viewportFraction: 0.33,
                                      height: SizeConfig().getScreenHeight(230),
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlayCurve: Curves.easeInSine,

                                    ),
                                    items: state.listProject.map((project) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.pushNamed(context, DetailProductScreens,arguments: project.id);
                                              },
                                              child: Container(

                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      child: CachedNetworkImage(
                                                        height: 100,
                                                        width: 150,
                                                        imageUrl: project.newsImage[0],
                                                        fit: BoxFit.cover,
                                                        progressIndicatorBuilder: (context, url, downloadProgress) => Loading(),
                                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Icon(Icons.arrow_right,size: 16,color: kColorPrimary,),
                                                        Text(project.newsType,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                            color: kColorPrimary,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(project.newsTitle,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold
                                                    ),),

                                                    Text(project.newsDescription,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                        fontSize: 13
                                                    ),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  )
                              );
                            }
                            return Text('a');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ContainerCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, GetProjectByTypeScreens,arguments: "Căn hộ");

                            },
                            child: _buildTitle("Căn hộ")),
                        SizedBox(
                          height: 15,
                        ),
                        BlocBuilder<ProjectLeaseBloc,ProjectLeaseState>(
                          cubit: projectLeaseBloc2,
                          builder: (BuildContext ctx,state){
                            if (state is ProjectLeaseStateLoading) {
                              return Loading();
                            }
                            if (state is ProjectLeaseStateSuccess) {
                              return  state.listProject.length == 0 ? Center(
                                child: Column(
                                  children: [
                                    Container(width: 100,height: 130,child: SvgPicture.asset('assets/nodata.svg',fit: BoxFit.cover,)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Chưa có bài viết")
                                  ],
                                ),
                              ):SizedBox(
                                  height: SizeConfig().getScreenHeight(220),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      viewportFraction: 0.33,
                                      height: SizeConfig().getScreenHeight(230),
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlayCurve: Curves.easeInSine,

                                    ),
                                    items: state.listProject.map((project) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.pushNamed(context, DetailProductScreens,arguments: project.id);
                                              },
                                              child: Container(

                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      child: CachedNetworkImage(
                                                        height: 100,
                                                        width: 150,
                                                        imageUrl: project.newsImage[0],
                                                        fit: BoxFit.cover,
                                                        progressIndicatorBuilder: (context, url, downloadProgress) => Loading(),
                                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Icon(Icons.arrow_right,size: 16,color: kColorPrimary,),
                                                        Text(project.newsType,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                            color: kColorPrimary,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(project.newsTitle,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold
                                                    ),),

                                                    Text(project.newsDescription,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                        fontSize: 13
                                                    ),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  )
                              );
                            }
                            return Text('a');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ContainerCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, GetProjectByTypeScreens,arguments: "Nhà phố");

                            },
                            child: _buildTitle("Nhà phố")),
                        SizedBox(
                          height: 15,
                        ),
                        BlocBuilder<ProjectLeaseBloc,ProjectLeaseState>(
                          cubit: projectLeaseBloc6,
                          builder: (BuildContext ctx,state){
                            if (state is ProjectLeaseStateLoading) {
                              return Loading();
                            }
                            if (state is ProjectLeaseStateSuccess) {
                              return  state.listProject.length == 0 ? Center(
                                child: Column(
                                  children: [
                                    Container(width: 100,height: 130,child: SvgPicture.asset('assets/nodata.svg',fit: BoxFit.cover,)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Chưa có bài viết")
                                  ],
                                ),
                              ):SizedBox(
                                  height: SizeConfig().getScreenHeight(220),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      viewportFraction: 0.33,
                                      height: SizeConfig().getScreenHeight(230),
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlayCurve: Curves.easeInSine,

                                    ),
                                    items: state.listProject.map((project) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.pushNamed(context, DetailProductScreens,arguments: project.id);
                                              },
                                              child: Container(

                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      child: CachedNetworkImage(
                                                        height: 100,
                                                        width: 150,
                                                        imageUrl: project.newsImage[0],
                                                        fit: BoxFit.cover,
                                                        progressIndicatorBuilder: (context, url, downloadProgress) => Loading(),
                                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Icon(Icons.arrow_right,size: 16,color: kColorPrimary,),
                                                        Text(project.newsType,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                            color: kColorPrimary,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(project.newsTitle,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold
                                                    ),),

                                                    Text(project.newsDescription,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                        fontSize: 13
                                                    ),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  )
                              );
                            }
                            return Text('a');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ContainerCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, GetProjectByTypeScreens,arguments: "Biệt thự");

                            },
                            child: _buildTitle("Biệt thự")),
                        SizedBox(
                          height: 15,
                        ),
                        BlocBuilder<ProjectLeaseBloc,ProjectLeaseState>(
                          cubit: projectLeaseBloc5,
                          builder: (BuildContext ctx,state){
                            if (state is ProjectLeaseStateLoading) {
                              return Loading();
                            }
                            if (state is ProjectLeaseStateSuccess) {
                              return  state.listProject.length == 0 ? Center(
                                child: Column(
                                  children: [
                                    Container(width: 100,height: 130,child: SvgPicture.asset('assets/nodata.svg',fit: BoxFit.cover,)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Chưa có bài viết")
                                  ],
                                ),
                              ):SizedBox(
                                  height: SizeConfig().getScreenHeight(220),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      viewportFraction: 0.33,
                                      height: SizeConfig().getScreenHeight(230),
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlayCurve: Curves.easeInSine,

                                    ),
                                    items: state.listProject.map((project) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.pushNamed(context, DetailProductScreens,arguments: project.id);
                                              },
                                              child: Container(

                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      child: CachedNetworkImage(
                                                        height: 100,
                                                        width: 150,
                                                        imageUrl: project.newsImage[0],
                                                        fit: BoxFit.cover,
                                                        progressIndicatorBuilder: (context, url, downloadProgress) => Loading(),
                                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Icon(Icons.arrow_right,size: 16,color: kColorPrimary,),
                                                        Text(project.newsType,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                            color: kColorPrimary,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(project.newsTitle,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold
                                                    ),),

                                                    Text(project.newsDescription,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                        fontSize: 13
                                                    ),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  )
                              );
                            }
                            return Text('a');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ContainerCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, GetAllScreens);
                            },
                            child: _buildTitle("Chung cư")),
                        SizedBox(
                          height: 15,
                        ),
                        BlocBuilder<ProjectLeaseBloc,ProjectLeaseState>(
                          cubit: projectLeaseBloc4,
                          builder: (BuildContext ctx,state){
                            if (state is ProjectLeaseStateLoading) {
                              return Loading();
                            }
                            if (state is ProjectLeaseStateSuccess) {
                              return  state.listProject.length == 0 ? Center(
                                child: Column(
                                  children: [
                                    Container(width: 100,height: 130,child: SvgPicture.asset('assets/nodata.svg',fit: BoxFit.cover,)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Chưa có bài viết")
                                  ],
                                ),
                              ):SizedBox(
                                  height: SizeConfig().getScreenHeight(220),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      viewportFraction: 0.33,
                                      height: SizeConfig().getScreenHeight(230),
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlayCurve: Curves.easeInSine,

                                    ),
                                    items: state.listProject.map((project) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.pushNamed(context, DetailProductScreens,arguments: project.id);
                                              },
                                              child: Container(

                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      child: CachedNetworkImage(
                                                        height: 100,
                                                        width: 150,
                                                        imageUrl: project.newsImage[0],
                                                        fit: BoxFit.cover,
                                                        progressIndicatorBuilder: (context, url, downloadProgress) => Loading(),
                                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Icon(Icons.arrow_right,size: 16,color: kColorPrimary,),
                                                        Text(project.newsType,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                            color: kColorPrimary,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(project.newsTitle,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold
                                                    ),),

                                                    Text(project.newsDescription,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                        fontSize: 13
                                                    ),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  )
                              );
                            }
                            return Text('a');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ContainerCard(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, NewsScreens);
                            },
                            child: _buildTitle("Tin Tức")),
                        SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<NewsBloc,NewsState>(
                          cubit: newsBLoc,
                          builder: (BuildContext context,state){
                            if (state is NewsStateLoading) {
                              return Center(
                                child: Loading()
                              );
                            }
                            if (state is NewsStateFail) {
                              return Text(state.err.toString());
                            }
                            if (state is NewsStateSuccessful) {
                              return ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (ctx,index){
                                    News news = state.listNews[index];

                                    return InkWell(
                                        onTap: (){

                                          Navigator.pushNamed(context, DetailNewsScreens,arguments: news);
                                        },
                                        child: _buildListNews(news));
                                  },
                                  separatorBuilder: (BuildContext context, int index) => Divider(height: 30,color: Colors.grey,thickness: 0.2,),
                                  itemCount: 5);

                            }
                            return Text('a');

                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget builIconCategories(String image,String title){
  return   Column(
    children: [
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(8),
        ),
        child: SvgPicture.asset(image),
      ),
      SizedBox(
        height: 8,
      ),
      Text(title,style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500
      ),),
    ],
  );
}

Widget _buildListNews(News news){
  final time = DateTime.parse(news.createdAt).toLocal();
  String date = DateFormat("dd-MM-yyyy hh:mm:ss").format(time);
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        child: CachedNetworkImage(
          width: 120,
          height: 100,
          imageUrl: news.urlImg,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) => Loading(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        borderRadius: BorderRadius.circular(10),
      ),

      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical:5 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news.title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              Text(date,style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12
              ),)
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildTitle(String title) {
  return Row(
    children: [
      Expanded(child: Text(title,style: TextStyle(
          color: kColorPrimary,
          fontSize: 16,
          fontWeight: FontWeight.bold
      ),)),
      Icon(Icons.arrow_forward_ios,size: 12,),

    ],
  );

}


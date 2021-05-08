import 'package:estate_app/src/bloc/get_all_project/get_all_project_bloc.dart';
import 'package:estate_app/src/bloc/search_project/search_project_bloc.dart';
import 'package:estate_app/src/model/city.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/service/share_pref.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/formatdate.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:estate_app/src/widget/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_xlider/flutter_xlider.dart';


class GetAllScreen extends StatefulWidget {
  final String keyWord;
  const GetAllScreen({Key key, this.keyWord}) : super(key: key);

  @override
  _GetAllScreenState createState() => _GetAllScreenState();
}
class _GetAllScreenState extends State<GetAllScreen> {
  GetAllProjectBloc getAllProjectBloc = GetAllProjectBloc();
  ScrollController scrollController = ScrollController();
  String type = '';
  SearchProjectBloc searchProjectBloc = SearchProjectBloc();
  Repositories repositories = Repositories();
  List<Address> listCity = List();
  final searchController = TextEditingController();
  Address selectCity;
  bool showType = false;
  String token;
  double a;
  double b;

  @override
  void dispose() {
    getAllProjectBloc.close();
    searchProjectBloc.close();
    // TODO: implement dispose
    super.dispose();
  }
  void getToken() async {
    token = await SharedPrefService.getString(key: Constant.KEY_TOKEN);
  }

  void getData() async {

    setState(() {

    });
    listCity = await repositories.cityRepositories.getAllCity();

    setState(() {

    });
    // selectCity = listCity[0];
  }
  _showDialogAuth(){
    return showDialog(
        context: context,
        barrierColor: Colors.grey.withOpacity(.3),
        barrierDismissible: true,
        builder: (ctx){
          return Dialog(
            child: SizedBox(
              height: 160,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Vui lòng chọn khoản giá",style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),),
                      FlutterSlider(
                        values: [1000000, 1000000000],
                        rangeSlider: true,
                        max: 1000000000,
                        min: 1000000,
                        touchSize: 30,
                        jump: true,
                        step: FlutterSliderStep(step: 1000000),
                        handlerAnimation: FlutterSliderHandlerAnimation(
                            curve: Curves.elasticOut,
                            reverseCurve: Curves.bounceIn,
                            duration: Duration(milliseconds: 500),
                            scale: 1.5
                        ),
                        onDragging: (handlerIndex, lowerValue, upperValue) {
                          a = lowerValue;
                          b = upperValue;
                        },
                        tooltip: FlutterSliderTooltip(
                          textStyle: TextStyle(fontSize: 20, color: kColorPrimary,fontWeight: FontWeight.bold),
                          leftPrefix: Icon(Icons.attach_money, size: 19, color: Colors.black45,),
                          rightSuffix: Icon(Icons.attach_money, size: 19, color: Colors.black45,),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: RaisedButton(
                          color: kColorPrimary,
                          onPressed: (){
                            Navigator.pop(context,[a,b]);
                          },
                          child: Text("Áp dụng",style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  @override
  void initState() {
    getData();

    widget.keyWord == null
        ? getAllProjectBloc.add(GetAllProjectEventFetching())
        : searchProjectBloc.add(
            SearchProjectEventSubmit(widget.keyWord, "news_title", null, null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2.0,2.0),
                    ),
                  ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,size: 18,),
                    onPressed: (){
                      Navigator.pop(context,'');
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: SizeConfig().getScreenHeight(40),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: searchController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (String result){
                          searchProjectBloc.add(SearchProjectEventSubmit(searchController.text.trim(),"news_title","4","provincials"));
                          setState(() {

                          });
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tìm kiếm sản phẩm',
                            prefixIcon: Icon(Icons.search,color: kColorPrimary,)
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: .2,
                        color: Colors.grey
                    )
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Address>(
                    hint: Text("Chọn tỉnh/thành phố"),
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black
                    ),
                    items: listCity
                        .map((e) => DropdownMenuItem<Address>(
                              child: Text(e.title),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (Address city) async {
                      setState(() {
                        selectCity = city;
                        showType = true;
                      });
                      searchProjectBloc.add(SearchProjectEventSubmit(selectCity.title,"provincials","4","news_type"));
                    },
                    value: selectCity,),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () async {
                  List result  = await _showDialogAuth();
                  if (result.length != 0) {
                   setState(() {

                   });
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          width: .2,
                          color: Colors.grey
                      )
                  ),
                  child: Center(child: Text(a == 0 ? "Chọn khoảng giá": "Từ " + a.toString() + " Đến " + b.toString())),
                ),
              ),
            ),

            Visibility(
              visible: showType,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      InkWell(
                        onTap: (){
                          searchProjectBloc.add(SearchProjectEventSubmit(selectCity.title,"provincials",type="Chung cư".trim(),"news_type"));

                          setState(() {
                          });
                        },
                        child: _buildOptionFileter("Chung cư "),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: (){
                          searchProjectBloc.add(SearchProjectEventSubmit(selectCity.title,"provincials",type="Nhà trọ".trim(),"news_type"));

                          setState(() {
                          });
                        },
                        child: _buildOptionFileter("Nhà trọ"),
                      ),
                      SizedBox(
                        width: 8,
                      ),

                      InkWell(
                        onTap: (){
                          searchProjectBloc.add(SearchProjectEventSubmit(selectCity.title,"provincials",type="Cho thuê".trim(),"news_type"));

                          setState(() {
                          });
                        },
                        child: _buildOptionFileter("Cho thuê"),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: (){
                          searchProjectBloc.add(SearchProjectEventSubmit(selectCity.title,"provincials",type="Biệt thự".trim(),"news_type"));

                          setState(() {
                          });
                        },
                        child: _buildOptionFileter("Biệt thự "),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: (){
                          searchProjectBloc.add(SearchProjectEventSubmit(selectCity.title,"provincials",type="Căn hộ".trim(),"news_type"));

                          // searchProjectBloc.add(SearchProjectEventSubmit(type="Căn hộ ".trim(),"provincials",null));
                          setState(() {
                          });
                        },
                        child: _buildOptionFileter("Căn hộ "),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: (){
                          searchProjectBloc.add(SearchProjectEventSubmit(selectCity.title,"provincials",type="Đất nền ".trim(),"news_type"));
                          // searchProjectBloc.add(SearchProjectEventSubmit(type="Đất nền ".trim(),"provincials",null));
                          setState(() {
                          });
                        },
                        child: _buildOptionFileter("Đất nền "),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: (){
                          searchProjectBloc.add(SearchProjectEventSubmit(selectCity.title,"provincials",type="Nhà phố".trim(),"news_type"));

                          // searchProjectBloc.add(SearchProjectEventSubmit(type="Nhà phố".trim(),"provincials",null));
                          setState(() {
                          });
                        },
                        child: _buildOptionFileter("Nhà phố"),
                      )
                    ],
                  ),
                ),
              ),
            ),

            BlocBuilder<SearchProjectBloc,SearchProjectState>(
              cubit: searchProjectBloc,
              builder: (BuildContext ctx,state){
                if (state is SearchProjectStateLoading) {
                  return Loading();
                }
                if (state is SearchProjectStateFail) {
                  print("UI" + state.error.toString());
                }
                if (state is SearchProjectStateSuccess) {
                  return state.lisSearchProject.length == 0 ? Center(
                    child: Column(
                      children: [
                        Container(width: 100,height: 130,child: SvgPicture.asset('assets/nodata.svg',fit: BoxFit.cover,)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Chưa có bài viết")
                      ],
                    ),
                  ) :  Expanded(
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('Có ${state.lisSearchProject.length} kết quả phù hợp'),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.white60,
                              child: Padding(
                                  padding:  EdgeInsets.symmetric(vertical: SizeConfig().getScreenHeight(15),horizontal: SizeConfig().getScreenWidth(7)),
                                  child: ListView.separated(
                                      itemBuilder: (_,index){
                                        Project project = state.lisSearchProject[index];
                                        return InkWell(
                                          onTap: (){
                                            Navigator.pushNamed(context, DetailProductScreens,arguments: project.id);
                                          },
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: SizeConfig().getScreenWidth(130),
                                                height: SizeConfig().getScreenHeight(100),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    image: DecorationImage(
                                                      image: NetworkImage(project.newsImage[0]),
                                                      fit: BoxFit.cover,

                                                    )
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    TextView(
                                                      text: project.newsTitle,
                                                      fontWeight: FontWeight.w300,
                                                      sizeText: 14,
                                                    ),
                                                    TextView(
                                                      text: project.newsLandArea.toString()+"m2" + " - " + project.newsPriceFrom.toString(),
                                                      fontWeight: FontWeight.w300,
                                                      sizeText: 12,
                                                      textColor: kColorPrimary,
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.home,size: 14,color: Colors.grey,),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        TextView(
                                                          text: project.newsType,
                                                          fontWeight: FontWeight.w300,
                                                          sizeText: 12,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Icon(Icons.location_on_rounded,size: 14,color: Colors.grey,),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Expanded(
                                                          child: TextView(
                                                            text: project.newsProvince,
                                                            fontWeight: FontWeight.w300,
                                                            sizeText: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) => Divider(height: 30,color: Colors.grey,thickness: 0.2,),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(2.0),
                                      controller: scrollController,
                                      itemCount: state.lisSearchProject.length)
                              ),
                            ),
                          )
                        ],
                      )
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Column(
                      children: [
                        Container(width: 100,height: 130,child: SvgPicture.asset('assets/nodata.svg',fit: BoxFit.cover,)),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Vui lòng chọn địa chỉ trước khi tìm kiếm")
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildOptionFileter(String title){
    return BlocBuilder<SearchProjectBloc,SearchProjectState>(
      cubit: searchProjectBloc,
      builder: (BuildContext ctx,state){
        if (state is SearchProjectStateSuccess) {

        }
        // if (state is SearchProjectStateLoading) {
        //   return Loading();
        // }
        return Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: .2,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(5)
          ),
          child: Text(title,style: TextStyle(
              fontSize: 13,
              color: kColorPrimary
          ),),
        );
      },
    );
  }
}

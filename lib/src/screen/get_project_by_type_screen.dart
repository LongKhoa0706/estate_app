import 'package:estate_app/src/bloc/project_lease/project_lease_bloc.dart';
import 'package:estate_app/src/bloc/search_project/search_project_bloc.dart';
import 'package:estate_app/src/model/city.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:estate_app/src/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class GetProjectByTypeScreen extends StatefulWidget {
  final String type;

  const GetProjectByTypeScreen({Key key, this.type}) : super(key: key);

  @override
  _GetProjectByTypeScreenState createState() => _GetProjectByTypeScreenState();
}

class _GetProjectByTypeScreenState extends State<GetProjectByTypeScreen> {
  ProjectLeaseBloc projectLeaseBloc = ProjectLeaseBloc();
  final searchController = TextEditingController();
  Address selectCity = null;
  SearchProjectBloc searchProjectBloc = SearchProjectBloc();
  bool show = false;
  Repositories repositories = Repositories();
  List<Address> listCity = List();

  void getData() async {

    setState(() {

    });
    listCity = await repositories.cityRepositories.getAllCity();

    setState(() {

    });
    // selectCity = listCity[0];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    projectLeaseBloc.close();
    searchProjectBloc.close();
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    projectLeaseBloc.add(ProjectLeaseEventFetchData(widget.type));

    return Scaffold(

      body:  SafeArea(
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
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios,size: 18,),
                        onPressed: (){
                          Navigator.pop(context,'');
                        },
                      ),
                      TextView(text: widget.type,
                      textColor: Colors.black,
                      fontWeight: FontWeight.bold,
                      sizeText: 18,)
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     height: SizeConfig().getScreenHeight(40),
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey[100],
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: TextField(
                  //       controller: searchController,
                  //       textInputAction: TextInputAction.search,
                  //       onSubmitted: (String result){
                  //         // searchProjectBloc.add(SearchProjectEventSubmit(searchController.text.trim(),"news_title",null,null));
                  //         setState(() {
                  //
                  //         });
                  //       },
                  //       decoration: InputDecoration(
                  //           border: InputBorder.none,
                  //           hintText: 'Tìm kiếm sản phẩm',
                  //           prefixIcon: Icon(Icons.search,color: kColorPrimary,)
                  //       ),
                  //     ),
                  //   ),
                  // ),

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
                        show = true;
                      });
                      searchProjectBloc.add(SearchProjectEventSubmit(selectCity.title,"provincials",widget.type,"news_type"));
                    },
                    value: selectCity,),
                ),
              ),
            ),
            selectCity == null  ?   BlocBuilder<ProjectLeaseBloc,ProjectLeaseState>(
              cubit: projectLeaseBloc,
              builder: (BuildContext ctx,state){
                if (state is ProjectLeaseStateLoading) {
                  return Loading();
                }
                if (state is ProjectLeaseStateFail) {
                  print("UI" + state.error.toString());
                }
                if (state is ProjectLeaseStateSuccess) {
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
                  ) :  Expanded(
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('Có ${state.listProject.length} kết quả phù hợp'),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.white60,
                              child: Padding(
                                  padding:  EdgeInsets.symmetric(vertical: SizeConfig().getScreenHeight(15),horizontal: SizeConfig().getScreenWidth(7)),
                                  child: ListView.separated(
                                      itemBuilder: (_,index){
                                        Project project = state.listProject[index];
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
                                      itemCount: state.listProject.length)
                              ),
                            ),
                          )
                        ],
                      )
                  );
                }
                return Text('a');
              },
            ) :   BlocBuilder<SearchProjectBloc,SearchProjectState>(
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
}

import 'package:estate_app/src/bloc/search_project_advance/search_project_advance_bloc.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:estate_app/src/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultSearchScreen extends StatefulWidget {
  final String minPrice;
  final String maxPrice;
  final String title;
  final String provincials;
  final String categories;

  const ResultSearchScreen({Key key, this.minPrice, this.maxPrice, this.title, this.provincials, this.categories}) : super(key: key);

  @override
  _ResultSearchScreenState createState() => _ResultSearchScreenState();
}

class _ResultSearchScreenState extends State<ResultSearchScreen> {
  SearchProjectAdvanceBloc searchProjectAdvanceBloc = SearchProjectAdvanceBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchProjectAdvanceBloc.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    searchProjectAdvanceBloc.add(SearchProjectAdvanceEventSubtmit(widget.categories, widget.minPrice, widget.maxPrice, widget.provincials, widget.title));
    return Scaffold(
      body: SafeArea(
        child: Column(
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
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,size: 18,),
                    onPressed: (){
                      Navigator.pop(context,'');
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text("Kết quả tìm kiếm",style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                    ),),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<SearchProjectAdvanceBloc,SearchProjectAdvanceState>(
              cubit: searchProjectAdvanceBloc,
              builder: (BuildContext ctx,state){
                if (state is SearchProjectAdvanceStateLoading) {
                  return Loading();
                }
                if (state is SearchProjectAdvanceStateSuccess) {
                  return state.listResultProject.length == 0 ? Center(
                    child: Text("Không có dữ liệu",style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),),
                  ) : Expanded(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: SizeConfig().getScreenHeight(15),horizontal: SizeConfig().getScreenWidth(7)),
                      child: ListView.separated(
                          itemBuilder: (_,index){
                            Project project = state.listResultProject[index];
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
                          itemCount: state.listResultProject.length),
                    ),
                  );
                }
                if (state is SearchProjectAdvanceStateFail) {
                  return Text(state.error);

                }
                return Text("ERROR");
              },
            ),
          ],
        ),
      ),
    );
  }
}

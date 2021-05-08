import 'package:estate_app/src/bloc/news/news_bloc.dart';
import 'package:estate_app/src/model/news.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsBloc newsBloc = NewsBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    newsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    newsBloc.add(NewsEventFetchingData());
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
                alignment: Alignment.topLeft, onPressed: () => Navigator.pop(context)),
            Text(
              "Tin Tức ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocBuilder<NewsBloc,NewsState>(
                cubit: newsBloc,
                builder: (BuildContext ctx,state){
                  if (state is NewsStateLoading) {
                    return Loading();
                  }
                  if (state is NewsStateSuccessful) {
                    return ListView.builder(
                      padding: EdgeInsets.all(5.0),
                      itemCount: state.listNews.length,
                      shrinkWrap: true,
                      itemBuilder: (_,index){
                        News news = state.listNews[index];
                        final time = DateTime.parse(news.createdAt).toLocal();
                        String date = DateFormat("dd-MM-yyyy hh:mm:ss").format(time);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, DetailNewsScreens,arguments: news);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[200],
                                      offset: Offset(3.0,3.0),
                                      blurRadius: 10

                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(news.title,style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _buildExtension(date, Icons.access_time),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(news.urlImg),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8),

                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      _buildExtension('chia sẻ',Icons.share),
                                      Spacer(),
                                      _buildExtension('lưu ',Icons.bookmark_border),
                                    ],
                                  )


                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Text('a');
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildExtension(String title,IconData icon){
    return Row(
      children: [
        Icon(icon,size: 18,color: kColorPrimary,),
        SizedBox(
          width: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(title.toUpperCase(),
            style: TextStyle(
                fontSize: 14,

            ),),
        ),
      ],
    );

  }
}

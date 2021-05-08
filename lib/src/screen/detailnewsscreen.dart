

import 'package:estate_app/src/model/news.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class DetailNewsScreen extends StatelessWidget {
  final News news;

  const DetailNewsScreen({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time = DateTime.parse(news.createdAt).toLocal();
    String date = DateFormat("dd-MM-yyyy hh:mm:ss").format(time);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              IconButton(
                  icon: Icon(Icons.arrow_back_ios,size: 15,
                    color: Colors.black,),
                  alignment: Alignment.topLeft,
                  onPressed: ()=> Navigator.pop(context)),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(news.urlImg),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(news.categoryName == null ? "cc" : news.categoryName,
              style: TextStyle(
                color: kColorPrimary,
                letterSpacing: 1.0,
                fontSize: 12,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(
                height: 15,
              ),
              Text(news.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(news.postAuthor,style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                      ),),
                      SizedBox(
                        height: 5,
                      ),
                      Text(date,style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),)
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                  width: 30,
                  child: Divider(thickness: 2.0,color: Colors.grey[200],)),
              SizedBox(
                height: 30,
              ),

              Html(
                data: news.content,

              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

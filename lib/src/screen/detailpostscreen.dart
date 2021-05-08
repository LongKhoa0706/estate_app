import 'package:cached_network_image/cached_network_image.dart';
import 'package:estate_app/src/model/post.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/widget/containercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'commentpostscreen.dart';

class DetailPostScreen extends StatelessWidget {
  final Post post;

  const DetailPostScreen({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final time = DateTime.parse(post.createdAt).toLocal();
    String date = DateFormat("dd-MM-yyyy hh:mm:ss").format(time);
    final timeline = timeago.format(time, locale: 'en_short');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: false,
        leading: IconButton(
          onPressed: ()=>Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios,size: 16,color: Colors.black,),
        ),
        title: Text("Bài Đăng",style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),),
      ),
      body: Container(

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 37,
                      height: 37,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // color: Colors.red
                          image: DecorationImage(
                              image: post.user.urlAvata == null ? AssetImage('assets/avatar_image.png') :
                              NetworkImage(post.user.urlAvata),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(post.user.username,style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(
                          height: 5,
                        ),
                        Text(timeline,style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        ),),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(post.postContent),
              ),
              SizedBox(
                height: 10,
              ),


              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(0.0),
                physics: NeverScrollableScrollPhysics(),
                itemCount: post.postImage.length,
                itemBuilder: (_,index){
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: InkWell(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ShowImage(listUrlImage: post.postImage,))),
                      child: Hero(
                        tag: post.postImage[index],
                        child: Container(
                          child: _loadImage(post.postImage[index]),
                      ),
                      ),
                    ),
                  );
                },
              ),

              Container(
                height: 50,
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        // if(widget.post.isLiked){
                        //   setState(() {
                        //     widget.post.isLiked = false;
                        //     repositories.postRepositories.likePost(widget.post.id,  false);
                        //     widget.post.countLike -=1;
                        //   });
                        // }else{
                        //   setState(() {
                        //     widget.post.isLiked = true;
                        //     repositories.postRepositories.likePost(widget.post.id,  true);
                        //     widget.post.countLike +=1;
                        //   });
                        // }
                      },
                      child: Icon( Icons.favorite_border,
                        size: 20,
                        color: kColorPrimary ,),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, ListLikePostScreens,arguments: post);
                      },
                      child: Text(post.countLike.toString(),style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) {
                            return CommentPostScreen(idPost:post,);
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.mode_comment_outlined, color: Colors.grey,size: 20),
                          SizedBox(
                            width: 10,
                          ),
                          Text(post.countComment.toString(),
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
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
}

_loadImage(String urlImage){
  return CachedNetworkImage(
    imageUrl: urlImage,
    fit: BoxFit.cover,
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        Center(child: CircularProgressIndicator(value: downloadProgress.progress,)),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}

class ShowImage extends StatelessWidget {
  final List<String> listUrlImage;
  const ShowImage({Key key, this.listUrlImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SwiperController swiperController = SwiperController();
    int currentIndex;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(
            tag: listUrlImage,
            child: Swiper(
              loop: true,
              itemCount:listUrlImage.length ,
              index: currentIndex,
              controller: swiperController,
              itemBuilder: (context, index) {
                return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(listUrlImage[index]),
                )),
              );
            },
            ),),
      ),
    );
  }
}


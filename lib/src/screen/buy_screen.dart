import 'package:estate_app/src/bloc/get_new/get_new_bloc.dart';
import 'package:estate_app/src/model/city.dart';
import 'package:estate_app/src/model/new.dart';
import 'package:estate_app/src/repositories/repositories/city_repositories.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/formatdate.dart';
import 'package:estate_app/src/utils/toast.dart';
import 'package:estate_app/src/widget/containercard.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyScreen extends StatefulWidget {
  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  GetNewBloc getNewBloc = GetNewBloc();
  CityRepositories cityRepositories = CityRepositories();

  String selectCity;
  String  selectWard = '';

  final address  = StringBuffer();
  List<Address> listCity = List();
  List<Address> listDistrict = List();
  List<Address> listWard = List();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getNewBloc.close();
  }



  @override
  Widget build(BuildContext context) {
    getNewBloc.add(GetNewEventFetchData());


    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: (){
                Navigator.pushNamed(context, AddBuyScreens).then((value) => setState(() {}));
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kColorPrimary,
                ),
                child:  Icon(Icons.edit,size: 18,color: Colors.white,)
              ),
            ),
          )
        ],
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,
          size: 15,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        title: Text("Cần mua",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: Container(
        child: Column(
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //     color: Color(0xffFBAB19).withOpacity(.2),
            //   ),
            //   padding: EdgeInsets.only(top: 5,right: 10,left: 10,bottom: 25),
            //   width: double.infinity,
            //   child: Column(
            //     children: [
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Container(
            //         width: double.infinity,
            //         height: 45,
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         child:    TextFormField(
            //           decoration: InputDecoration(
            //             border: InputBorder.none,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 15,
            //       ),
            //       Container(
            //         width: double.infinity,
            //         height: 45,
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         child:    TextFormField(
            //           decoration: InputDecoration(
            //             border: InputBorder.none,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: BlocBuilder<GetNewBloc,GetNewState>(
                cubit: getNewBloc,
                builder: (BuildContext ctx,state){
                  if (state is GetNewStateLoading) {
                    return Loading();
                  }
                  if (state is GetNewStateSuccess) {
                    return ListView.builder(
                      itemCount: state.listNew.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext ctx,int index){
                        New news = state.listNew[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                          child: ContainerCard(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Người đăng: ${news.username}", style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Text("Tôi cần thuê ${news.type} tại ${news.location} ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    color: Colors.grey[500],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      buildUtils(Format().formatDate(news.createdAt), Icons.access_time_outlined, Colors.grey),
                                      Spacer(),
                                      InkWell(
                                        onTap: (){
                                          print('ok');
                                          launch('tel:+${news.phone}');
                                        },
                                        child: buildUtils("Gọi", Icons.call_outlined, kColorPrimary),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      // buildUtils("Sms ", Icons.message_outlined, kColorPrimary),

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
                  if (state is GetNewStateFail) {
                    showToast.displayToast(state.error, Colors.red);
                  }
                  return Text("LOI");
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  buildUtils(String title,IconData iconData,Color iconColors){
    return Row(
      children: [
        Icon(iconData,color: iconColors,size: 17,),
        SizedBox(
          width: 10,
        ),
        Text(title),
      ],
    );
  }
}

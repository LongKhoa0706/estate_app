import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:estate_app/src/bloc/delete_project/delete_project_bloc.dart';
import 'package:estate_app/src/bloc/get_my_project/get_my_project_bloc.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/formatdate.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/utils/toast.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ProjectTab extends StatefulWidget {
  final int idUser;

  const ProjectTab({Key key, this.idUser}) : super(key: key);

  @override
  _ProjectTabState createState() => _ProjectTabState();
}

class _ProjectTabState extends State<ProjectTab> with WidgetsBindingObserver  {
  GetMyProjectBloc getMyProjectBloc = GetMyProjectBloc();
  DeleteProjectBloc deleteProjectBloc = DeleteProjectBloc();
  String status =  '';

  @override
  void dispose() {
    getMyProjectBloc.close();
    deleteProjectBloc.close();
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getMyProjectBloc.add(GetMyProjectEventFetching(widget.idUser));
    return Container(
      padding: EdgeInsets.all(10),
      child: BlocListener<GetMyProjectBloc,GetMyProjectState>(
        cubit: getMyProjectBloc,
        listener: (previous,state){
          if (state is GetMyProjectStateSuccess) {
          }
          if (state is GetMyProjectStateLoading) {
          }
        },
        child: BlocBuilder<GetMyProjectBloc,GetMyProjectState>(
          cubit: getMyProjectBloc,
          builder: (BuildContext ctx,state){
            if (state is GetMyProjectStateLoading) {
              return Loading();
            }
            if (state is GetMyProjectStateSuccess) {
              return state.listMyProject.length == 0 ? Column(
                children: [
                  Container(width: 100,height: 130,child: SvgPicture.asset('assets/nodata.svg',fit: BoxFit.cover,)),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Chưa có dữ liệu ")
                ],
              ) : ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(5.0),
                itemCount: state.listMyProject.length,
                itemBuilder: (_,index){
                  Project project = state.listMyProject[index];
                  String date = Format().formatDate(project.createdAt);
                  String money = Format().formatMoney(project.newsPriceFrom);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, DetailProductScreens,arguments: project.id);
                      },
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
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
                              // borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: project.user.urlAvata == null ? AssetImage('assets/avatar_image.png') : NetworkImage(project.user.urlAvata),
                                              fit: BoxFit.cover
                                            ),
                                            shape: BoxShape.circle
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(project.user.username,style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          Text(date,style: TextStyle(fontSize: 12),),
                                        ],
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                          onTap: (){
                                            showBottomShettingg(project.id,project);
                                          },
                                          child: Icon(Icons.more_horiz),),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                Container(
                                  width: double.infinity,
                                  height: SizeConfig().getScreenHeight(250),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(project.newsImage[0]),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(5),topLeft: Radius.circular(5),),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(13),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(project.newsTitle,style: TextStyle(
                                              color: kColorPrimary,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                          buildStatus(project),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(project.newsDescription.toString(),overflow: TextOverflow.ellipsis,style: TextStyle(
                                          fontSize: 12
                                      ),),
                                      SizedBox(
                                        height: 20,
                                      ),

                                      Text(money+'đ',style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                      ),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (state is GetMyProjectStateFail) {
              return Text(state.error);
            }
            return Text('a');
          },
        ),
      ),
    );
  }
  showBottomShettingg(int idProject,Project project){
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            )
        ),
        context: context, builder: (_){
      return BlocListener<GetMyProjectBloc,GetMyProjectState>(
        cubit: getMyProjectBloc,
        listener: (previous,state){
          if (state is GetMyProjectStateSuccess) {
            getMyProjectBloc.add(GetMyProjectEventFetching(widget.idUser));
          }
          if (state is GetMyProjectStateFail) {
            showToast.displayToast(state.error, Colors.red);
          }
        },
        child: Container(
          height: 130,
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  _buildDialogDeleteProject(idProject);
                },
                child: _buildItemUpdateImage(Icons.delete, "Xoá bài viết "),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){
                  if (project == null) {
                    print('no');
                  }  else{
                    Navigator.pushNamed(context, AddProjectScreens,arguments: project);
                  }
                  // Navigator.pushNamed(context, AddProjectScreens,arguments: project);
                },
                child: _buildItemUpdateImage(Icons.edit, "Chỉnh sửa bài viết "),
              ),

            ],
          ),
        ),
      );
    });
  }
  _buildItemUpdateImage(IconData icon,String title){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon,color: kColorPrimary,),
          SizedBox(
            width: 10,
          ),
          Text(title),
        ],
      ),
    );
  }

  _buildDialogDeleteProject(int idProject,){
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Xoá bài viết ',
      desc: 'Bạn có chắc muốn xoá dự án này không? ',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        deleteProjectBloc.add(DeleteProjectEventSubmit(idProject));
        getMyProjectBloc.add(GetMyProjectEventFetching(widget.idUser));
        Navigator.pop(context);
      },
    )..show();
  }


Widget buildStatus(Project project){
    Widget child;
    switch(project.newsStatus){
      case "published":

        return child = Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              Icon(Icons.check,size: 15,color: Colors.white,),
              SizedBox(
                width: 5,
              ),
              Text("Đã duyệt",style: TextStyle(
                color: Colors.white,

              ),)
            ],
          ),
        );

      case "draft":

        return child = Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              Icon(Icons.access_time,size: 15,color: Colors.white,),
              SizedBox(
                width: 5,
              ),
              Text("Đang duyệt",style: TextStyle(
                color: Colors.white
              ),)
            ],
          ),
        );
        case "alone":
          // return child = Text('Bị từ chối ');
          return child = Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              children: [
                Icon(Icons.remove_circle,size: 15,color: Colors.white,),
                SizedBox(
                  width: 5,
                ),
                Text("Bị từ chối ",style: TextStyle(
                    color: Colors.white
                ),)
              ],
            ),
          );

    }
}

}

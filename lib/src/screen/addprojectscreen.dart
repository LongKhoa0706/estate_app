import 'dart:io';
import 'dart:async';

import 'package:estate_app/src/bloc/add_project/add_project_bloc.dart';
import 'package:estate_app/src/bloc/update_project/update_project_bloc.dart';
import 'package:estate_app/src/model/city.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:estate_app/src/repositories/repositories/city_repositories.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/screen/dashboard/tab/home/hometab.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/utils/toast.dart';
import 'package:estate_app/src/utils/validator.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:estate_app/src/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AddProjectScreen extends StatefulWidget {
  final Project project;

  const AddProjectScreen({Key key, this.project}) : super(key: key);

  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}
class _AddProjectScreenState extends State<AddProjectScreen> {
  AddProjectBloc addProjectBloc = AddProjectBloc();
  UpdateProjectBloc updateProjectBloc = UpdateProjectBloc();
  String value;
  final formKey = GlobalKey<FormState>();
  double lat,lng;
  CityRepositories cityRepositories = CityRepositories();

  String selectCity;
  String  selectWard = '';

  final address  = StringBuffer();
  List<Address> listCity = List();
  List<Address> listDistrict = List();
  List<Address> listWard = List();

  List<String> listDropdown = [
    'Đất nền',
    'Nhà phố',
    'Căn hộ',
    'Biệt thự',
    'Chung cư ',
    'Nhà trọ',
    'Cho thuê',
  ];

  void getCity() async {
    listCity = await cityRepositories.getAllCity();
    setState(() {

    });
  }

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: Constant.KEY_GOOGLEMAP);

  Repositories repositories = Repositories();

  TextEditingController addressController =TextEditingController();
  TextEditingController titleController =TextEditingController();
  TextEditingController typeController =TextEditingController();

  TextEditingController landController =TextEditingController();
  TextEditingController densityController =TextEditingController();
  TextEditingController priceController =TextEditingController();
  TextEditingController titleProjectController =TextEditingController();
  TextEditingController squareMetersController=TextEditingController();
  TextEditingController desController=TextEditingController();


  bool isLoading = false;
  List<Asset> listImageProject = List<Asset>();
  String _error = 'No Error Dectected';


  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    List <File> fileImageArray = [];

    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: listImageProject,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Chọn hình",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      listImageProject = resultList;
      _error = error;
    });
  }


  Future<void> _handlePressButton() async {
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: Constant.KEY_GOOGLEMAP,
      onError: onError,
      mode: Mode.fullscreen,
      language: "vi",
      components: [Component(Component.country, "vn")],
    );
    displayPrediction(p);
  }

  void onError(PlacesAutocompleteResponse response) {
    showToast.displayToast(response.errorMessage, Colors.red);
    print(response.errorMessage);
  }


  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
       lat = detail.result.geometry.location.lat;
       lng = detail.result.geometry.location.lng;

       selectWard = detail.result.addressComponents[2].longName;
       selectCity = detail.result.addressComponents[3].longName;

        addressController.text = detail.result.formattedAddress;
    }
  }

  File _image;
  final picker = ImagePicker();

  Future openGallary() async {
    final pipickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pipickedFile != null) {
        _image = File(pipickedFile.path);
        print(_image.path);
      } else {
        print('No image selected.');
      }
    });
    Navigator.pop(context);
  }

  Future openCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void dispose() {
    addProjectBloc.close();
    updateProjectBloc.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // getData();
    if (widget.project!=null) {
      titleProjectController = TextEditingController(text: widget.project.newsProject);
      landController = TextEditingController(text: widget.project.newsLandArea.toString());
      densityController = TextEditingController(text: widget.project.newsBuildingDensity.toString());
      priceController = TextEditingController(text: widget.project.newsPriceFrom.toString());
      titleController = TextEditingController(text: widget.project.newsTitle);
      squareMetersController = TextEditingController(text: widget.project.newsPriceMetersFrom.toString());
      desController = TextEditingController(text: widget.project.newsDescription);
    }
    super.initState();
  }

  void submit()  {
    if (formKey.currentState.validate()) {
      if (_image == null || listImageProject.length == 0) {
         showToast.displayToast("Vui lòng thêm hình ảnh", Colors.red);
      } else{
        if (widget.project!=null) {
          Project project = Project(
            newsTitle: titleController.text,
            newsDescription: desController.text,
            newsType: value,
            newsPriceFrom: int.parse(priceController.text),
            newsPriceMetersFrom: 1 ,
            newsProject: titleProjectController.text,
            lat: lat,
            lng: lng,
            newsDistrict: selectWard,
            newsProvince:  selectCity,
            newsStreet: addressController.text,
            newsWard: "Aa",
            newsInvestment: 1,
            newsLandArea: landController.text,
            newsBuildingDensity: int.parse(densityController.text),
          );
          if(FocusScope.of(context).isFirstFocus) {
            FocusScope.of(context).requestFocus(new FocusNode());
          }
          updateProjectBloc.add(UpdateProjectEventSubmit(widget.project.id,project));
        }else{
          Project project = Project(
            newsTitle: titleController.text,
            newsDescription: desController.text,
            newsType: value,
            newsPriceFrom: int.parse(priceController.text),
            newsPriceMetersFrom: 1 ,
            newsProject: titleProjectController.text,
            newsDistrict: selectWard,
            newsProvince:  selectCity,
            newsStreet: addressController.text,
            newsWard: "",
            lat: lat,
            lng: lng,
            newsInvestment: 1,
            newsLandArea: landController.text,
            newsBuildingDensity: int.parse(densityController.text),
          );
          if(FocusScope.of(context).isFirstFocus) {
            FocusScope.of(context).requestFocus(new FocusNode());
          }
          addProjectBloc.add(AddProjectEventSubmit(project,_image,listImageProject));
        }
      }

    }else{

    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BlocListener<AddProjectBloc,AddProjectState>(
          listener: (previous,state){
            if (state is AddProjectStateFail) {
              showToast.displayToast(state.error,Colors.red);

            }
            if (state is AddProjectStateSuccess) {
              showToast.displayToast("Thêm thành công, vui lòng chờ duyệt!",Colors.green);
              Navigator.pushNamedAndRemoveUntil(context, DashBoardScreens, (route) => false);
            }
          }, 
          cubit: addProjectBloc,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                IconButton(
                    alignment: Alignment.topLeft,
                    icon: Icon(Icons.arrow_back_ios,size: 16,),
                    onPressed: (){
                      Navigator.pop(context);
                    }),
                SizedBox(
                  height: 10,
                ),
                Text(widget.project == null ? "Đăng dự án " : "Chỉnh sửa ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),),
                SizedBox(
                  height: 20,
                ),

                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextFormField(
                          "tên tiêu đề:",
                          titleController,
                          null,null,(v){
                            if (v.isEmpty) {
                              return "Vui lòng nhập tiêu đề";
                            }
                            return null;
                      }),

                      SizedBox(
                        height: 30,
                      ),
                      _buildText("Thể loại:"),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButton<String>(
                          items: listDropdown.map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          )).toList(),
                          value: value,
                          isExpanded: true,
                          style: TextStyle(fontSize: 15,color: Colors.black),
                          hint: Text("Vui lòng chọn thể loại "),
                          onChanged: (String valuee){
                            setState(() {
                              value = valuee;
                            });
                          }),
                      SizedBox(
                        height: 30,
                      ),
                      _buildText("Diện tích:"),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value){
                                if (value.isEmpty) {
                                  return "Vui lòng nhập diện tích";
                                }
                                return null;
                              },
                              controller: landController,
                            ),
                          ),
                          Text('m2'),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      _buildText("Mật độ xây dựng (%):"),

                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "50"
                        ),
                        keyboardType: TextInputType.number ,
                        controller: densityController,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      _buildText("Giá :"),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              validator: (value){
                                if (value.isEmpty) {
                                  return "Vui lòng nhập giá";
                                }
                                return null;
                              },
                              controller: priceController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Text('vnd'.toUpperCase()),
                        ],
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Địa chỉ".toUpperCase(),
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      TextFormField(
                        validator: (value){
                          if (value.isEmpty) {
                            return "Vui lòng nhập địa chỉ";
                          }
                          return null;
                        },
                        onTap: (){
                          _handlePressButton();
                        },
                        readOnly: true,
                        controller: addressController,
                        keyboardType: TextInputType.streetAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      _buildTextFormField("tên sản phẩm:",titleProjectController,null,TextInputType.text,(v){
                        if (v.isEmpty) {
                          return "Vui lòng nhập tên sản phẩm";
                        }
                        return null;
                      }),
                      SizedBox(
                        height: 30,
                      ),
                      _buildText("Mô tả:"),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: SizeConfig().getScreenHeight(180),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.black,
                                width: .2
                            )
                        ),
                        child: TextFormField(
                          validator: (value){
                            if (value.isEmpty) {
                              return "Vui lòng nhập mô tả";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          controller: desController,
                          expands: false,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,

                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextView(
                      text: "Hình chính",
                      fontWeight: FontWeight.w300,
                      sizeText: 14,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Chọn hình sản phẩm đẹp nhất để xuất hiện trên giao diện"),

                SizedBox(
                  height: 10,
                ),
                widget.project != null ?  InkWell(
                  onTap: (){
                    showBottomShettingg();
                  },
                  child: Container(
                      height: 180,
                      child:  widget.project.newsImage[0] != null ? decideImageView1() : Image.network(widget.project.newsImage[0])
                  ),
                ) : Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: InkWell(
                      onTap: (){
                        showBottomShettingg();
                      },
                      child: _image == null ? Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: .2,
                                color: Colors.grey
                            )
                        ),
                        child: Center(
                          child: Text("Click vào đây đăng hình",
                            style: TextStyle(
                                color: Colors.grey
                            ),),
                        ),
                      ) : decideImageView()),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextView(
                      text: "Thêm Hình ảnh ",
                      fontWeight: FontWeight.w300,
                      sizeText: 14,
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                Text("Ảnh: ${listImageProject.length}/10 hãy chọn ảnh chính cho bài niêm yết, thêm nhiều góc chụp khác nhau có hiệu quả tốt nhất"),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (){
                    loadAssets();
                  },
                  child: listImageProject.length == 0 ? Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: .2,
                            color: Colors.grey
                        )
                    ),
                    child: Center(
                      child: Text("Thêm ảnh",
                        style: TextStyle(
                            color: Colors.grey
                        ),),
                    ),
                  ): buildGridView(),
                ),

                SizedBox(
                  height: 20,
                ),

                widget.project == null ? BlocBuilder<AddProjectBloc,AddProjectState>(
                  cubit: addProjectBloc,
                  builder: (BuildContext ctx,state){
                    if (state is AddProjectStateLoading) {
                      return Align(alignment: Alignment.center,child: Center(child: Loading(),));
                    }
                    return Center(
                      child: SizedBox(
                        width: 200,
                        child: RaisedButton(
                          color: kColorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(widget.project == null ? "Đăng" : "Thay đổi",
                            style: TextStyle(
                                color: Colors.white
                            ),),
                          onPressed: submit,
                        ),
                      ),
                    );
                  },
                ) :

                BlocListener<UpdateProjectBloc,UpdateProjectState>(
                  cubit: updateProjectBloc,
                  listener: (previous,state){
                    if (state is UpdateProjectStateSuccess) {
                      showToast.displayToast("Chỉnh sửa thành công ", Colors.green);
                      Navigator.pushNamedAndRemoveUntil(context, DetailInforScreens, (route) => false);
                    }
                  },
                  child: BlocBuilder<UpdateProjectBloc,UpdateProjectState>(
                    cubit: updateProjectBloc,
                    builder: (BuildContext ctx,state){
                      if (state is UpdateProjectStateLoading) {
                        return Center(child: Loading(),);
                      }
                      return Center(
                        child: SizedBox(
                          width: 200,
                          child: RaisedButton(
                            color: kColorPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(widget.project == null ? "Đăng" : "Thay đổi",
                              style: TextStyle(
                                  color: Colors.white
                              ),),
                            onPressed: submit,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  _buildTitle(String title){
    return Text(title.toUpperCase(),style: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.bold
    ),);
  }

  _buildText(String title){
     return   Text(title.toUpperCase(),style: TextStyle(
         color: Colors.black,
         fontSize: 12
     ),
     );
  }

  _buildTextFormField(String title,TextEditingController textEditingController,ValueChanged onChange,TextInputType keyBoardType,   FormFieldValidator<String> validator){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
        TextFormField(
          validator: validator,
          keyboardType: keyBoardType ,
          onChanged: onChange,
          controller: textEditingController,
        ),
      ],
    );
  }

  Widget buildGridView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        children: List.generate(listImageProject.length, (index) {
          Asset asset = listImageProject[index];
          return Padding(
            padding: const EdgeInsets.all(3),
            child: AssetThumb(
              asset: asset,
              width: 400,
              height: 400,
            ),
          );
        }),
      ),
    );
  }

  Widget decideImageView1() {
    if (widget.project.newsImage[0] != null) {
      return SizedBox();
    } else {
      return Container(

        height: 180,
        child: Image.file(
          _image,
        ),
      );
    }
  }

  Widget decideImageView() {

    if (_image == null) {
      return SizedBox();
    } else {
      return Container(
        height: 180,
        child: Image.file(
          _image,
        ),
      );
    }
  }
  showBottomShettingg(){
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            )
        ),
        context: context, builder: (_){
      return Container(
        height: 130,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                openCamera();
              },
              child: _buildItemUpdateImage( Icons.camera_alt, "Chụp ảnh"),
            ),
            SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: (){
                openGallary();
              },
              child: _buildItemUpdateImage(Icons.photo_rounded, "Chọn hình"),
            )

          ],
        ),
      );
    });
  }
  _buildItemUpdateImage(IconData icon,String title){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon,color: Colors.grey,),
          SizedBox(
            width: 10,
          ),
          Text(title),
        ],
      ),
    );
  }
}

class SearchAddress extends StatefulWidget {
  @override
  _SearchAddressState createState() => _SearchAddressState();
}

class _SearchAddressState extends State<SearchAddress> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



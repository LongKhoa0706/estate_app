import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:estate_app/src/bloc/get_all_project/get_all_project_bloc.dart';
import 'package:estate_app/src/bloc/get_project_nearme/get_project_near_user_bloc.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/utils/formatdate.dart';
import 'package:estate_app/src/utils/sizeconfig.dart';
import 'package:estate_app/src/widget/containercard.dart';
import 'package:estate_app/src/widget/loading.dart';
import 'package:estate_app/src/widget/text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:estate_app/src/service/share_pref.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
class MapScreen extends StatefulWidget {
  final Address address;
  const MapScreen({Key key, this.address}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GetProjectNearUserBloc getProjectNearUserBloc = GetProjectNearUserBloc();
  PermissionStatus _permissionGranted;
  Location location = Location();
  bool _serviceEnabled;
  List<Marker> listMarker = List();
  double lat,long;
  LocationData locationData;

  Future<void> checkPermissionLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    getProjectNearUserBloc.add(GetProjectNearUserEventFetchDataNear(locationData.latitude, locationData.longitude, 30));
    print("${locationData.latitude} B  ${locationData.longitude } ");
    SharedPrefService.setDouble(key: 'latitude',value: locationData.latitude );
    SharedPrefService.setDouble(key: 'longitude',value: locationData.longitude );
    // notifyListeners();
  }

  Completer<GoogleMapController> _controller = Completer();
    CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(11.0810863,106.2632873),
    zoom: 14.4746,
  );
  Set<Circle> circles;

  Future onMapCreated(GoogleMapController controller) async {
    if (_controller == null) _controller.complete(controller);
  }

  @override
  void initState()   {
    checkPermissionLocation();
    // readLocationCurrent();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    getProjectNearUserBloc.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // getProjectNearUserBloc.add(GetProjectNearUserEventFetchDataNear(lat, lng, distance));
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<GetProjectNearUserBloc,GetProjectNearUserState>(
            cubit: getProjectNearUserBloc,
            builder: (_,state){
              if (state is GetProjectNearUserStateSuccess) {
               for(Project project in state.listProject){
                  listMarker.add(Marker(

                    markerId: MarkerId(project.newsProject),
                    icon: BitmapDescriptor.defaultMarker,
                    position: LatLng(project.lat, project.lng),
                  ));
               }
                return Stack(
                  children: [
                    GoogleMap(
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      mapToolbarEnabled: false,
                      circles: circles,
                      myLocationEnabled:  true,
                      mapType: MapType.normal,
                      markers: Set<Marker>.of(listMarker),
                      myLocationButtonEnabled: false,
                      initialCameraPosition: CameraPosition(
                        zoom: 13,
                        target: LatLng(locationData.latitude,locationData.longitude),
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 120,
                          child: ListView.builder(
                            itemBuilder: (_,index){
                              Project project = state.listProject[index];
                              return  Padding(
                                padding: const EdgeInsets.only(right: 10,left: 10),
                                child: InkWell(
                                  onTap: (){
                                    _gotoLocation(project.lat, project.lng,project.id);
                                  },
                                  child: Container(

                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
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
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          width: SizeConfig().getScreenWidth(120),
                                          imageUrl: project.newsImage[0],
                                          height: 200,
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              CircularProgressIndicator(value: downloadProgress.progress),
                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text( project.newsTitle.replaceRange(6, project.newsTitle.length, '...'),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                              ),),
                                              // TextView(
                                              //   text:,
                                              //   fontWeight: FontWeight.w300,
                                              //   sizeText: 17,
                                              //
                                              // ),
                                              TextView(
                                                text: project.newsLandArea.toString()+"m2" + " - " + Format().formatMoney(project.newsPriceFrom),
                                                fontWeight: FontWeight.w300,
                                                sizeText: 13,
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
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 5),
                                                    child: Text(project.newsStreet.substring(0,10),overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 12,),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: state.listProject.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0.0),
                            scrollDirection: Axis.horizontal,
                          ),
                        ),

                      ),
                    )
                  ],
                );
              }
              if (state is GetProjectNearUserStateLoading) {
                return Loading();
              }
              return  Text('a');
            },
          ),
          Positioned(
            top: 40,
            left: 10,
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: SizedBox(
                width: 40,
                height: 40,
                child: ContainerCard(
                  child: Icon(Icons.arrow_back_ios,size: 18,),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton:  FloatingActionButton(
        backgroundColor: kColorPrimary,
        onPressed:()=> goToLocation(locationData.latitude,locationData.longitude,13.0),
        child: Icon(Icons.gps_fixed,),
      ),
    );
  }

  Future<void> goToLocation(double latitude,double longitude,double zoom) async {
    final GoogleMapController controller = await _controller.future;
    final CameraPosition cameraPosition = CameraPosition(
        target: LatLng(latitude,longitude),
        zoom: zoom);
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future<void> _gotoLocation(double lat,double long,int idProject) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
    await Future.delayed(Duration(milliseconds: 1610));
    Navigator.pushNamed(context, DetailProductScreens,arguments: idProject);
  }

   void launchMapsUrl(
      sourceLatitude,
      sourceLongitude,
      destinationLatitude,
      destinationLongitude) async {
    String mapOptions = [
      'saddr=$sourceLatitude,$sourceLongitude',
      'daddr=$destinationLatitude,$destinationLongitude',
      'dir_action=navigate'
    ].join('&');

    final url = 'https://www.google.com/maps?$mapOptions';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }  }
}

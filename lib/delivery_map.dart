import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//import 'package:google_place/google_place.dart';
import 'package:location/location.dart';

import 'core/shared_preference.dart';
import 'map_controller.dart';

class DeliveryMapScreen extends StatefulWidget {
  static const routeName = '/delivery_area';

  double? latitude;
  double? longitude;

  DeliveryMapScreen({ Key? key, this.latitude, this.longitude}) : super(key: key);

  @override
  _DeliveryMapScreenState createState() => _DeliveryMapScreenState();
}

class _DeliveryMapScreenState extends State<DeliveryMapScreen>
    with WidgetsBindingObserver {
  LatLng? currentCameraPosition;
  LatLng? previousCameraPosition;
  GoogleMapController? _googleMapController;
  Marker? _origin;
  Marker? _destination;
  final Location _location = Location();

  Set<Marker> _markers={};
  List<Marker> markers = [];

  MapController mapController = Get.put(MapController());
  LocationData? location;
  // CameraPosition initial =
  //     CameraPosition(target: LatLng(0.0, 0.0), zoom: mapZoom);

  Location currentLocation = Location();
  var loc;
  // HomePageController homePageController = Get.find();
  bool overlayLoad = false;

  @override
  void initState() {

    getLocation();
    getPermission();
    //mapController.mapcontroller = Completer();
    WidgetsBinding.instance?.addObserver(this);
    debugPrint('latitudeee ${widget.latitude}');
    debugPrint('longitude ${widget.longitude}');

    // if (SharedPrefs.getLatCust() != null) {
    //   mapController.getWarehouseList(
    //       SharedPrefs.getLatCust(), SharedPrefs.getLngCust());
    //
    //   mapController.initial = CameraPosition(
    //       target: LatLng(SharedPrefs.getLatCust(), SharedPrefs.getLngCust()),
    //       zoom: mapZoom);
    // }

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _googleMapController?.setMapStyle("[]");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  Future<void> getPermission() async {
    var _permissionGranted = await _location.hasPermission();
    debugPrint('permission granded $_permissionGranted');

    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await _location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }
    var _serviceEnabled = await _location.serviceEnabled();
    debugPrint('_serviceEnabled$_serviceEnabled');

    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }

  getLocation() async {
    setState(() {
      overlayLoad = true;
    });
    debugPrint('overlayLoad $overlayLoad');

    loc = await currentLocation.getLocation();

    SharedPrefs.setLngCust(loc.longitude);
    SharedPrefs.setLatCust(loc.latitude);
    setState(() {

      overlayLoad = false;
    });
    debugPrint('overlayLoad $overlayLoad');
    debugPrint('setedlat ${SharedPrefs.getLatCust()}');

    debugPrint('currentLat ${loc.latitude}');
    debugPrint('currentLng ${loc.longitude}');
    if (loc != null) {
      _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(loc.latitude, loc.longitude), zoom: mapZoom)));
    } else {
      Get.defaultDialog(
          middleText: "We couldn't find your location.",
          onConfirm: () {
            Get.back();
          });
    }


    // initial = CameraPosition(
    //     target: LatLng(loc.latitude, loc.longitude),
    //     zoom: 12);
    // debugPrint('initial $initial');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(alignment: Alignment.center,
            children: [
              overlayLoad?
                  Center(child: Container(
                    height: 30,
                      width: 30,
                      child: CircularProgressIndicator()))
              :Container(),
          GoogleMap(
            //   myLocationButtonEnabled: true,
            // myLocationEnabled: true,
            // ignore: sdk_version_set_literal
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
            initialCameraPosition: mapController.initial,
            onCameraMove: (val) async {
              // debugPrint("🗺 " + val.target.toJson().toString());
              currentCameraPosition = val.target;

              // if(SharedPrefs.getLatCust()==null || SharedPrefs.getLatCust()==0.0){
              //   await mapController.getWarehouseList(
              //       SharedPrefs.getLatCust()??  currentCameraPosition.latitude ,
              //       SharedPrefs.getLngCust() ??currentCameraPosition.longitude);
              // }
              // await mapController.getWarehouseList(
              //     currentCameraPosition.latitude,
              //     currentCameraPosition.longitude);
              debugPrint('currentCameraPosition  $currentCameraPosition');
              mapController.currentLatLng =
                  LatLng(val.target.latitude, val.target.longitude);
            },
            // onCameraMoveStarted: () async {
            //   debugPrint("ON MOVE");
            //
            //   await mapController.getWarehouseList(
            //       currentCameraPosition.latitude,
            //       currentCameraPosition.longitude);
            // },
            onMapCreated: (controller) async {
              if (SharedPrefs.getLatCust() != null) {
                // mapController.getWarehouseList(
                    SharedPrefs.getLatCust();
                    SharedPrefs.getLngCust();
              // );

                mapController.initial = CameraPosition(
                    target: LatLng(
                        SharedPrefs.getLatCust()!, SharedPrefs.getLngCust()!),
                    zoom: mapZoom);

              }
              setState(() {
                _googleMapController = controller;
              });
              debugPrint("onMapCreated");
              await getLocation();
              mapController.currentLatLng = LatLng(
                  SharedPrefs.getLatCust() ?? loc.latitude,
                  SharedPrefs.getLngCust() ?? loc.longitude
              );

              // await mapController.getWarehouseList(
              //     SharedPrefs.getLatCust() ?? loc.latitude,
              //     SharedPrefs.getLngCust() ?? loc.longitude
              // );
              // _googleMapController = controller;
              _googleMapController?.animateCamera(
                  CameraUpdate.newCameraPosition(new CameraPosition(
                target: LatLng(SharedPrefs.getLatCust() ?? loc.latitude ?? 0.0,
                    SharedPrefs.getLngCust() ?? loc.longitude ?? 0.0),
                zoom: mapZoom,
              )
                  )
              );
            },

            onCameraIdle: () async {
              debugPrint("Current camera position --- $currentCameraPosition");
              debugPrint(
                  "Previous camera position --- $previousCameraPosition");

              if (currentCameraPosition != null) {
                debugPrint("currentCameraPosition != null && canMove = true");
                // if (previousCameraPosition != null) {
                //   debugPrint("previousCameraPosition!=null");

                // if (currentCameraPosition.latitude.toStringAsFixed(5) !=
                //     currentCameraPosition.latitude.toStringAsFixed(5) &&
                //     currentCameraPosition.longitude.toStringAsFixed(5) !=
                //         previousCameraPosition.longitude.toStringAsFixed(5)) {

                debugPrint("currentCameraPosition!=previousCameraPosition");
                previousCameraPosition = currentCameraPosition;

                // await mapController.getWarehouseList(
                //     currentCameraPosition.latitude,
                //     currentCameraPosition.longitude);
                // await mapController.moveToLatLng(
                //     currentCameraPosition.latitude,
                //     currentCameraPosition.longitude);
                // await mapController.getWarehouseList(
                //    0.000000,0.000000);

                // } else {
                //   debugPrint("currentCameraPosition != null && canMove = false");
                //   previousCameraPosition = currentCameraPosition;
                //   await mapController.getWarehouseList(
                //       currentCameraPosition.latitude,
                //       currentCameraPosition.longitude);
                // await mapController.moveToLatLng(
                //     currentCameraPosition.latitude,
                //     currentCameraPosition.longitude);

                // }

                // _addressController.getPlaceDetails(
                //     currentCameraPosition!.latitude, currentCameraPosition!.longitude);
              }
            },
            // onLongPress: _addMarker,
          ),
          // Positioned(
          //   bottom: MediaQuery.of(context).size.height * .21,
          //   right: (MediaQuery.of(context).size.width / 2) / 2,
          //   child: InkWell(
          //     onTap: () async {
          //       var _permissionGranted = await _location.hasPermission();
          //
          //       if (_permissionGranted == PermissionStatus.denied) {
          //         // return Get.snackbar('Permission Denied', 'Permission to access location is denied please enable it from app settings to get current location');
          //         return Get.defaultDialog(
          //             title: "Permission Denied",
          //             middleText:
          //                 "Permission to access location is denied. Please enable it from app settings to get current location.",
          //             confirm: conformBtn(),
          //             cancelTextColor: Colors.red,
          //             buttonColor: Colors.red,
          //             barrierDismissible: false,
          //             content: Column(
          //               children: [
          //                 Container(
          //                     child: Text(
          //                         "Permission to access location is denied. Please enable it from app settings to get current location.")),
          //               ],
          //             ));
          //         _permissionGranted = await _location.requestPermission();
          //         if (_permissionGranted != PermissionStatus.granted) {
          //           return;
          //         }
          //       }
          //       getLocation();
          //     },
          //     // child: Container(
          //     //   height: MediaQuery.of(context).size.height * .05,
          //     //   width: MediaQuery.of(context).size.width * .45,
          //     //   decoration: BoxDecoration(
          //     //       borderRadius: BorderRadius.circular(10),
          //     //       color: Colors.white,
          //     //       border: Border.all(color: Colors.red)),
          //     //   child: Row(
          //     //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     //     children: [
          //     //       Icon(
          //     //         Icons.location_searching_sharp,
          //     //         color: Colors.red,
          //     //         size: 20,
          //     //       ),
          //     //       Text(
          //     //         'Use current location',
          //     //         style: TextStyle(color: Colors.red),
          //     //       )
          //     //     ],
          //     //   ),
          //     // ),
          //   ),
          // ),
        ]),
      ),
    );
  }

  Widget conformBtn() {
    return ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text('Ok'));
  }
}

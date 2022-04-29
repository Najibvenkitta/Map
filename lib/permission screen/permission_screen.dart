import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loacation_permission/core/shared_preference.dart';
import 'package:location/location.dart';

import '../delivery_map.dart';
import '../map.dart';
import '../map_controller.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  MapController mapController = Get.put(MapController());
  // final Location _location = Location();
  // LocationData? currentPosition;
  // var latitute;
  // var longitude;
  // Future<void> getPermission() async {
  //   var _permissionGranted = await _location.hasPermission();
  //   debugPrint('permission granded $_permissionGranted');
  //
  //   // if (_permissionGranted == PermissionStatus.denied) {
  //   //   _permissionGranted = await _location.requestPermission();
  //   //   if (_permissionGranted != PermissionStatus.granted) {
  //   //     return;
  //   //   }
  //   // }
  //   var _serviceEnabled = await _location.serviceEnabled();
  //   debugPrint('_serviceEnabled$_serviceEnabled');
  //
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await _location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }
  // }
  final Location? _location = Location();
  LocationData? currentPosition;
  var latitute;
  var longitude;

  Future<void> getLocationPermission() async {
    setState(() {
      // isLoading = true;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () async {
                var _permissionGranted = await _location?.hasPermission();
                var _serviceEnabled = await _location?.serviceEnabled();

                if(_permissionGranted == PermissionStatus.granted){
                  if(_serviceEnabled!){

                  setState(() {
                    print("Current latitude ${ mapController.currentLatLng.latitude}");



                    Get.off( DeliveryMap());


                  });
                  }


                }
                if (_permissionGranted == PermissionStatus.denied) {
                  print("\n\n PermissionStatus.denied ");
                  _permissionGranted = await _location?.requestPermission();
                  if (_permissionGranted != PermissionStatus.granted) {

                    if (_permissionGranted == PermissionStatus.denied ||
                        _permissionGranted == PermissionStatus.deniedForever) {
                      Get.dialog(
                        AlertDialog(
                          content: Text("Location permission has been denied, please enable it from settings"),
                          actions: [
                            TextButton(
                              child: Text("Okay"),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    setState(() {
                      // _hasError = true;
                      // isLoading = false;
                    });
                    return;
                  }
                  // else{
                  //   Get.off(DeliveryMap());
                  // }
                }

                print("\n\n 1 _serviceEnabled -- $_serviceEnabled ");
                if (!_serviceEnabled!) {
                  _serviceEnabled = await _location?.requestService();
                  print("\n\n 2 _serviceEnabled -- $_serviceEnabled ");
                  if (!_serviceEnabled!) {
                    Get.dialog(
                      AlertDialog(
                        content: Text("Location is disabled, please enable it from settings"),
                        actions: [
                          TextButton(
                            child: Text("Okay"),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    );
                    setState(() {
                      // _hasError = true;
                      // isLoading = false;
                    });
                    return;
                  }
                }
                currentPosition = await _location?.getLocation();
                latitute = currentPosition?.latitude;
                longitude = currentPosition?.longitude;
                print("Latitude  $latitute");
                print("Longitude  $longitude");
                // getBranchListData(false);
                // setState(() {
                //   isLoading = false;
                // });                  // PermissionStatus? _permissionGranted = await _location?.hasPermission();
                  // if(_permissionGranted == PermissionStatus.granted){
                  //   Get.offAll(()=>DeliveryMapScreen());
                  // }
                  //
                  // if (_permissionGranted == PermissionStatus.denied) {
                  //   // return Get.snackbar('Permission Denied', 'Permission to access location is denied please enable it from app settings to get current location');
                  //   // return Get.defaultDialog(
                  //   //     title: "Permission Denied",
                  //   //     middleText:
                  //   //     "Permission to access location is denied. Please enable it from app settings to get current location.",
                  //   //     confirm: conformBtn(),
                  //   //     cancelTextColor: Colors.red,
                  //   //     buttonColor: Colors.red,
                  //   //     barrierDismissible: false,
                  //   //     content: Column(
                  //   //       children: [
                  //   //         Container(
                  //   //             child: Text(
                  //   //                 "Permission to access location is denied. Please enable it from app settings to get current location.")),
                  //   //       ],
                  //   //     ));
                  //
                  //   _permissionGranted = await _location?.requestPermission();
                  //   _permissionGranted = await _location?.hasPermission();
                  //
                  //   if (_permissionGranted != PermissionStatus.granted) {
                  //     return;
                  //   }
                  // }
                  // getLocation();

              },
                  child:Text('Allow Permission'))
            ],
          ),
        ),
      ),
    );
  }

}


import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location_platform_interface/location_platform_interface.dart';

import 'core/shared_preference.dart';

class MapController extends GetxController {
  // ServiceableWarehouseResponse serviceableWarehouseResponse;
  // List<Warehouse> warehouseList;
  // List<Pincode> pinCodeList;
  RxBool warehouseLoading = false.obs;
  //LocationData currentLatLng ;
  LatLng currentLatLng = LatLng(0.0, 0.0);
  RxString searchKey = "".obs;
  RxBool isOnSearch = false.obs;

  LocationData? currentPosition;
  final Location _location = Location();

  CameraPosition initial = CameraPosition(
    target: LatLng(  SharedPrefs.getLatCust()??0,
        SharedPrefs.getLngCust()??0),
    zoom: 12,
  );
  double oldLat = 0;
  double oldLng = 0;

  Completer<GoogleMapController> mapcontroller = Completer();

  // getWarehouseList(double latitude, double longitude) async {
  //   print("loc.latitude $latitude");
  //   print("loc.longitude $longitude");
  //   warehouseLoading.value = false;
  //   serviceableWarehouseResponse = await getServiceableWarehouses(
  //       latitude: latitude, longitude: longitude);
  //   // latitude: 10.0651300, longitude:76.3509300);
  //   if (serviceableWarehouseResponse.status) {
  //     warehouseList = serviceableWarehouseResponse.warehouses;
  //     warehouseLoading.value = true;
  //   }
  //   warehouseLoading.value = true;
  // }
  //
  // /// serviceable warehouse
  //
  // Warehouse wareHouse;
  // List<Pincode> chosenArea;
  // RxBool onSearchSubmitted = false.obs;
  // RxString selectedLocation = ''.obs;
  //
  // onSearchLocationSubmitted(String value) {
  //   onSearchSubmitted.value = true;
  //
  //   String searchValue = value.toLowerCase();
  //   print('searchValue $searchValue');
  //
  //   if (warehouseList.isNotEmpty) {
  //     wareHouse = warehouseList.firstWhere((element) {
  //       chosenArea = element.pincodes.where((pincode) {
  //         return pincode.pincodeValue.toLowerCase().startsWith(searchValue) ||
  //             pincode.pincodePlace.toLowerCase().startsWith(searchValue);
  //       }).toList();
  //
  //       print('warehouse $wareHouse');
  //
  //       return chosenArea.isNotEmpty;
  //     }, orElse: () => null);
  //   } else {
  //     return Center(
  //       child: Text('No delivery available for current location'),
  //     );
  //   }
  //
  //   if (wareHouse != null) {
  //     print('ware ${wareHouse.warehouseId}');
  //
  //     chosenArea = wareHouse.pincodes.where((pincode) {
  //       return pincode.pincodeValue.toLowerCase().startsWith(searchValue) ||
  //           pincode.pincodePlace.toLowerCase().startsWith(searchValue);
  //     }).toList();
  //   }
  //   onSearchSubmitted.value = false;
  // }

  Future<void> getPermission({bool getCurrentPostition = true}) async {
    var _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    var _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    if (getCurrentPostition) {
      currentPosition = await _location.getLocation();
    }
  }
}

import 'dart:io' show Platform;

import 'package:shared_preferences/shared_preferences.dart';

final int quantitySelectionType = 2; // 1: Textfield 2: Dropdown

bool validateStructureForPassword(String value) {
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{7,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

// List<ProductInfo> featuredProducts;

class SharedPrefs {
  static SharedPreferences? shared;
  //
  // static  bool storeChoosenArea(AreaDetails area) {
  //   try {
  //     shared.setString('area', area.name);
  //     shared.setInt('areaId', area.id);
  //     shared.setInt("warehouseId", area.warehouseId);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // static AreaDetails getChoosenArea() {
  //   return AreaDetails(
  //       name: shared.getString('area'),
  //       id: shared.getInt('areaId'),
  //       warehouseId: shared.getInt('warehouseId'));
  // }

  static bool isSkipped() {
    return shared?.getBool('isSkipped') ?? false;
  }

  static void setIsSkipped(bool status) {
    shared?.setBool('isSkipped', status);
  }

  static bool isloggedIn() {
    return shared?.getBool('loggedIn') ?? false;
  }

  static void setLoggedInStatus(bool status) {
    shared?.setBool('loggedIn', status);
  }

  static void setUserId(int userId) {
    shared?.setInt('user_id', userId);
  }

  static int? getUserId() {
    return shared?.getInt('user_id');
  }

  static void setPublicId(int userId) {
    shared?.setInt('public_id', userId);
  }

  static int? getPublicId() {
    return shared?.getInt('public_id');
  }

  static void storeStringToPrefs({String? data, String? key}) {
    shared?.setString(key!, data!);
  }
  //
  // static String getStringFromPrefs({String? key}) {
  //   return shared.getString(key) ?? '';
  // }
  //
  // static void storeIntToPrefs({int? data, String? key}) {
  //   shared.setInt(key, data);
  // }
  //
  // static int getIntFromPrefs({String key}) {
  //   return shared.getInt(key) ?? null;
  // }

  static void setDeveiceId(String deveiceId) {
    print("\n\n setDeveiceId deveiceId : $deveiceId");
    shared?.setString('deveice_Id', deveiceId);
  }

  static String? getDeveiceId() {
    return shared?.getString('deveice_Id');
  }

  static void setDeveiceType(String deveiceType) {
    shared?.setString('deveice_type', deveiceType);
  }

  static String? getDeveiceType() {
    return shared?.getString('deveice_type');
  }

  static void setReferToken(String token) {
    shared?.setString('referToken', token);
  }
  //
  // static String getReferToken() {
  //   return shared?.getString('referToken') ?? '';
  // }
  //
  // static void setReferedToken(String token) {
  //   shared.setString('referedToken', token);
  // }

  // static String getReferedToken() {
  //   return shared.getString('referedToken') ?? '';
  // }
  //
  // static void setDynamicLink(String link) {
  //   shared.setString('dynamicLink', link);
  // }
  //
  // static String getDynamicLink() {
  //   return shared.getString('dynamicLink') ?? '';
  // }
  //
  // static void setWarehouseId(int wareHouseId) {
  //   shared.setInt('warehouse_id', wareHouseId);
  // }

  // static int? getWarehouseId() {
  //   return shared.getInt('warehouse_id');
  // }

  // static void setAreaId(int areaId) {
  //   shared.setInt('area_id', areaId);
  // }


  //
  // static int getAreaId() {
  //   return shared.getInt('area_id');
  // }

  // static void setAreaName(String areaName) {
  //   shared.setString('area_name', areaName);
  // }

  // static String getAreaName() {
  //   return shared.getString('area_name');
  // }


  static void setLatCust(double latitude) {
    shared?.setDouble('latitude_cust', latitude);
  }

  static double? getLatCust() {
    return shared?.getDouble('latitude_cust');
  }

  static void setLngCust(double longitude) {
    shared?.setDouble('longitude_cust', longitude);
  }

  static double? getLngCust() {
    return shared?.getDouble('longitude_cust');
  }

}





// List<SortingDetails> sortingDetails;

bool isPlatformAndroid() {
  return Platform.isAndroid;
}

// String app_current_version;
// String appCurrentBuildNumber;


final orderCancelTime = 30; // seconds
final minCartValue = 98;
final minCODValue = 1500;
final recordingPeriod = 59999;
var recFile = '';
var cartId = '';
// var addressAudioFileURL = '';
var exampleAudioFilePathMP3 = '';
final minCartOfferValue = 299.00;

final minCartForFreeDelivery = 799;
final mapZoom = 19.0;

final cartAlertMessage =
    'All weights shown on the website/app are before cutting and cleaning. The final weight may vary.';

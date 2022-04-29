import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loacation_permission/core/shared_preference.dart';
import 'package:loacation_permission/map.dart';
import 'package:loacation_permission/permission%20screen/permission_screen.dart';
import 'package:location/location.dart';





class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? e;
  String? packageName;
  String? version;
  String? buildNumber;
  // AppUpdateInfo? _updateInfo;
  final Location _location = Location();


  @override
  void initState() {
    super.initState();
    print('splashscreen');
    // initFirebaseMessaging();
    waitAndChange();


    // print(SharedPrefs().getDriverID());
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   // initFirebaseMessaging();
    //
    //   // PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    //   //   setState(() {
    //   //     e = packageInfo.appName;
    //   //     packageName = packageInfo.packageName;
    //   //     version = packageInfo.version;
    //   //     buildNumber = packageInfo.buildNumber;
    //   //   });
    //   //   waitAndChange();
    //   //
    //   // });
    // });

    // checkForUpdate();
    // _showMyDialog();
    // print('device type: ' + Platform.operatingSystem);
  }


  // Future<void> _getId() async {
  //   // var deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isIOS) {
  //     // import 'dart:io'
  //     SharedPrefs().setDevicePlatform(data: '2'); // iOS
  //     // unique ID on iOS
  //   } else {
  //     SharedPrefs().setDevicePlatform(data: '1'); // android
  //   }
  //   print("'device_platform' :${SharedPrefs().getDevicePlatform()}");
  //   // onAfterWait();
  // }

  Future<Timer> waitAndChange() async {
    return new Timer(Duration(seconds: 1), onAfterWait);
  }

  onAfterWait() async {
    var _permissionGranted = await _location?.hasPermission();
    var _serviceEnabled = await _location.serviceEnabled();

    debugPrint('_serviceEnabled$_serviceEnabled');

    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      Get.off(()=> PermissionScreen());

      if (!_serviceEnabled) {
        return;
      }
    }
    else{
      if(_permissionGranted == PermissionStatus.granted){
        Get.off(DeliveryMap());


      }
      else{
        Get.off(()=> PermissionScreen());
      }
    }



//    Navigator.pushReplacementNamed(context, LoginPage.routeName);
//     if (SharedPrefs().getDriverID() == null) {
//       Get.off(()=>LoginPage());
//       // Navigator.push(
//       //     context, MaterialPageRoute(builder: (context) => LoginPage()));
//     } else {
//       Get.off(()=>DashboardPage());
//       // Navigator.push(
//       //     context, MaterialPageRoute(builder: (context) => DashboardPage()));
//     }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Available'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('A new version of App is available'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Update'),
              onPressed: () {
                // InAppUpdate.performImmediateUpdate().catchError((e) {
                //   print(e);
                //   launchPlayStore();
                // });
              },
            ),
          ],
        );
      },
    );
  }

  // launchPlayStore() async {
  //   String url =
  //       "https://play.google.com/store/apps/details?id=com.delivery.kebcomart";
  //   if (await canLaunch(url)) {
  //     await launch(
  //       url,
  //     );
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: Image.asset('Assets/splash.png'),
      // )

      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Center(
          //   child: Image.asset('assets/logo.png'),
          // ),
          Positioned(
              bottom: 50,
              child: Text(
                "V$version",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none),
              ))
        ],
      ),
    );
  }
}

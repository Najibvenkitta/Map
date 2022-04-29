import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'delivery_map.dart';
import 'map_controller.dart';

class DeliveryMap extends StatefulWidget {
  static const routeName = '/delivery_area';

  const DeliveryMap({Key? key}) : super(key: key);

  @override
  _DeliveryMapState createState() => _DeliveryMapState();
}

class _DeliveryMapState extends State<DeliveryMap> {
  MapController mapController = Get.put(MapController());
  // HomePageController _homePageController = Get.put(HomePageController());

  Location currentLocation = Location();
  double lat = 0.0;
  double lng = 0.0;
  bool isOnSearch = false;
  bool overlayLoad = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(),
          inAsyncCall: overlayLoad,
          child: Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  child: DeliveryMapScreen()),
              Center(
                child: Container(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width * .6,
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            // Container(
                            //     height:
                            //         MediaQuery.of(context).size.height * .05,
                            //     width: MediaQuery.of(context).size.width,
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(5),
                            //         color: Colors.red),
                            //     child: Center(
                            //         child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Text(
                            //           'Your order will be delivered here ',
                            //           textAlign: TextAlign.center,
                            //           style: TextStyle(
                            //               fontSize: 12,
                            //               color: Colors.white,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //         Text(
                            //           'Move pin to your exact location ',
                            //           textAlign: TextAlign.center,
                            //           style: TextStyle(
                            //               fontSize: 10,
                            //               color: Colors.white,
                            //               fontWeight: FontWeight.w600),
                            //         )
                            //       ],
                            //     ))),
                            Icon(Icons.location_on_sharp,
                                color: Colors.black, size: 50),
                          ],
                        ))),
              ),
              // Positioned(
              //     bottom: 0,
              //     child: Container(
              //       width: MediaQuery.of(context).size.width,
              //       height: MediaQuery.of(context).size.height * .21,
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.only(
              //               topLeft: Radius.circular(20),
              //               topRight: Radius.circular(20))),
              //       child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Obx(() {
              //             if (!mapController.warehouseLoading.value) {
              //               return Center(
              //                   child: CircularProgressIndicator(
              //                 color: Colors.red,
              //               ));
              //             }
              //             if (mapController.serviceableWarehouseResponse
              //                     .warehouses.length ==
              //                 0) {
              //               print('warehouseList.length==0 ');
              //               return Center(
              //                 child: Text(
              //                     'We are currently not delivering to this location'),
              //               );
              //             }
              //
              //             return Container(
              //               child: (mapController.serviceableWarehouseResponse
              //                           .warehouses.length !=
              //                       0)
              //                   ? Column(
              //                       //mainAxisAlignment: MainAxisAlignment.center,
              //                       children: [
              //                         // Text('Confirm Delivery Location', style:TextStyle(
              //                         //     fontWeight: FontWeight.normal,
              //                         //     fontSize: 20
              //                         // ),),
              //                         Padding(
              //                           padding:
              //                               const EdgeInsets.only(top: 10.0),
              //                           child: Container(
              //                             child: DottedBorder(
              //                               child: Center(
              //                                 child: Text(
              //                                   'Your order will be delivered to this location',
              //                                   style: TextStyle(
              //                                     fontWeight: FontWeight.w400,
              //                                     fontSize: 12,
              //                                     color: Theme.of(context)
              //                                         .primaryColor,
              //                                   ),
              //                                 ),
              //                               ),
              //                               color:
              //                                   Theme.of(context).primaryColor,
              //                             ),
              //                             height: MediaQuery.of(context)
              //                                     .size
              //                                     .height *
              //                                 .06,
              //                             width: MediaQuery.of(context)
              //                                     .size
              //                                     .width *
              //                                 .8,
              //                           ),
              //                         ),
              //
              //                         // SizedBox(height: 30,),
              //                         Row(
              //                           children: [
              //                             //Icon(Icons.location_on_rounded,color: Colors.red,),
              //                             // (mapController.selectedLocation.value!="")?
              //                             // Container(
              //                             //   width:MediaQuery.of(context).size.width * .5,
              //                             //   child: Text("${mapController.selectedLocation.value}",
              //                             //     style:TextStyle(
              //                             //         fontWeight: FontWeight.bold,
              //                             //         fontSize: 16,
              //                             //       color: Colors.black
              //                             //     ),),
              //                             // ):
              //                             // Text(
              //                             // 'Select your Location',
              //                             //   style:TextStyle(
              //                             //       fontWeight: FontWeight.bold,
              //                             //       fontSize: 20,
              //                             //       color: Colors.black
              //                             //
              //                             //   ),),
              //                             // Spacer(),
              //
              //                             // TextButton(
              //                             //     onPressed: (){
              //                             //       print("mapController.currentLatLng.latitude ${mapController.currentLatLng.latitude}");
              //                             //      // Get.to(()=>ChooseDeliveryArea());
              //                             //       // Get.bottomSheet(
              //                             //       //     deliveryLocationBottomSheet(),
              //                             //       //     backgroundColor: Colors.white,
              //                             //       //    isScrollControlled: true,
              //                             //       //
              //                             //       //
              //                             //       // );
              //                             //
              //                             //       // Get.to(() => WarehouseList(
              //                             //       //   lat:mapController.currentLatLng.latitude ,
              //                             //       //   lng: mapController.currentLatLng.longitude,));
              //                             //     },
              //                             //     child: Text('Select location',
              //                             //     style: TextStyle(
              //                             //       color: Colors.red,
              //                             //         fontWeight: FontWeight.bold,
              //                             //         fontSize: 15
              //                             //     ),
              //                             //     ),
              //                             // )
              //                           ],
              //                         ),
              //                         Spacer(),
              //
              //                         InkWell(
              //                           onTap: () async {
              //                             SharedPrefs.setWarehouseId(
              //                                 mapController.warehouseList.first
              //                                     .warehouseId);
              //                             // SharedPrefs.setAreaId(69);
              //                             // SharedPrefs.setAreaName(
              //                             //     'Kamalapuri Colony');
              //                             setState(() {
              //                               overlayLoad = true;
              //                             });
              //
              //                             print(
              //                                 'area id: ${SharedPrefs.getAreaId()}');
              //                             print(
              //                                 'area name: ${SharedPrefs.getAreaName()}');
              //                             debugPrint(
              //                                 "Precision print -- ${mapController.currentLatLng.latitude.toStringAsFixed(5)}");
              //                             if ((mapController.currentLatLng
              //                                             .latitude
              //                                             .toStringAsFixed(5) ==
              //                                         "17.40727" ||
              //                                     mapController.currentLatLng
              //                                             .latitude
              //                                             .toStringAsFixed(5) ==
              //                                         "17.40726") &&
              //                                 mapController
              //                                         .currentLatLng.longitude
              //                                         .toStringAsFixed(5) ==
              //                                     "78.40851") {
              //                               Get.defaultDialog(
              //                                   title: "Confirm",
              //                                   middleText:
              //                                       "Please confirm your delivery location.",
              //                                   onConfirm: () async {
              //                                     await SharedPrefs.setLatCust(
              //                                         mapController
              //                                             .currentLatLng
              //                                             .latitude);
              //                                     await SharedPrefs.setLngCust(
              //                                         mapController
              //                                             .currentLatLng
              //                                             .longitude);
              //                                     print(
              //                                         'SharedPrefs.getLatitudeCust() ${SharedPrefs.getLatCust()}');
              //                                     print(
              //                                         'SharedPrefs.getLongitude() ${SharedPrefs.getLngCust()}');
              //                                     Get.back();
              //
              //                                     _homePageController
              //                                         .fetchHomePageDetails(
              //                                             true);
              //                                   },
              //                                   cancelTextColor: Colors.red,
              //                                   buttonColor: Colors.red,
              //                                   barrierDismissible: false,
              //                                   onCancel: () {
              //                                     setState(() {
              //                                       overlayLoad = false;
              //                                     });
              //                                     Get.back();
              //                                   });
              //                             } else {
              //                               await SharedPrefs.setLatCust(
              //                                   mapController
              //                                       .currentLatLng.latitude);
              //                               await SharedPrefs.setLngCust(
              //                                   mapController
              //                                       .currentLatLng.longitude);
              //                               print(
              //                                   'SharedPrefs.getLatitudeCust() ${SharedPrefs.getLatCust()}');
              //                               print(
              //                                   'SharedPrefs.getLongitude() ${SharedPrefs.getLngCust()}');
              //                               _homePageController
              //                                   .fetchHomePageDetails(true);
              //                             }
              //                           },
              //                           child: Padding(
              //                             padding: const EdgeInsets.all(8.0),
              //                             child: Container(
              //                                 decoration: BoxDecoration(
              //                                   borderRadius:
              //                                       BorderRadius.circular(20),
              //                                   color: Colors.red,
              //                                 ),
              //                                 width: MediaQuery.of(context)
              //                                     .size
              //                                     .width,
              //                                 height: MediaQuery.of(context)
              //                                         .size
              //                                         .height *
              //                                     .06,
              //                                 child: Center(
              //                                   child: Text(
              //                                     'Continue',
              //                                     style: TextStyle(
              //                                         color: Colors.white,
              //                                         fontWeight:
              //                                             FontWeight.bold,
              //                                         fontSize: 15),
              //                                   ),
              //                                 )),
              //                           ),
              //                         )
              //                       ],
              //                     )
              //                   : Center(
              //                       child: Text(
              //                           'We are currently not delivering to this location'),
              //                     ),
              //             );
              //           })),
              //     ))
            ],
          ),
        ),
      ),
    );
  }

  // Widget deliveryLocationBottomSheet() {
  //   return Container(
  //     color: Colors.white,
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(
  //               'Select a Location',
  //               style: TextStyle(fontSize: 18),
  //             ),
  //           ),
  //           SizedBox(
  //             height: 25,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 8.0, right: 8.0),
  //             child: Container(
  //               height: MediaQuery.of(context).size.height * .06,
  //               child: Center(
  //                 child: TextFormField(
  //                   onFieldSubmitted: (val) {
  //                     setState(() {
  //                       isOnSearch = true;
  //                     });
  //                     mapController.onSearchLocationSubmitted(val);
  //                   },
  //                   onChanged: (val) {
  //                     setState(() {
  //                       isOnSearch = true;
  //                     });
  //                     mapController.onSearchLocationSubmitted(val);
  //                   },
  //                   decoration: InputDecoration(
  //                     prefixIcon: Icon(
  //                       Icons.search,
  //                       color: Colors.red,
  //                     ),
  //                     hintText: 'Search for area,street name...',
  //                     border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                         borderSide: BorderSide(
  //                             color: Theme.of(context).primaryColor)),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Divider(),
  //           // Padding(
  //           //   padding: const EdgeInsets.all(8.0),
  //           //   child: Row(
  //           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           //     children: [
  //           //       Icon(Icons.my_location,color: Colors.red,),
  //           //       // InkWell(
  //           //       //
  //           //       //     child: Text('Use Current location',style: TextStyle(fontSize: 16,color: Colors.red),)),
  //           //       Spacer(),
  //           //       Icon(Icons.arrow_forward_ios,),
  //           //     ],
  //           //   ),
  //           // ),
  //           // Divider(),
  //           // Padding(
  //           //   padding: const EdgeInsets.all(8.0),
  //           //   child: Text('Saved Address',style: TextStyle(fontSize: 18),),
  //           // ),
  //           ModalProgressHUD(
  //               progressIndicator: CircularProgressIndicator(),
  //               inAsyncCall: overlayLoad,
  //               child: buildCenterWidget())
  //           // buildAreasList()
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget buildCenterWidget() {
  //   if (isOnSearch) {
  //     if (mapController.chosenArea.length > 0) {
  //       return buildAreasList();
  //     } else {
  //       return Container(
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text("No search results"),
  //           ],
  //         ),
  //       );
  //     }
  //   }
  //   return Container();
  // }

  // Widget buildAreasList() {
  //   print('building');
  //   return ListView.separated(
  //     shrinkWrap: true,
  //     separatorBuilder: (_, index) {
  //       return Container(
  //         height: 1,
  //         width: double.infinity,
  //         color: Colors.grey[200],
  //       );
  //     },
  //     //itemCount: (isOnSearch)?mapController.chosenArea.length:0,
  //     itemCount: mapController.chosenArea.length,
  //     itemBuilder: (_, index) {
  //       final area = mapController.chosenArea;
  //       final warehouseId = mapController.wareHouse.warehouseId;
  //       return GestureDetector(
  //           onTap: () async {
  //             // await SharedPrefs.storeChoosenArea(area);
  //             //await SharedPrefs.setWareHouseId(warehouseId);
  //             // print("wareHouseId ${SharedPrefs.getWareHouseId()}");
  //
  //             //getWarehouseId();
  //             setState(() {
  //               overlayLoad = true;
  //             });
  //             //_homePageController.fetchHomePageDetails(true);
  //             // Navigator.pushNamedAndRemoveUntil(
  //             //     context, Homepage.routeName, (route) => false);
  //           },
  //           child: Container(
  //             decoration: new BoxDecoration(color: Colors.white),
  //             child: ListTile(
  //               title: Text(
  //                   '${area[index].pincodePlace},${area[index].pincodeValue}'),
  //             ),
  //           ));
  //     },
  //   );
  // }
}

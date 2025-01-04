import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Components/AppTheme.dart';
import '../../Controller/AddressViewController.dart';
import '../../utility/AppText.dart';
import 'AddressMarker.dart';
import 'DetailedAddress.dart';

class AddressView extends GetView<AddressViewController> {
  const AddressView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AddressViewController controller = Get.put(AddressViewController());

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(CupertinoIcons.arrow_left),
              ),
              AppText('Select Delivery Loaction')
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: controller.initialPosition,
                    onMapCreated: (GoogleMapController googleMapController) {
                      controller.mapController.complete(googleMapController);
                    },
                    onCameraMove: controller.onCameraMove,
                    onCameraIdle: controller.onCameraIdle),
                Center(
                  child: CustomMarkerWidget(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 70, top: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search_outlined,size: 20,),
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            hintText: 'Search for a building, Street name, or area',
                            hintStyle: TextStyle(
                              fontSize: 10
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          onChanged: (value) async {
                            if (value.isNotEmpty) {
                              var results = await controller.googlePlace.autocomplete.get(value);
                              if (results != null && results.predictions != null) {
                                controller.updateSearchResults(results.predictions!);
                              }
                            } else {
                              controller.clearSearchResults();
                            }
                          },
                        ),
                      ),
                   
                    ],
                  ),
                )
              ],
            ),
          ),
          //Obx(() => Text(controller.address.value)),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 20),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.location_fill,
                        size: 23,
                        color: AppTheme.blueColor,
                      ),
                      Obx(() {
                        return Text(
                          controller.locality.value,
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        );
                      }),
                      Spacer(),
                      // SizedBox(
                      //   height: 26,
                      //   child: MaterialButton(
                      //     elevation: 0,
                      //     color: Colors.white70,
                      //     shape: RoundedRectangleBorder(
                      //       side: BorderSide(color: Colors.grey.withOpacity(0.4)),
                      //       borderRadius: BorderRadius.circular(6),
                      //     ),
                      //     textColor: Colors.orange,
                      //     onPressed: () {},
                      //     child: Text(
                      //       'CHANGE',
                      //       style: TextStyle(fontSize: 13),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Wrap(
                    spacing: 4.0, // Space between items
                    runSpacing: 4.0, // Space between lines
                    children: [
                      /*Obx(() {
                        return AppText(controller.street.value.isNotEmpty ? controller.street.value : 'Unknown');
                      }),
                      AppText(','),*/
                      Obx(() {
                        return AppText(controller.thoroughfare.value.isNotEmpty ? controller.thoroughfare.value : 'Unknown');
                      }),
                      AppText(','),
                      Obx(() {
                        return AppText(controller.subLocality.value.isNotEmpty ? controller.subLocality.value : 'Unknown');
                      }),
                      AppText(','),
                      Obx(() {
                        return AppText(controller.locality.value.isNotEmpty ? controller.locality.value : 'Unknown');
                      }),
                      AppText(','),
                      Obx(() {
                        return AppText(controller.administrativeArea.value.isNotEmpty ? controller.administrativeArea.value : 'Unknown');
                      }),
                      AppText(','),
                      Obx(() {
                        return AppText(controller.postalCode.value.isNotEmpty ? controller.postalCode.value : 'Unknown');
                      }),
                      AppText(','),
                      Obx(() {
                        return AppText(controller.country.value.isNotEmpty ? controller.country.value : 'Unknown');
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.Buttoncolor, // Background color
                      minimumSize: Size(double.infinity, 50), // Full width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2), // Rounded corners
                      ),
                    ),
                    onPressed: () {
                      Get.to(() => DetailedAddress());
                    },
                    child: Text(
                      "Use This Location",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

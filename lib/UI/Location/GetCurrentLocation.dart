import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:vkartcustomer/Components/Forms.dart';
import '../../Components/AppTheme.dart';
import '../../Controller/MapController.dart';


class MapScreen extends StatelessWidget {
  final MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
floatingActionButton: Padding(
  padding: const EdgeInsets.only(top: 10.0),
  child: Button3(
    widthFactor: 0.3,
                onPressed: (){
                  Get.back(result: "Done");
                  },
                child: Text('Done',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),),
),


//     floatingActionButton: Container(
//       width: 50,
//       height: 50,
//       decoration: BoxDecoration(
//           color: AppTheme.green,
//           borderRadius: BorderRadius.circular(100.0)),
//       child: FloatingActionButton(
//       // clipBehavior: Clip.antiAlias,
//         onPressed: () {  },),
//     ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GestureDetector(
//           onTap: () {
//             Get.back(result: "Done");
//           },
//           child: Container(
//             width: 45,
//             height: 45,
//             child: Icon(
//                     Icons.arrow_back_ios_new,
//                     color: Colors.white,
//               size: 20,// customize color as per requirement
//                   ),
//             decoration: BoxDecoration(
//                 color: AppTheme.Buttoncolor,
//                 borderRadius: BorderRadius.circular(22.5)),
//           ),
//         ),
//       ),
      body: Obx(
            () =>
            GoogleMap(
              onMapCreated: mapController.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: mapController.initialPosition.value,
                zoom: 4,
              ),
              onTap: (value){
                mapController.setMarker(value,context);
              },
              markers: {
                Marker(
                    infoWindow: InfoWindow(title: mapController.address.value),
                    position: mapController.initialPosition.value,
                    draggable: true,
                    markerId: MarkerId('1'),
                    onDragEnd: (value){
                      print(value);
                      mapController.setMarker(value,context);
                    }
                ),
              },
            ),
            // Positioned(
            //
            //   bottom: 50,
            //   left: 50,
            //
            //   child: Button(
            //       onPressed: (){
            //         Get.back();
            //         mapController.userDataProvider.SetSelectedLocation(mapController.address.value);
            //       },
            //       child: Text("Go To".tr,
            //       style:GoogleFonts.poppins(
            //         color: Colors.white,
            //         fontSize: 20,
            //         fontWeight: FontWeight.w400,
            //       ),))
            //
            //
            //   // Container(
            //   //   padding: EdgeInsets.all(8),
            //   //   color: Colors.white,
            //   //   child: Text(mapController.infoWindowText.value),
            //   // ),
            // ),

      ),
    );
  }
}

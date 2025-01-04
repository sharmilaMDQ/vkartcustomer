import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../Components/AppTheme.dart';
import '../../Components/Forms.dart';
import '../../Controller/PaymentDetailsCartController.dart';

class PaymentDetailsCartScreen extends GetView<PaymentDetailsCartController> {
  PaymentDetailsCartScreen({
    Key? key,
  }) : super(key: key);

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    PaymentDetailsCartController Controller = Get.put(PaymentDetailsCartController());

    // String formatAmount(int amount) {
    //   final formatter = NumberFormat('#,##0');
    //   return formatter.format(amount);
    // }
    String formatAmount(String amount) {
      final formatter = NumberFormat('#,##0');
      int parsedAmount = int.tryParse(amount) ?? 0; // Parse the string to int
      return formatter.format(parsedAmount);
    }

    return Scaffold(
      persistentFooterButtons: [
        Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Button(
                  widthFactor: 0.8,
                  heightFactor: 0.06,
                  onPressed: () {
                    // for (int i = 0;
                    // i < controller.onClickList.length;
                    // i++) {
                    //   if (controller.onClickList[i] == true) {
                    //     controller.isClicked.value = true;
                    //     showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         return DefaultTabController(
                    //           length: 2,
                    //           child: AlertDialog(
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(15),
                    //             ),
                    //             content: SingleChildScrollView(
                    //               child: Column(
                    //                 children: [
                    //                   SizedBox(height: 20),
                    //                   Row(
                    //                     mainAxisAlignment:
                    //                     MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       Text(
                    //                         'Cart Total',
                    //                         style: GoogleFonts.poppins(
                    //                           color: Colors.black,
                    //                           fontSize: 18,
                    //                           fontWeight: FontWeight.bold,
                    //                         ),
                    //                       ),
                    //                       Text(
                    //                         controller.UpdateTotalPrice
                    //                             .toString(),
                    //                         style: GoogleFonts.poppins(
                    //                           color: Colors.black,
                    //                           fontSize: 18,
                    //                           fontWeight: FontWeight.w500,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                   SizedBox(height: 15),
                    //                   Row(
                    //                     children: [
                    //                       Text(
                    //                         '9000 Young Street store',
                    //                         style: GoogleFonts.poppins(
                    //                           color: Colors.black87,
                    //                           fontSize: 18,
                    //                           fontWeight: FontWeight.w700,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                   SizedBox(height: 15),
                    //                   Container(
                    //                     height: 400,
                    //                     width: MediaQuery.of(context).size.width,
                    //                     child: SingleChildScrollView(
                    //                       child: Column(
                    //                         children: [
                    //                           SizedBox(
                    //                             height: 45,
                    //                             child: Container(
                    //                               // decoration:
                    //                               // BoxDecoration(
                    //                               //   color: isSelected
                    //                               //       ? AppTheme
                    //                               //       .Buttoncolor
                    //                               //       : AppTheme
                    //                               //       .BorderColor,
                    //                               //   borderRadius:
                    //                               //   BorderRadius
                    //                               //       .circular(
                    //                               //       20),
                    //                               //   border:
                    //                               //   Border.all(
                    //                               //     color: Colors
                    //                               //         .orange,
                    //                               //   ),
                    //                               // ),
                    //                               child: TabBar(
                    //                                 unselectedLabelColor:
                    //                                 Colors.black,
                    //                                 indicatorSize:
                    //                                 TabBarIndicatorSize.tab,
                    //                                 indicator: BoxDecoration(
                    //                                     gradient: LinearGradient(
                    //                                         colors: [
                    //                                           AppTheme.Buttoncolor,
                    //                                           AppTheme.lightGreen
                    //                                         ]),
                    //                                     borderRadius:
                    //                                     BorderRadius.circular(
                    //                                         10),
                    //                                     color: Colors.redAccent),
                    //                                 labelColor: Colors.white,
                    //                                 // unselectedLabelColor:
                    //                                 // Colors
                    //                                 //     .black87,
                    //                                 // indicator:
                    //                                 // BoxDecoration(
                    //                                 //   color: Colors
                    //                                 //       .blue,
                    //                                 //   borderRadius:
                    //                                 //   BorderRadius
                    //                                 //       .circular(
                    //                                 //       5),
                    //                                 // ),
                    //                                 labelStyle: GoogleFonts.poppins(
                    //                                   color: Colors.white,
                    //                                   fontSize: 14,
                    //                                   fontWeight: FontWeight.w400,
                    //                                 ),
                    //                                 tabs: [
                    //                                   Tab(
                    //                                     text: 'Pickup',
                    //                                   ),
                    //                                   Tab(
                    //                                     text: 'Delivery',
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                           ),
                    //                           SizedBox(height: 15),
                    //                           Container(
                    //                             height: 350,
                    //                             child: TabBarView(
                    //                               children: [
                    //                                 Container(
                    //                                   height: 300,
                    //                                   child: SingleChildScrollView(
                    //                                     child: Column(
                    //                                       children: [
                    //                                         // Padding(
                    //                                         //   padding: EdgeInsets.symmetric(
                    //                                         //     horizontal: 10,
                    //                                         //   ),
                    //                                         //   child: TextInput1(
                    //                                         //
                    //                                         //     label: "",
                    //                                         //     onPressed: () {
                    //                                         //       showBottomTimePicker(
                    //                                         //           context, controller.timeOfBirthController);
                    //                                         //     },
                    //                                         //
                    //                                         //     controller: controller.timeOfBirthController,
                    //                                         //     textInputType: TextInputType.number,
                    //                                         //     textColor: Color(0xCC252525),
                    //                                         //     hintText: "Enter Pick up Time",
                    //                                         //     onTextChange: (String) {},
                    //                                         //     sufficIcon: Icon(Icons.access_time,size: 20, color: AppTheme.Buttoncolor,),
                    //                                         //   ),
                    //                                         // ),
                    //
                    //                                         Container(
                    //                                           height: 50,
                    //                                           width: MediaQuery.of(
                    //                                               context)
                    //                                               .size
                    //                                               .width *
                    //                                               0.9,
                    //                                           child: TextFormField(
                    //                                             onTap: () {
                    //                                               showBottomTimePicker(
                    //                                                   context,
                    //                                                   controller
                    //                                                       .pickUptimeController);
                    //                                             },
                    //                                             readOnly: true,
                    //                                             controller: controller
                    //                                                 .pickUptimeController,
                    //                                             decoration:
                    //                                             InputDecoration(
                    //                                                 border:
                    //                                                 OutlineInputBorder(),
                    //                                                 enabledBorder:
                    //                                                 OutlineInputBorder(
                    //                                                   borderSide:
                    //                                                   BorderSide(
                    //                                                       color:
                    //                                                       AppTheme.Buttoncolor),
                    //                                                   borderRadius:
                    //                                                   BorderRadius.circular(
                    //                                                       10),
                    //                                                 ),
                    //                                                 focusedBorder:
                    //                                                 OutlineInputBorder(
                    //                                                   borderSide:
                    //                                                   BorderSide(
                    //                                                       color:
                    //                                                       AppTheme.Buttoncolor),
                    //                                                   borderRadius:
                    //                                                   BorderRadius.circular(
                    //                                                       10),
                    //                                                 ),
                    //                                                 hintText:
                    //                                                 'Choose a pick time',
                    //                                                 hintStyle:
                    //                                                 GoogleFonts
                    //                                                     .poppins(
                    //                                                   color: Colors
                    //                                                       .black,
                    //                                                   fontSize:
                    //                                                   12,
                    //                                                   fontWeight:
                    //                                                   FontWeight
                    //                                                       .w400,
                    //                                                 ),
                    //                                                 suffixIcon:
                    //                                                 Icon(
                    //                                                   Icons
                    //                                                       .access_time,
                    //                                                   size: 20,
                    //                                                   color: AppTheme
                    //                                                       .Buttoncolor,
                    //                                                 )),
                    //                                           ),
                    //                                         ),
                    //                                         SizedBox(
                    //                                           height: 15,
                    //                                         ),
                    //                                         Center(
                    //                                           child: Button(
                    //                                             widthFactor: 0.9,
                    //                                             heightFactor: 0.06,
                    //                                             onPressed: () {
                    //                                               //Get.back();
                    //                                               // PaymentDetails(
                    //                                               //     context);
                    //                                               controller.pickupMethods.value == "PickUp";
                    //                                               controller.GetCartPlaceItemsApi();
                    //                                               // Navigator.push(
                    //                                               //     context,
                    //                                               //     MaterialPageRoute(
                    //                                               //         builder:
                    //                                               //             (context) =>
                    //                                               //                 PaymentDetailScreen()));
                    //                                               //  PaymentDetails();
                    //                                             },
                    //                                             child: Text(
                    //                                               'Checkout',
                    //                                               style: GoogleFonts
                    //                                                   .poppins(
                    //                                                 color:
                    //                                                 Colors.white,
                    //                                                 fontSize: 18,
                    //                                                 fontWeight:
                    //                                                 FontWeight
                    //                                                     .w400,
                    //                                               ),
                    //                                             ),
                    //                                           ),
                    //                                         ),
                    //                                       ],
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                                 Container(
                    //                                   height: 300,
                    //                                   child: SingleChildScrollView(
                    //                                       child: Column(
                    //                                         children: [
                    //                                           Container(
                    //                                             height: 50,
                    //                                             width:
                    //                                             MediaQuery.of(context)
                    //                                                 .size
                    //                                                 .width *
                    //                                                 0.9,
                    //                                             child: TextFormField(
                    //                                               readOnly: true,
                    //                                               controller: controller
                    //                                                   .addressController,
                    //                                               onTap: () async {
                    //                                                 // var result = await Get
                    //                                                 //     .toNamed(AppRoutes
                    //                                                 //         .getcurrentLocationMap
                    //                                                 //         .toName);
                    //                                                 // if (result != null) {
                    //                                                 //   controller
                    //                                                 //           .addressController
                    //                                                 //           .text =
                    //                                                 //       controller
                    //                                                 //           .userDataProvider
                    //                                                 //           .getLocation
                    //                                                 //           .toString();
                    //                                                 // }
                    //                                               },
                    //                                               decoration:
                    //                                               InputDecoration(
                    //                                                   border:
                    //                                                   OutlineInputBorder(),
                    //                                                   enabledBorder:
                    //                                                   OutlineInputBorder(
                    //                                                     borderSide:
                    //                                                     BorderSide(
                    //                                                         color:
                    //                                                         AppTheme.Buttoncolor),
                    //                                                     borderRadius:
                    //                                                     BorderRadius
                    //                                                         .circular(
                    //                                                         10),
                    //                                                   ),
                    //                                                   focusedBorder:
                    //                                                   OutlineInputBorder(
                    //                                                     borderSide:
                    //                                                     BorderSide(
                    //                                                         color:
                    //                                                         AppTheme.Buttoncolor),
                    //                                                     borderRadius:
                    //                                                     BorderRadius
                    //                                                         .circular(
                    //                                                         10),
                    //                                                   ),
                    //                                                   contentPadding:
                    //                                                   EdgeInsets.symmetric(
                    //                                                       vertical:
                    //                                                       10,
                    //                                                       horizontal:
                    //                                                       10),
                    //                                                   hintText:
                    //                                                   'Enter your address',
                    //                                                   hintStyle:
                    //                                                   GoogleFonts
                    //                                                       .poppins(
                    //                                                     color: Colors
                    //                                                         .black,
                    //                                                     fontSize: 10,
                    //                                                     fontWeight:
                    //                                                     FontWeight
                    //                                                         .w400,
                    //                                                   ),
                    //                                                   suffixIcon:
                    //                                                   Icon(
                    //                                                     Icons
                    //                                                         .location_on_outlined,
                    //                                                     size: 20,
                    //                                                     color: AppTheme
                    //                                                         .Buttoncolor,
                    //                                                   )),
                    //                                             ),
                    //                                           ),
                    //                                           SizedBox(height: 15),
                    //                                           Obx(
                    //                                                 () =>
                    //                                                 DropdownButtonFormField<
                    //                                                     String>(
                    //                                                   value: controller
                    //                                                       .selectedCategory
                    //                                                       .value
                    //                                                       .isEmpty
                    //                                                       ? null
                    //                                                       : controller
                    //                                                       .selectedCategory
                    //                                                       .value,
                    //                                                   decoration:
                    //                                                   InputDecoration(
                    //                                                     hintText: controller
                    //                                                         .productCategoryDropdown
                    //                                                         .value,
                    //                                                     contentPadding:
                    //                                                     EdgeInsets
                    //                                                         .symmetric(
                    //                                                         vertical:
                    //                                                         10,
                    //                                                         horizontal:
                    //                                                         10),
                    //                                                     hintStyle: GoogleFonts
                    //                                                         .poppins(
                    //                                                       color:
                    //                                                       Colors.black26,
                    //                                                       fontSize: 12,
                    //                                                       fontWeight:
                    //                                                       FontWeight.w600,
                    //                                                     ),
                    //                                                     border:
                    //                                                     OutlineInputBorder(),
                    //                                                     enabledBorder:
                    //                                                     OutlineInputBorder(
                    //                                                       borderSide: BorderSide(
                    //                                                           color: AppTheme
                    //                                                               .Buttoncolor),
                    //                                                       borderRadius:
                    //                                                       BorderRadius
                    //                                                           .circular(
                    //                                                           10),
                    //                                                     ),
                    //                                                     focusedBorder:
                    //                                                     OutlineInputBorder(
                    //                                                       borderSide: BorderSide(
                    //                                                           color: AppTheme
                    //                                                               .Buttoncolor),
                    //                                                       borderRadius:
                    //                                                       BorderRadius
                    //                                                           .circular(
                    //                                                           10),
                    //                                                     ),
                    //                                                   ),
                    //                                                   items: controller
                    //                                                       .categories
                    //                                                       .map((category) =>
                    //                                                       DropdownMenuItem(
                    //                                                         value:
                    //                                                         category,
                    //                                                         child: Text(
                    //                                                             category),
                    //                                                       ))
                    //                                                       .toList(),
                    //                                                   onChanged: (value) {
                    //                                                     controller
                    //                                                         .selectedCategory
                    //                                                         .value = value ?? '';
                    //                                                     controller
                    //                                                         .productCategoryController
                    //                                                         .text = value ?? '';
                    //                                                   },
                    //                                                 ),
                    //                                           ),
                    //                                           SizedBox(height: 15),
                    //                                           Container(
                    //                                             height: 50,
                    //                                             width:
                    //                                             MediaQuery.of(context)
                    //                                                 .size
                    //                                                 .width *
                    //                                                 0.9,
                    //                                             child: TextFormField(
                    //                                               keyboardType: TextInputType.phone,
                    //                                               controller: controller
                    //                                                   .mobileNumberController,
                    //
                    //                                               decoration:
                    //                                               InputDecoration(
                    //                                                   border:
                    //                                                   OutlineInputBorder(),
                    //                                                   enabledBorder:
                    //                                                   OutlineInputBorder(
                    //                                                     borderSide:
                    //                                                     BorderSide(
                    //                                                         color:
                    //                                                         AppTheme.Buttoncolor),
                    //                                                     borderRadius:
                    //                                                     BorderRadius
                    //                                                         .circular(
                    //                                                         10),
                    //                                                   ),
                    //                                                   focusedBorder:
                    //                                                   OutlineInputBorder(
                    //                                                     borderSide:
                    //                                                     BorderSide(
                    //                                                         color:
                    //                                                         AppTheme.Buttoncolor),
                    //                                                     borderRadius:
                    //                                                     BorderRadius
                    //                                                         .circular(
                    //                                                         10),
                    //                                                   ),
                    //                                                   hintText:
                    //                                                   'Enter Your Mobile Number',
                    //                                                 hintStyle: GoogleFonts
                    //                                                     .poppins(
                    //                                                     color:
                    //                                                     Colors.black26,
                    //                                                     fontSize: 12,
                    //                                                     fontWeight:
                    //                                                     FontWeight.w600,),
                    //                                                   suffixIcon:
                    //                                                   Icon(
                    //                                                     Icons
                    //                                                         .settings_phone,
                    //                                                     size: 20,
                    //                                                     color: AppTheme
                    //                                                         .Buttoncolor,
                    //                                                   )),
                    //                                             ),
                    //                                           ),
                    //                                           SizedBox(
                    //                                             height: 15,
                    //                                           ),
                    //                                           Center(
                    //                                             child: Button(
                    //                                               widthFactor: 0.9,
                    //                                               heightFactor: 0.06,
                    //                                               onPressed: () {
                    //
                    //                                                 controller.pickupMethods.value == "delivery";
                    //                                                 controller.GetCartPlaceItemsApi();
                    //                                                 controller.GetCartApi();
                    //                                                 controller.isClicked.value = false;
                    //                                                 // PaymentDetails(
                    //                                                 //     context);
                    //                                                 // Navigator.push(
                    //                                                 //     context,
                    //                                                 //     MaterialPageRoute(
                    //                                                 //         builder:
                    //                                                 //             (context) =>
                    //                                                 //                 PaymentDetailScreen()));
                    //                                               },
                    //                                               child: controller.isLoading.value
                    //                                                   ? Container(
                    //                                                   height: height * 0.04,
                    //                                                   width: height * 0.04,
                    //                                                   child: const CircularProgressIndicator(
                    //                                                     color: Colors.white,
                    //                                                   ))
                    //                                                   : Text("Checkout".tr,
                    //                                                 style:GoogleFonts.poppins(
                    //                                                   color: Colors.white,
                    //                                                   fontSize: 20,
                    //                                                   fontWeight: FontWeight.w400,
                    //                                                 ),)
                    //                                             ),
                    //                                           ),
                    //                                         ],
                    //                                       )),
                    //                                 )
                    //                               ],
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     );
                    //
                    //   }
                    // }
                    // if (!controller.isClicked.value) {
                    //   Fluttertoast.showToast(
                    //     msg:  'Choose The Product'.tr,
                    //     toastLength: Toast.LENGTH_SHORT,
                    //     gravity: ToastGravity.BOTTOM,
                    //     backgroundColor: Colors.black,
                    //     textColor: Colors.white,
                    //   );
                    // }
                    // else{
                    //   // print("MeetDate${controller.dataList[controller.selectedIndex].startTime}");
                    //   // controller.userDataProvider
                    //   //     .setSelectedMeetingTime(controller.dataList[controller.selectedIndex].startTime);
                    //   // print(controller.userDataProvider.selectedMeetingTime);
                    //   controller.paymentProcess();
                    // } for (int i = 0; i < CartProdct.length; i++) {
                    // Get.to(() => PaymentDetailScreen());
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return DefaultTabController(
                    //       length: 2,
                    //       child: AlertDialog(
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(15),
                    //         ),
                    //         content: SingleChildScrollView(
                    //           child: Column(
                    //             children: [
                    //               SizedBox(height: 20),
                    //               Row(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Text(
                    //                     'Cart Total',
                    //                     style: GoogleFonts.poppins(
                    //                       color: Colors.black,
                    //                       fontSize: 18,
                    //                       fontWeight: FontWeight.bold,
                    //                     ),
                    //                   ),
                    //                   Obx(
                    //                     () => Text(
                    //                       controller.UpdateTotalPrice.value,
                    //                       style: GoogleFonts.poppins(
                    //                         color: Colors.black,
                    //                         fontSize: 18,
                    //                         fontWeight: FontWeight.w500,
                    //                       ),
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //               SizedBox(height: 15),
                    //               Row(
                    //                 children: [
                    //                   Text(
                    //                     '9000 Young Street store',
                    //                     style: GoogleFonts.poppins(
                    //                       color: Colors.black87,
                    //                       fontSize: 18,
                    //                       fontWeight: FontWeight.w700,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               SizedBox(height: 15),
                    //               Container(
                    //                 height: 400,
                    //                 width: MediaQuery.of(context).size.width,
                    //                 child: SingleChildScrollView(
                    //                   child: Column(
                    //                     children: [
                    //                       SizedBox(
                    //                         height: 45,
                    //                         child: Container(
                    //                           // decoration:
                    //                           // BoxDecoration(
                    //                           //   color: isSelected
                    //                           //       ? AppTheme
                    //                           //       .Buttoncolor
                    //                           //       : AppTheme
                    //                           //       .BorderColor,
                    //                           //   borderRadius:
                    //                           //   BorderRadius
                    //                           //       .circular(
                    //                           //       20),
                    //                           //   border:
                    //                           //   Border.all(
                    //                           //     color: Colors
                    //                           //         .orange,
                    //                           //   ),
                    //                           // ),
                    //                           child: TabBar(
                    //                             onTap: (int) {},
                    //                             unselectedLabelColor: Colors.black,
                    //                             indicatorSize: TabBarIndicatorSize.tab,
                    //                             indicator: BoxDecoration(
                    //                                 gradient: LinearGradient(colors: [AppTheme.Buttoncolor, AppTheme.lightGreen]),
                    //                                 borderRadius: BorderRadius.circular(10),
                    //                                 color: Colors.redAccent),
                    //                             labelColor: Colors.white,
                    //                             // unselectedLabelColor:
                    //                             // Colors
                    //                             //     .black87,
                    //                             // indicator:
                    //                             // BoxDecoration(
                    //                             //   color: Colors
                    //                             //       .blue,
                    //                             //   borderRadius:
                    //                             //   BorderRadius
                    //                             //       .circular(
                    //                             //       5),
                    //                             // ),
                    //                             labelStyle: GoogleFonts.poppins(
                    //                               color: Colors.white,
                    //                               fontSize: 14,
                    //                               fontWeight: FontWeight.w400,
                    //                             ),
                    //                             tabs: [
                    //                               Tab(
                    //                                 text: 'Pickup',
                    //                               ),
                    //                               Tab(
                    //                                 text: 'Delivery',
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       SizedBox(height: 15),
                    //                       Container(
                    //                         height: 350,
                    //                         child: TabBarView(
                    //                           children: [
                    //                             Padding(
                    //                               padding: const EdgeInsets.all(8.0),
                    //                               child: Container(
                    //                                 height: 300,
                    //                                 child: SingleChildScrollView(
                    //                                   child: Column(
                    //                                     children: [
                    //                                       // Padding(
                    //                                       //   padding: EdgeInsets.symmetric(
                    //                                       //     horizontal: 10,
                    //                                       //   ),
                    //                                       //   child: TextInput1(
                    //                                       //
                    //                                       //     label: "",
                    //                                       //     onPressed: () {
                    //                                       //       showBottomTimePicker(
                    //                                       //           context, controller.timeOfBirthController);
                    //                                       //     },
                    //                                       //
                    //                                       //     controller: controller.timeOfBirthController,
                    //                                       //     textInputType: TextInputType.number,
                    //                                       //     textColor: Color(0xCC252525),
                    //                                       //     hintText: "Enter Pick up Time",
                    //                                       //     onTextChange: (String) {},
                    //                                       //     sufficIcon: Icon(Icons.access_time,size: 20, color: AppTheme.Buttoncolor,),
                    //                                       //   ),
                    //                                       // ),
                    //                                       Container(
                    //                                         height: 50,
                    //                                         width: MediaQuery.of(context).size.width * 0.9,
                    //                                         child: TextFormField(
                    //                                           onTap: () {
                    //                                             showBottomTimePicker(context, controller.pickUptimeController);
                    //                                           },
                    //                                           readOnly: true,
                    //                                           controller: controller.pickUptimeController,
                    //                                           decoration: InputDecoration(
                    //                                               border: OutlineInputBorder(),
                    //                                               enabledBorder: OutlineInputBorder(
                    //                                                 borderSide: BorderSide(color: AppTheme.Buttoncolor),
                    //                                                 borderRadius: BorderRadius.circular(10),
                    //                                               ),
                    //                                               focusedBorder: OutlineInputBorder(
                    //                                                 borderSide: BorderSide(color: AppTheme.Buttoncolor),
                    //                                                 borderRadius: BorderRadius.circular(10),
                    //                                               ),
                    //                                               hintText: 'Choose a pick time',
                    //                                               hintStyle: GoogleFonts.poppins(
                    //                                                 color: Colors.black26,
                    //                                                 fontSize: 12,
                    //                                                 fontWeight: FontWeight.w600,
                    //                                               ),
                    //                                               suffixIcon: Icon(
                    //                                                 Icons.access_time,
                    //                                                 size: 20,
                    //                                                 color: AppTheme.Buttoncolor,
                    //                                               )),
                    //                                         ),
                    //                                       ),
                    //                                       SizedBox(height: 15),
                    //                                       Obx(
                    //                                         () => DropdownButtonFormField<String>(
                    //                                           value: controller.selectedCategory.value.isEmpty
                    //                                               ? null
                    //                                               : controller.selectedCategory.value,
                    //                                           decoration: InputDecoration(
                    //                                             hintText: controller.productCategoryDropdown.value,
                    //                                             contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    //                                             hintStyle: GoogleFonts.poppins(
                    //                                               color: Colors.black26,
                    //                                               fontSize: 12,
                    //                                               fontWeight: FontWeight.w600,
                    //                                             ),
                    //                                             border: OutlineInputBorder(),
                    //                                             enabledBorder: OutlineInputBorder(
                    //                                               borderSide: BorderSide(color: AppTheme.Buttoncolor),
                    //                                               borderRadius: BorderRadius.circular(10),
                    //                                             ),
                    //                                             focusedBorder: OutlineInputBorder(
                    //                                               borderSide: BorderSide(color: AppTheme.Buttoncolor),
                    //                                               borderRadius: BorderRadius.circular(10),
                    //                                             ),
                    //                                           ),
                    //                                           items: controller.categories
                    //                                               .map((category) => DropdownMenuItem(
                    //                                                     value: category,
                    //                                                     child: Text(category),
                    //                                                   ))
                    //                                               .toList(),
                    //                                           onChanged: (value) {
                    //                                             controller.selectedCategory.value = value ?? '';
                    //                                             controller.productCategoryController.text = value ?? '';
                    //                                           },
                    //                                         ),
                    //                                       ),
                    //                                       SizedBox(
                    //                                         height: 15,
                    //                                       ),
                    //                                       Container(
                    //                                         height: 50,
                    //                                         width: MediaQuery.of(context).size.width * 0.9,
                    //                                         child: TextFormField(
                    //                                           keyboardType: TextInputType.phone,
                    //                                           controller: controller.mobileNumberController,
                    //                                           decoration: InputDecoration(
                    //                                               border: OutlineInputBorder(),
                    //                                               enabledBorder: OutlineInputBorder(
                    //                                                 borderSide: BorderSide(color: AppTheme.Buttoncolor),
                    //                                                 borderRadius: BorderRadius.circular(10),
                    //                                               ),
                    //                                               focusedBorder: OutlineInputBorder(
                    //                                                 borderSide: BorderSide(color: AppTheme.Buttoncolor),
                    //                                                 borderRadius: BorderRadius.circular(10),
                    //                                               ),
                    //                                               hintText: 'Enter Your Mobile Number',
                    //                                               hintStyle: GoogleFonts.poppins(
                    //                                                 color: Colors.black26,
                    //                                                 fontSize: 12,
                    //                                                 fontWeight: FontWeight.w600,
                    //                                               ),
                    //                                               suffixIcon: Icon(
                    //                                                 Icons.settings_phone,
                    //                                                 size: 20,
                    //                                                 color: AppTheme.Buttoncolor,
                    //                                               )),
                    //                                         ),
                    //                                       ),
                    //                                       SizedBox(
                    //                                         height: 15,
                    //                                       ),
                    //                                       Center(
                    //                                         child: Button(
                    //                                           widthFactor: 0.9,
                    //                                           heightFactor: 0.06,
                    //                                           onPressed: () async {
                    //                                             // Set the pickup method
                    //                                             controller.pickupMethods.value =
                    //                                                 "PickUp"; // Ensure you're using the correct method to set the value
                    //                                             AppPreference()
                    //                                                 .updatePicUp("PickUp"); // Save the pickup method preference
                    //
                    //                                             // Call the GetCartPlaceItemsApi and wait for it to complete
                    //                                             await controller.GetCartPlaceItemsApi(context);
                    //
                    //                                             // Delete the cart item only after the previous API call is complete
                    //                                             await controller.DeleteCartApi(); // Ensure this call returns a Future
                    //                                           },
                    //                                           child: Text(
                    //                                             'Checkout',
                    //                                             style: GoogleFonts.poppins(
                    //                                               color: Colors.white,
                    //                                               fontSize: 18,
                    //                                               fontWeight: FontWeight.w400,
                    //                                             ),
                    //                                           ),
                    //                                         ),
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                             Padding(
                    //                               padding: const EdgeInsets.all(8.0),
                    //                               child: Container(
                    //                                 height: 300,
                    //                                 child: SingleChildScrollView(
                    //                                     child: Column(
                    //                                   children: [
                    //                                     Container(
                    //                                       height: 50,
                    //                                       width: MediaQuery.of(context).size.width * 0.9,
                    //                                       child: TextFormField(
                    //                                         readOnly: true,
                    //                                         controller: controller.addressController,
                    //                                         onTap: () async {},
                    //                                         decoration: InputDecoration(
                    //                                             border: OutlineInputBorder(),
                    //                                             enabledBorder: OutlineInputBorder(
                    //                                               borderSide: BorderSide(color: AppTheme.Buttoncolor),
                    //                                               borderRadius: BorderRadius.circular(10),
                    //                                             ),
                    //                                             focusedBorder: OutlineInputBorder(
                    //                                               borderSide: BorderSide(color: AppTheme.Buttoncolor),
                    //                                               borderRadius: BorderRadius.circular(10),
                    //                                             ),
                    //                                             contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    //                                             hintText: 'Enter your address',
                    //                                             hintStyle: GoogleFonts.poppins(
                    //                                               color: Colors.black,
                    //                                               fontSize: 10,
                    //                                               fontWeight: FontWeight.w400,
                    //                                             ),
                    //                                             suffixIcon: Icon(
                    //                                               Icons.location_on_outlined,
                    //                                               size: 20,
                    //                                               color: AppTheme.Buttoncolor,
                    //                                             )),
                    //                                       ),
                    //                                     ),
                    //                                     SizedBox(height: 15),
                    //                                     Obx(
                    //                                       () => DropdownButtonFormField<String>(
                    //                                         value: controller.selectedCategory.value.isEmpty
                    //                                             ? null
                    //                                             : controller.selectedCategory.value,
                    //                                         decoration: InputDecoration(
                    //                                           hintText: controller.productCategoryDropdown.value,
                    //                                           contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    //                                           hintStyle: GoogleFonts.poppins(
                    //                                             color: Colors.black26,
                    //                                             fontSize: 12,
                    //                                             fontWeight: FontWeight.w600,
                    //                                           ),
                    //                                           border: OutlineInputBorder(),
                    //                                           enabledBorder: OutlineInputBorder(
                    //                                             borderSide: BorderSide(color: AppTheme.Buttoncolor),
                    //                                             borderRadius: BorderRadius.circular(10),
                    //                                           ),
                    //                                           focusedBorder: OutlineInputBorder(
                    //                                             borderSide: BorderSide(color: AppTheme.Buttoncolor),
                    //                                             borderRadius: BorderRadius.circular(10),
                    //                                           ),
                    //                                         ),
                    //                                         items: controller.categories
                    //                                             .map((category) => DropdownMenuItem(
                    //                                                   value: category,
                    //                                                   child: Text(category),
                    //                                                 ))
                    //                                             .toList(),
                    //                                         onChanged: (value) {
                    //                                           controller.selectedCategory.value = value ?? '';
                    //                                           controller.productCategoryController.text = value ?? '';
                    //                                         },
                    //                                       ),
                    //                                     ),
                    //                                     SizedBox(height: 15),
                    //                                     Container(
                    //                                       height: 50,
                    //                                       width: MediaQuery.of(context).size.width * 0.9,
                    //                                       child: TextFormField(
                    //                                         keyboardType: TextInputType.phone,
                    //                                         controller: controller.mobileNumberController,
                    //                                         decoration: InputDecoration(
                    //                                             border: OutlineInputBorder(),
                    //                                             enabledBorder: OutlineInputBorder(
                    //                                               borderSide: BorderSide(color: AppTheme.Buttoncolor),
                    //                                               borderRadius: BorderRadius.circular(10),
                    //                                             ),
                    //                                             focusedBorder: OutlineInputBorder(
                    //                                               borderSide: BorderSide(color: AppTheme.Buttoncolor),
                    //                                               borderRadius: BorderRadius.circular(10),
                    //                                             ),
                    //                                             hintText: 'Enter Your Mobile Number',
                    //                                             hintStyle: GoogleFonts.poppins(
                    //                                               color: Colors.black26,
                    //                                               fontSize: 12,
                    //                                               fontWeight: FontWeight.w600,
                    //                                             ),
                    //                                             suffixIcon: Icon(
                    //                                               Icons.settings_phone,
                    //                                               size: 20,
                    //                                               color: AppTheme.Buttoncolor,
                    //                                             )),
                    //                                       ),
                    //                                     ),
                    //                                     SizedBox(
                    //                                       height: 15,
                    //                                     ),
                    //                                     Center(
                    //                                       child: Button(
                    //                                           widthFactor: 0.9,
                    //                                           heightFactor: 0.06,
                    //                                           onPressed: () {
                    //                                             controller.pickupMethods.value == "delivery";
                    //                                             AppPreference().updateDelivery("delivery");
                    //                                             controller.GetCartPlaceItemsApi(context);
                    //                                             controller.DeleteCartApi();
                    //                                             Get.back();
                    //                                           },
                    //                                           child: controller.isLoading.value
                    //                                               ? Container(
                    //                                                   height: height * 0.04,
                    //                                                   width: height * 0.04,
                    //                                                   child: const CircularProgressIndicator(
                    //                                                     color: Colors.white,
                    //                                                   ))
                    //                                               : Text(
                    //                                                   "Checkout".tr,
                    //                                                   style: GoogleFonts.poppins(
                    //                                                     color: Colors.white,
                    //                                                     fontSize: 20,
                    //                                                     fontWeight: FontWeight.w400,
                    //                                                   ),
                    //                                                 )),
                    //                                     ),
                    //                                   ],
                    //                                 )),
                    //                               ),
                    //                             )
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // );
                  },
                  child: Text(
                    "Checkout", //bottomsheet button
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        )
      ],
      appBar: AppBar(
        backgroundColor: AppTheme.Buttoncolor,
        automaticallyImplyLeading: false,
        bottomOpacity: 0.0,
        elevation: 0.0,
        toolbarHeight: 50,
        // leading: Padding(
        //   padding: EdgeInsets.only(top: 20, bottom: 20, right: 0, left: 15),
        //   child: InkWell(
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //     child: Container(
        //       decoration: BoxDecoration(
        //           color: Colors.green.shade700,
        //           borderRadius: BorderRadius.circular(10)),
        //       margin: EdgeInsets.symmetric(
        //         horizontal: 2,
        //       ),
        //       child: Icon(
        //         Icons.arrow_back_ios_new,
        //         color: Colors.white, // customize color as per requirement
        //       ),
        //     ),
        //   ),
        // ),
        leading: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 20, right: 0, left: 15),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            /*child: Container(
                    decoration: BoxDecoration(color: Colors.green.shade700, borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.symmetric(
                      horizontal: 2,
                    ),*/
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white, // customize color as per requirement
            ),
            /*),*/
          ),
        ),
        title: Text("My cart detail",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: height * 0.2,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Order Summary",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("MRP",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                      Text("₹ ${formatAmount("1000")}",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Products Amount",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                      Obx(
                        () => Text("₹ ${formatAmount(controller.UpdateTotalPrice.value)}",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Discount",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                      Text("₹ ${"-100"}",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Discount",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                      Text("₹ ${"-100"}",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                    ],
                  ),
                  Divider(
                    color: Colors.black.withOpacity(0.5),
                    thickness: 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Your Order Total',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                      Text('₹ ${626}',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Customer Pays',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                      Text('₹ ${626}',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

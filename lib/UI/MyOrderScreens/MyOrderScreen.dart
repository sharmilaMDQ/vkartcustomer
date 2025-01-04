import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vkartcustomer/Components/AppTheme.dart';
import 'package:vkartcustomer/Controller/order/order_controller.dart';
import '../../Controller/MyOrderScreenController.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen>with SingleTickerProviderStateMixin {
    late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;
    final controller = Get.put(MyOrderScreenController());

  Map<String, String> extractDiscountAndSubtotal(String? billingDetails) {
    if (billingDetails == null || billingDetails.isEmpty) {
      return {
        "discount": "N/A",
        "subtotal": "N/A"
      }; // Handle null or empty case
    }
    try {
      // Parse the JSON string into a Map
      final Map<String, dynamic> detailsMap = jsonDecode(billingDetails);

      // Extract discount and subtotal
      final discount = detailsMap['discount'] ?? 0.0;
      final subTotal = detailsMap['subtotal'] ?? 0.0;

      // Format and return the values as strings
      return {
        "discount": "₹${discount.toStringAsFixed(2)}",
        "subtotal": "₹${subTotal.toStringAsFixed(2)}"
      };
    } catch (e) {
      return {"discount": "Error", "subtotal": "Error"}; // Handle invalid JSON
    }
  }

  Map<String, String> extractDeliveryDetails(String? deliveryDetails) {
    if (deliveryDetails == null || deliveryDetails.isEmpty) {
      return {"address": "N/A"}; // Handle null or empty case
    }
    try {
      // Parse the JSON string into a Map
      final Map<String, dynamic> detailsMap = jsonDecode(deliveryDetails);

      final address = detailsMap['address'] ?? 0.0;

      // Format and return the values as strings
      return {"address": "${address}"};
    } catch (e) {
      return {
        "address": "Error",
      }; // Handle invalid JSON
    }
  }

  final expectedorderController = Get.find<OrderController>();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
     // Initialize AnimationController and animations
  _animationController = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  );

  // Initialize _fadeInAnimation after AnimationController is initialized
  _fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ),
  );

  _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    ),
  );

  // Start the animation
  _animationController.forward();
  }
  

  @override
  Widget build(BuildContext context) {
        final billingDetails =
        controller.getParticularOrderList?.billingDetails.toString();
    final deliveryDetails =
        controller.getParticularOrderList?.deliveryDetails.toString();
    final billingInfo = extractDiscountAndSubtotal(billingDetails);
    final deliveryInfo = extractDeliveryDetails(deliveryDetails);
    return  Scaffold(
                    appBar: AppBar(
            automaticallyImplyLeading: false,
          backgroundColor: AppTheme.Buttoncolor,
          elevation: 0.0,
          toolbarHeight: 60,
          centerTitle: true,
          title: Text(
            "Order Status",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ScaleTransition(
                  scale: _scaleAnimation,
                child:FadeTransition(
                      opacity: _fadeInAnimation,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Delivery Information
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildRow(
                                        "Order ID",
                                        controller.getParticularOrderList?.orderId
                                                .toString() ??
                                            "",
                                        context: context),
                                    buildRow(
                                        "Amount Payable",
                                        "₹ ${controller.getParticularOrderList?.totalAmount.toString()}" ??
                                            "",
                                        context: context,
                                        valueStyle: TextStyle(
                                          fontSize:
                                              MediaQuery.of(context).size.width *
                                                  0.035,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Text(
                                        (() {
                                          if (controller.getParticularOrderList
                                                  ?.deliveryDetails !=
                                              null) {
                                            try {
                                              // Parse the JSON string
                                              final deliveryDetails = json.decode(
                                                  controller.getParticularOrderList!
                                                      .deliveryDetails
                                                      .toString());
                      
                                              // Extract and parse the expected time
                                              final exceptedString =
                                                  deliveryDetails['excepted'];
                                              if (exceptedString != null) {
                                                final exceptedDate = DateFormat(
                                                        "yyyy-MM-dd hh:mm:ss a")
                                                    .parse(exceptedString);
                      
                                                // Determine if it's tomorrow
                                                final now = DateTime.now();
                                                final tomorrow =
                                                    now.add(Duration(days: 1));
                                                final isTomorrow =
                                                    exceptedDate.year ==
                                                            tomorrow.year &&
                                                        exceptedDate.month ==
                                                            tomorrow.month &&
                                                        exceptedDate.day ==
                                                            tomorrow.day;
                      
                                                // Format the time range (e.g., "6:00 PM - 8:00 PM")
                                                final startTime =
                                                    DateFormat("h:mm a")
                                                        .format(exceptedDate);
                                                final endTime = DateFormat("h:mm a")
                                                    .format(exceptedDate.add(Duration(
                                                        hours:
                                                            2))); // Assuming a 2-hour delivery window
                      
                                                // Construct the final string
                                                return "Delivery ${isTomorrow ? 'Tomorrow' : DateFormat('EEEE').format(exceptedDate)} $startTime - $endTime";
                                              } else {
                                                return 'Delivery Address';
                                              }
                                            } catch (e) {
                                              // Handle parsing errors
                                              return 'Invalid delivery details';
                                            }
                                          }
                                          return 'N/A';
                                        })(),
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              MediaQuery.of(context).size.width *
                                                  0.035,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (() {
                                              if (controller.getParticularOrderList
                                                      ?.deliveryDetails !=
                                                  null) {
                                                try {
                                                  // Parse the JSON string
                                                  final deliveryDetails =
                                                      json.decode(controller
                                                          .getParticularOrderList!
                                                          .deliveryDetails
                                                          .toString());
                                                  // Extract the address
                                                  return deliveryDetails[
                                                          'address'] ??
                                                      'N/A';
                                                } catch (e) {
                                                  // Handle any parsing errors
                                                  return 'Invalid delivery details';
                                                }
                                              }
                                              return 'N/A';
                                            })(),
                                            style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.035,
                                              color: Colors.black54,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                      
                            // Invoice Summary
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "INVOICE SUMMARY",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Divider(thickness: 1, color: Colors.black26),
                                    buildRow(
                                        "Payment Mode",
                                        controller.getParticularOrderList
                                                ?.paymentGateway
                                                .toString() ??
                                            "",
                                        context: context),
                                    buildRow(
                                        "Date",
                                        controller.getParticularOrderList?.createdAt
                                                .toString() ??
                                            "",
                                        context: context),
                                    buildRow(
                                        "Order Status",
                                        controller
                                                .getParticularOrderList?.orderStatus
                                                .toString() ??
                                            "",
                                        context: context,
                                        valueColor: Colors.red),
                                    buildRow(
                                        "Payment Status",
                                        controller.getParticularOrderList
                                                ?.paymentStatus
                                                .toString() ??
                                            "",
                                        context: context,
                                        valueColor: Colors.red),
                                       
                      
                      Column(
                        children: [
                          buildRow(
                            "Discount",
                            (() {
                              try {
                                // Parse billingDetails JSON
                                final billingInfo = json.decode(controller.getParticularOrderList?.billingDetails ?? '{}');
                                return billingInfo['discount']?.toString() ?? "N/A";
                              } catch (e) {
                                // Handle parsing errors
                                return "Invalid data";
                              }
                            })(),
                            context: context,
                          ),
                          buildRow(
                            "Sub Total",
                            (() {
                              try {
                                // Parse billingDetails JSON
                                final billingInfo = json.decode(controller.getParticularOrderList?.billingDetails ?? '{}');
                                return billingInfo['subtotal']?.toString() ?? "N/A";
                              } catch (e) {
                                // Handle parsing errors
                                return "Invalid data";
                              }
                            })(),
                            context: context,
                          ),
                        ],
                      )
                      
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                      
                            // Ordered Items
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ordered Item(s)",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Divider(thickness: 1, color: Colors.black26),
                      
                                    // Dynamically generated rows for products from the API
                                    if (controller.getParticularOrderList
                                                ?.orderedProducts !=
                                            null &&
                                        controller.getParticularOrderList!
                                            .orderedProducts!.isNotEmpty)
                                      ...buildProductRows(
                                        controller
                                            .getParticularOrderList!.orderedProducts
                                            .toString(),context,
                                      )
                                    else
                                      Text(
                                        "No products available",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                        ),
                                      ),
                      
                                    Divider(thickness: 1, color: Colors.black26),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ));
  }

  Widget buildRow(String label, String value,
      {Color valueColor = Colors.black54,
      TextStyle? valueStyle,
      required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.width * 0.035,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: valueStyle ??
                GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: valueColor,
                ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildProductRows(String? orderedProducts,BuildContext context) {
    if (orderedProducts == null || orderedProducts.isEmpty) {
      return [Text("No products available")]; // Handle null or empty case
    }

    try {
      // Decode the JSON string
      final List<dynamic> products = jsonDecode(orderedProducts);

      // Map each product to a buildItemRow widget
      return products.map((product) {
        final productId = product['productId'];
        final productName = product['productName'] ?? "Unknown";
        final unit = product['productQty'] ?? "N/A";
        final qtyPrice = "${product['cartQty']} x ₹${product['price']}";
        final totalPrice =
            "₹${(product['cartQty'] * product['price']).toStringAsFixed(2)}";

        return buildItemRow(productName, unit, qtyPrice, totalPrice,context);
      }).toList();
    } catch (e) {
      return [Text("Error parsing products")]; // Handle invalid JSON
    }
  }

  Widget buildItemRow(
      String itemName, String unit, String qtyPrice, String totalPrice,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  itemName,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  unit,
                  style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                    color: Colors.black54,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  qtyPrice,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  totalPrice,
                  style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  
}

// class MyOrderScreen extends GetView<MyOrderScreenController> {
//   final controller = Get.put(MyOrderScreenController());

//   Map<String, String> extractDiscountAndSubtotal(String? billingDetails) {
//     if (billingDetails == null || billingDetails.isEmpty) {
//       return {
//         "discount": "N/A",
//         "subtotal": "N/A"
//       }; // Handle null or empty case
//     }
//     try {
//       // Parse the JSON string into a Map
//       final Map<String, dynamic> detailsMap = jsonDecode(billingDetails);

//       // Extract discount and subtotal
//       final discount = detailsMap['discount'] ?? 0.0;
//       final subTotal = detailsMap['subtotal'] ?? 0.0;

//       // Format and return the values as strings
//       return {
//         "discount": "₹${discount.toStringAsFixed(2)}",
//         "subtotal": "₹${subTotal.toStringAsFixed(2)}"
//       };
//     } catch (e) {
//       return {"discount": "Error", "subtotal": "Error"}; // Handle invalid JSON
//     }
//   }

//   Map<String, String> extractDeliveryDetails(String? deliveryDetails) {
//     if (deliveryDetails == null || deliveryDetails.isEmpty) {
//       return {"address": "N/A"}; // Handle null or empty case
//     }
//     try {
//       // Parse the JSON string into a Map
//       final Map<String, dynamic> detailsMap = jsonDecode(deliveryDetails);

//       final address = detailsMap['address'] ?? 0.0;

//       // Format and return the values as strings
//       return {"address": "${address}"};
//     } catch (e) {
//       return {
//         "address": "Error",
//       }; // Handle invalid JSON
//     }
//   }

//   final expectedorderController = Get.find<OrderController>();

//   @override
//   Widget build(BuildContext context) {
//     final billingDetails =
//         controller.getParticularOrderList?.billingDetails.toString();
//     final deliveryDetails =
//         controller.getParticularOrderList?.deliveryDetails.toString();
//     final billingInfo = extractDiscountAndSubtotal(billingDetails);
//     final deliveryInfo = extractDeliveryDetails(deliveryDetails);

//     return Scaffold(
//         appBar: AppBar(
//           // backgroundColor: Colors.green.shade700,
//           title: Text(
//             "Order Status",
//             style: GoogleFonts.poppins(
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           centerTitle: true,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         body: Obx(
//           () => controller.isLoading.value
//               ? const Center(child: CircularProgressIndicator())
//               : ListView(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Delivery Information
//                         Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           elevation: 4,
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 buildRow(
//                                     "Order ID",
//                                     controller.getParticularOrderList?.orderId
//                                             .toString() ??
//                                         "",
//                                     context: context),
//                                 buildRow(
//                                     "Amount Payable",
//                                     "₹ ${controller.getParticularOrderList?.totalAmount.toString()}" ??
//                                         "",
//                                     context: context,
//                                     valueStyle: TextStyle(
//                                       fontSize:
//                                           MediaQuery.of(context).size.width *
//                                               0.035,
//                                       fontWeight: FontWeight.bold,
//                                     )),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 3),
//                                   child: Text(
//                                     (() {
//                                       if (controller.getParticularOrderList
//                                               ?.deliveryDetails !=
//                                           null) {
//                                         try {
//                                           // Parse the JSON string
//                                           final deliveryDetails = json.decode(
//                                               controller.getParticularOrderList!
//                                                   .deliveryDetails
//                                                   .toString());
                  
//                                           // Extract and parse the expected time
//                                           final exceptedString =
//                                               deliveryDetails['excepted'];
//                                           if (exceptedString != null) {
//                                             final exceptedDate = DateFormat(
//                                                     "yyyy-MM-dd hh:mm:ss a")
//                                                 .parse(exceptedString);
                  
//                                             // Determine if it's tomorrow
//                                             final now = DateTime.now();
//                                             final tomorrow =
//                                                 now.add(Duration(days: 1));
//                                             final isTomorrow =
//                                                 exceptedDate.year ==
//                                                         tomorrow.year &&
//                                                     exceptedDate.month ==
//                                                         tomorrow.month &&
//                                                     exceptedDate.day ==
//                                                         tomorrow.day;
                  
//                                             // Format the time range (e.g., "6:00 PM - 8:00 PM")
//                                             final startTime =
//                                                 DateFormat("h:mm a")
//                                                     .format(exceptedDate);
//                                             final endTime = DateFormat("h:mm a")
//                                                 .format(exceptedDate.add(Duration(
//                                                     hours:
//                                                         2))); // Assuming a 2-hour delivery window
                  
//                                             // Construct the final string
//                                             return "Delivery ${isTomorrow ? 'Tomorrow' : DateFormat('EEEE').format(exceptedDate)} $startTime - $endTime";
//                                           } else {
//                                             return 'Delivery Address';
//                                           }
//                                         } catch (e) {
//                                           // Handle parsing errors
//                                           return 'Invalid delivery details';
//                                         }
//                                       }
//                                       return 'N/A';
//                                     })(),
//                                     style: GoogleFonts.poppins(
//                                       fontSize:
//                                           MediaQuery.of(context).size.width *
//                                               0.035,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Container(
//                                   width: double.infinity,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         (() {
//                                           if (controller.getParticularOrderList
//                                                   ?.deliveryDetails !=
//                                               null) {
//                                             try {
//                                               // Parse the JSON string
//                                               final deliveryDetails =
//                                                   json.decode(controller
//                                                       .getParticularOrderList!
//                                                       .deliveryDetails
//                                                       .toString());
//                                               // Extract the address
//                                               return deliveryDetails[
//                                                       'address'] ??
//                                                   'N/A';
//                                             } catch (e) {
//                                               // Handle any parsing errors
//                                               return 'Invalid delivery details';
//                                             }
//                                           }
//                                           return 'N/A';
//                                         })(),
//                                         style: GoogleFonts.poppins(
//                                           fontSize: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               0.035,
//                                           color: Colors.black54,
//                                         ),
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 16),
                  
//                         // Invoice Summary
//                         Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           elevation: 4,
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "INVOICE SUMMARY",
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Divider(thickness: 1, color: Colors.black26),
//                                 buildRow(
//                                     "Payment Mode",
//                                     controller.getParticularOrderList
//                                             ?.paymentGateway
//                                             .toString() ??
//                                         "",
//                                     context: context),
//                                 buildRow(
//                                     "Date",
//                                     controller.getParticularOrderList?.createdAt
//                                             .toString() ??
//                                         "",
//                                     context: context),
//                                 buildRow(
//                                     "Order Status",
//                                     controller
//                                             .getParticularOrderList?.orderStatus
//                                             .toString() ??
//                                         "",
//                                     context: context,
//                                     valueColor: Colors.red),
//                                 buildRow(
//                                     "Payment Status",
//                                     controller.getParticularOrderList
//                                             ?.paymentStatus
//                                             .toString() ??
//                                         "",
//                                     context: context,
//                                     valueColor: Colors.red),
                                   
                  
//                   Column(
//                     children: [
//                       buildRow(
//                         "Discount",
//                         (() {
//                           try {
//                             // Parse billingDetails JSON
//                             final billingInfo = json.decode(controller.getParticularOrderList?.billingDetails ?? '{}');
//                             return billingInfo['discount']?.toString() ?? "N/A";
//                           } catch (e) {
//                             // Handle parsing errors
//                             return "Invalid data";
//                           }
//                         })(),
//                         context: context,
//                       ),
//                       buildRow(
//                         "Sub Total",
//                         (() {
//                           try {
//                             // Parse billingDetails JSON
//                             final billingInfo = json.decode(controller.getParticularOrderList?.billingDetails ?? '{}');
//                             return billingInfo['subtotal']?.toString() ?? "N/A";
//                           } catch (e) {
//                             // Handle parsing errors
//                             return "Invalid data";
//                           }
//                         })(),
//                         context: context,
//                       ),
//                     ],
//                   )
                  
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 16),
                  
//                         // Ordered Items
//                         Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           elevation: 4,
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Ordered Item(s)",
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Divider(thickness: 1, color: Colors.black26),
                  
//                                 // Dynamically generated rows for products from the API
//                                 if (controller.getParticularOrderList
//                                             ?.orderedProducts !=
//                                         null &&
//                                     controller.getParticularOrderList!
//                                         .orderedProducts!.isNotEmpty)
//                                   ...buildProductRows(
//                                     controller
//                                         .getParticularOrderList!.orderedProducts
//                                         .toString(),context,
//                                   )
//                                 else
//                                   Text(
//                                     "No products available",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.black54,
//                                     ),
//                                   ),
                  
//                                 Divider(thickness: 1, color: Colors.black26),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//         ));
//   }

//   Widget buildRow(String label, String value,
//       {Color valueColor = Colors.black54,
//       TextStyle? valueStyle,
//       required BuildContext context}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: GoogleFonts.poppins(
//               fontSize: MediaQuery.of(context).size.width * 0.035,
//               fontWeight: FontWeight.w500,
//               color: Colors.black87,
//             ),
//           ),
//           Text(
//             value,
//             style: valueStyle ??
//                 GoogleFonts.poppins(
//                   fontSize: MediaQuery.of(context).size.width * 0.035,
//                   color: valueColor,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }

//   List<Widget> buildProductRows(String? orderedProducts,BuildContext context) {
//     if (orderedProducts == null || orderedProducts.isEmpty) {
//       return [Text("No products available")]; // Handle null or empty case
//     }

//     try {
//       // Decode the JSON string
//       final List<dynamic> products = jsonDecode(orderedProducts);

//       // Map each product to a buildItemRow widget
//       return products.map((product) {
//         final productId = product['productId'];
//         final productName = product['productName'] ?? "Unknown";
//         final unit = product['productQty'] ?? "N/A";
//         final qtyPrice = "${product['cartQty']} x ₹${product['price']}";
//         final totalPrice =
//             "₹${(product['cartQty'] * product['price']).toStringAsFixed(2)}";

//         return buildItemRow(productName, unit, qtyPrice, totalPrice,context);
//       }).toList();
//     } catch (e) {
//       return [Text("Error parsing products")]; // Handle invalid JSON
//     }
//   }

//   Widget buildItemRow(
//       String itemName, String unit, String qtyPrice, String totalPrice,BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 flex: 3,
//                 child: Text(
//                   itemName,
//                   style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Text(
//                   unit,
//                   style: GoogleFonts.poppins(
//                   fontSize: MediaQuery.of(context).size.width * 0.035,
//                     color: Colors.black54,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Text(
//                   qtyPrice,
//                   style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     color: Colors.black54,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Text(
//                   totalPrice,
//                   style: GoogleFonts.poppins(
//                     fontSize: MediaQuery.of(context).size.width * 0.035,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                   textAlign: TextAlign.right,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

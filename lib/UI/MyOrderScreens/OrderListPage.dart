import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Components/AppTheme.dart';
import '../../Controller/OrderListScreenController.dart';
import '../../utility/BottomNavigationBar.dart';
import 'MyOrderScreen.dart';



class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> with SingleTickerProviderStateMixin {

  final controller = Get.put(OrderListScreenController());
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {

    //controller.getParticularSellerApi();
     Future.delayed(Duration(seconds: 1),(){
       setState(() {

       });
     });
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


    return WillPopScope(
      onWillPop: () async {
        Get.to(() => const navigateBar(initialIndex: 1));
        return false;
      },
      child: Scaffold(
        backgroundColor: AppTheme.Buttoncolor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppTheme.Buttoncolor,
          elevation: 0.0,
          toolbarHeight: 60,
          centerTitle: true,
          title: Text(
            "Order List",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: AppTheme.ScreenBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.getOrderList.isEmpty) {
              return Center(
                child: Image.asset(
                  "assets/images/nodata.png",
                  height: 250,
                  width: 250,
                ),
              );
            }

            return ScaleTransition(
                 scale: _scaleAnimation,
              child: FadeTransition(
                 opacity: _fadeInAnimation,
                child: RefreshIndicator(
                  onRefresh: controller.refreshData,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: controller.getOrderList.length,
                    itemBuilder: (context, index) {
                      final order = controller.getOrderList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: InkWell(
                          onTap: () {
                            controller.userDataProvider.setCounterEmpty(controller.getOrderList[index].orderId);
                            Get.to(() => MyOrderScreen());
                          },
                          child: MyOrderListExactComponent(
                            orderId: order.orderId ?? "N/A",
                            amount: order.totalAmount ?? "0",
                            dateTime: order.createdAt ?? "Unknown Date",
                            status: order.orderStatus ?? "Pending",
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}


class MyOrderListExactComponent extends StatelessWidget {
  final dynamic orderId;
  final dynamic amount;
  final dynamic dateTime;
  final dynamic status;

  const MyOrderListExactComponent({
    Key? key,
    required this.orderId,
    required this.amount,
    required this.dateTime,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.2),
        //     blurRadius: 6.0,
        //     offset: Offset(0, 3),
        //   ),
          
        // ],
        border: Border.all(
          color: Colors.grey,
          width: 1
        )
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order ID: # $orderId",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                formatDate(DateTime.parse(dateTime), [MM," ",dd," ",yyyy]),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Divider(color: Colors.grey.shade300, thickness: 1, height: 0),

          // Middle row: Amount and Status
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Amount ₹ $amount",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: status == "Pending" ? Colors.orange.shade700 : Colors.green.shade700,
                    ),
                  ),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                //   decoration: BoxDecoration(
                //     color: status == "Pending" ? Colors.orange.shade100 : Colors.green.shade100,
                //     borderRadius: BorderRadius.circular(4),
                //   ),
                //   child: 
                // ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "View Details",
          //         style: TextStyle(
          //           fontSize: 15,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.black,
          //         ),
          //       ),
          //       // Text(
          //       //     status,
          //       //     style: TextStyle(
          //       //       fontSize: 12,
          //       //       fontWeight: FontWeight.bold,
          //       //       color: status == "Pending" ? Colors.orange.shade700 : Colors.green.shade700,
          //       //     ),
          //       //   ),
          //       // Container(
          //       //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          //       //   decoration: BoxDecoration(
          //       //     color: status == "Pending" ? Colors.orange.shade100 : Colors.green.shade100,
          //       //     borderRadius: BorderRadius.circular(4),
          //       //   ),
          //       //   child: 
          //       // ),
          //     ],
          //   ), 
          // ),
          // Divider
          // Divider(color: Colors.grey.shade300, thickness: 1, height: 0),

          // Padding(
          //   padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       OutlinedButton(
          //         onPressed: () {},
          //         style: OutlinedButton.styleFrom(
          //           side: BorderSide(color: Colors.grey),
          //         ),
          //         child: Text(
          //           "Details",
          //           style: TextStyle(
          //             fontSize: 14,
          //             fontWeight: FontWeight.w500,
          //             color: Colors.black,
          //           ),
          //         ),
          //       ),
          //       ElevatedButton(
          //         onPressed: () {},
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: Colors.green,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(4),
          //           ),
          //         ),
          //         child: Text(
          //           "Track Order",
          //           style: TextStyle(
          //             fontSize: 14,
          //             fontWeight: FontWeight.w500,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

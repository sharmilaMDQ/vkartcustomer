import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vkartcustomer/Controller/CheckOutScreenController.dart';
import 'package:vkartcustomer/Controller/order/order_controller.dart';
import '../../Components/AppTheme.dart';
import '../../Components/CartCommonComponent.dart';
import '../../Components/Forms.dart';
import '../../Controller/CartScreenController.dart';
import '../../Helper/Helper.dart';
import '../../utility/BottomNavigationBar.dart';
import 'checkOutScreen.dart';

/*class CartScreen extends GetView<CartScreenController> {
  String? total = "";

  CartScreen({Key? key, this.total}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // final  billingController = Get.find<CheckOutScreenController>();
  CheckOutScreenController Controller = Get.put(CheckOutScreenController());

  // Format amount with commas
  String formatAmount(String amount) {
    final formatter = NumberFormat('#,##0');
    int parsedAmount = int.tryParse(amount) ?? 0;
    return formatter.format(parsedAmount);
  }

  var pickupvariable;
  var deliveryvariable;
  bool isdeliverymode = false;
  bool ispickupmode = false;
  int ss = 0;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    if (ss == 0) {
      controller.selectedButton.value = 1;
      ss++;
    }

    return WillPopScope(
      onWillPop: () async {
        controller
            .refreshCartData(); // Ensure cart data is refreshed when returning to CartScreen
        Get.off(() => const navigateBar(initialIndex: 1));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: _buildAppBar(controller),
        body: Obx(() {
          if (controller.cartProductLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.CartProdct.isEmpty) {
            return _buildEmptyCartMessage();
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: _buildCartDetails(context, controller, height),
                ),
              ),
              _buildFooter(controller, height),
            ],
          );
        }),
      ),
    );
  }

  AppBar _buildAppBar(CartScreenController controller) {
    return AppBar(
      backgroundColor: AppTheme.Buttoncolor,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      toolbarHeight: 50,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: InkWell(
          onTap: () {
            controller.refreshCartData();
            Get.off(() => navigateBar(initialIndex: 1));
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        "My cart detail",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildEmptyCartMessage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/empty_cartItems.jpg", height: 150),
            const SizedBox(height: 20),
            Text(
              "Oh no! Your cart is feeling a little lonely. Start adding some goodies!",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartDetails(BuildContext context, CartScreenController controller, double height) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              // const SizedBox(height: 30),
              Container(
                height: height * 0.02,
                decoration: const BoxDecoration(color: Colors.white24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   "Delivery in 8 minutes",
                    //   style: GoogleFonts.poppins(
                    //     color: Colors.black,
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 30),
                    //   child: Text(
                    //     "8 items",
                    //     style: GoogleFonts.poppins(
                    //       color: Colors.black,
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w400,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        CartListView(context),
      ],
    );
  }

  Widget _buildFooter(CartScreenController controller, double height) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              _buildPickupButton(controller),
              _buildDeliveryButton(controller),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Obx(() {
                  return controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : Column(
                          children: [
                            controller.selectedButton.value == 2
                                ? Text(
                                    "Total: ₹${_safeParseDouble(total.toString().replaceAll(",", "")) + _safeParseDouble(Controller.getCartInfos.deliveryFee.toString())}",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    "Total: ₹ ${Controller.getCartInfos.total.toString()}",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            if (controller.amountSaved.value != "0.00")
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/tag.svg',
                                    color: AppTheme.Buttoncolor,
                                    width: 18,
                                    height: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Saved: ₹ ${controller.amountSaved.value}",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        );
                }),
              ),
              Expanded(
                child: Center(
                  child: Button(
                    heightFactor: 0.06,
                    onPressed: () {
                      Get.to(() => CheckOutScreen());
                    },
                    child: Obx(
                      () => Text(
                        controller.checkOut.toString(),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPickupButton(CartScreenController controller) {
    return Expanded(
      child: Obx(
        () => TextButton(
          style: TextButton.styleFrom(
            backgroundColor: controller.selectedButton.value == 1
                ? AppTheme.Buttoncolor.withOpacity(0.5)
                : Colors.white,
            side: BorderSide(
              color: controller.selectedButton.value == 1
                  ? AppTheme.Buttoncolor
                  : Colors.grey.withOpacity(0.5),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            controller.selectedButton.value = 1;
            controller.userDataProvider
                .setGetItNow(controller.selectedButton.value);
            ispickupmode = true;
            isdeliverymode = false;
            addNumber();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.electric_bolt_sharp,
                  size: 16, color: Colors.black),
              const SizedBox(width: 8),
              Text(
                "Pick Up",
                style: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryButton(CartScreenController controller) {
    return Expanded(
      child: Obx(
        () => TextButton(
          style: TextButton.styleFrom(
            backgroundColor: controller.selectedButton.value == 2
                ? AppTheme.Buttoncolor.withOpacity(0.5)
                : Colors.white,
            side: BorderSide(
              color: controller.selectedButton.value == 2
                  ? AppTheme.Buttoncolor
                  : Colors.grey.withOpacity(0.5),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            controller.selectedButton.value = 2;
            controller.userDataProvider
                .setGetItNow(controller.selectedButton.value);
            ispickupmode = false;
            isdeliverymode = true;
            addNumber();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.schedule, size: 16, color: Colors.black),
              const SizedBox(width: 8),
              Text(
                "Delivery",
                style: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addNumber() {
    // Safely convert to double with fallback to 0.0
    double a = double.tryParse(controller.total.value.toString()) ?? 0.0;
    double b =
        double.tryParse(Controller.getCartInfos.deliveryFee.toString()) ?? 0.0;
    print('>>>>>>>>.print a ${a}');

    // Perform the calculation
    if (ispickupmode == true) {
      pickupvariable = a + 0;
      print('>>>>>>>>>print pickup ${pickupvariable}');
    } else if (isdeliverymode == true) {
      deliveryvariable = a + b;
      print('>>>>>>>>>>>>delivery ${deliveryvariable}');
    }
    double result = a + b;

    // Update the total in the controller
    controller.total.value = result.toString();

    // Print for debugging
    print("calculation result: $result");

    // Return the result
    return result.toString(); // Optional: Format to 2 decimal places
  }

  Widget CartListView(BuildContext context) {
    return Obx(
      () => controller.CartProdct.isNotEmpty
          ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.CartProdct.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    shadowColor: Colors.grey.withOpacity(0.5),
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        CartCommonComponent(
                          productImage:
                              controller.CartProdct[index].productImage ?? "",
                          productName:
                              controller.CartProdct[index].productName ?? "",
                          productQty:
                              controller.CartProdct[index].productQty ?? "",
                          productPriceChangeable: controller
                              .CartProdct[index].actualPrice
                              .toString(),
                          productPrice: controller
                              .CartProdct[index].productPriceDuplicate
                              .toString(),
                          productDescription: "",
                          productDiscountPrice: controller
                              .CartProdct[index].productDiscountPrice
                              .toString(),
                          discountAvailable:
                              controller.CartProdct[index].discountAvailable,
                          OnPressed: () async {
                            controller.index = index;
                            controller.DeleteCartApi(index, context);
                            controller.update();
                          },
                          decrementCounter: () async {
                            if (!controller.getLoading(index)) {
                              controller.setLoading(index, true);
                              await controller.decrementCounter(
                                  Scaffold.of(context).context, index);
                              controller.setLoading(index, false);
                            }
                          },
                          incrementCounter: () async {
                            if (!controller.getLoading(index)) {
                              controller.setLoading(index, true);
                              await controller.incrementCounter(
                                  Scaffold.of(context).context, index);
                              controller.setLoading(index, false);
                            }
                          },
                          counter: controller.CartProdct[index].cartQty ?? 1,
                          index: index,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  Image.asset("assets/images/nodata.png"),
                  SizedBox(height: 20),
                  Text("Your cart is empty", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
    );
  }

// Helper function to safely parse strings to double
  double _safeParseDouble(String value) {
    try {
      return double.parse(value);
    } catch (e) {
      return 0.0; // Return 0.0 if parsing fails
    }
  }
}*/

class CartScreen extends StatefulWidget {
  String? total = "";
   CartScreen({super.key,this.total});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // final  billingController = Get.find<CheckOutScreenController>();
  CheckOutScreenController Controller = Get.put(CheckOutScreenController());
  CartScreenController controller = Get.put(CartScreenController());
  final orderdateController = Get.find<OrderController>();
     late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (ss == 0) {
      controller.selectedButton.value = 1;
      ss++;
    }
  });
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

  // Format amount with commas
  String formatAmount(String amount) {
    final formatter = NumberFormat('#,##0');
    int parsedAmount = int.tryParse(amount) ?? 0;
    return formatter.format(parsedAmount);
  }

  var pickupvariable;
  var deliveryvariable;
  bool isdeliverymode = false;
  bool ispickupmode = false;
  int ss = 0;


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    WidgetsBinding.instance.addPostFrameCallback((callback) {
  if (ss == 0) {
    controller.selectedButton.value = 1;
    ss++;
  }
});


// WidgetsBinding.instance.addPostFrameCallback((callback){
//      if (ss == 0) {
//        controller.selectedButton.value = 1;
//        // addNumber();
//        ss++;
//      }
//    });

    return WillPopScope(
      onWillPop: () async {
        controller
            .refreshCartData(); // Ensure cart data is refreshed when returning to CartScreen
        Get.off(() => const navigateBar(initialIndex: 1));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: _buildAppBar(controller),
        body: Obx(() {
          if (controller.cartProductLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.CartProdct.isEmpty) {
            return _buildEmptyCartMessage();
          }

          return ScaleTransition(
              scale: _scaleAnimation,
            child: FadeTransition(
                opacity: _fadeInAnimation, 
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: _buildCartDetails(context, controller, height),
                    ),
                  ),
                  _buildFooter(controller, height),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  AppBar _buildAppBar(CartScreenController controller) {
    return AppBar(
      backgroundColor: AppTheme.Buttoncolor,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      toolbarHeight: 50,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: InkWell(
          onTap: () {
            // controller.refreshCartData();
            Get.back();
            // Get.off(() => navigateBar(initialIndex: 1));
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        "My cart detail",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildEmptyCartMessage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/empty_cartItems.jpg", height: 150),
            const SizedBox(height: 20),
            Text(
              "Oh no! Your cart is feeling a little lonely. Start adding some goodies!",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartDetails(BuildContext context, CartScreenController controller, double height) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              // const SizedBox(height: 30),
              Container(
                height: height * 0.02,
                decoration: const BoxDecoration(color: Colors.white24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        CartListView(context),
      ],
    );
  }

  Widget _buildFooter(CartScreenController controller, double height) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPickupButton(controller),
              _buildDeliveryButton(controller),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Obx(() {
                  return controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : Column(
                    children: [
                      controller.selectedButton.value == 2
                          ? Text(
                        "Total: ₹${_safeParseDouble(controller.total.toString().replaceAll(",", "")) + _safeParseDouble(Controller.getCartInfos.deliveryFee.toString())}",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                          : Text(
                        "Total: ₹ ${_safeParseDouble(controller.total.toString().replaceAll(",", ""))}",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (controller.amountSaved.value != "0.00")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/tag.svg',
                              color: AppTheme.Buttoncolor,
                              width: 18,
                              height: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Saved: ₹ ${controller.amountSaved.value}",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ],
                  );
                }),
              ),
              Expanded(
                child: Center(
                  child: Button(
                    heightFactor: 0.06,
                    onPressed: () {

                      Get.to(() => CheckOutScreen());
                    },
                    child: Obx(
                          () => Text(
                        controller.checkOut.toString(),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPickupButton(CartScreenController controller) {
    return Obx(
          () => TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size(155, 40),
          backgroundColor: controller.selectedButton.value == 1
              ? AppTheme.Buttoncolor.withOpacity(0.5)
              : Colors.white,
          side: BorderSide(
            color: controller.selectedButton.value == 1
                ? AppTheme.Buttoncolor
                : Colors.grey.withOpacity(0.5),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          controller.selectedButton.value = 1;
          controller.userDataProvider
              .setGetItNow(controller.selectedButton.value);
          ispickupmode = true;
          isdeliverymode = false;
          setState(() {
            Helper.orderMode = "Pickup";
            //addNumber();
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.electric_bolt_sharp,
                size: 16, color: Colors.black),
            const SizedBox(width: 8),
            Text(
              "Pick Up",
              style: GoogleFonts.poppins(
                  fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryButton(CartScreenController controller) {
    return Obx(
          () => TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size(155, 40),
          backgroundColor: controller.selectedButton.value == 2
              ? AppTheme.Buttoncolor.withOpacity(0.5)
              : Colors.white,
          side: BorderSide(
            color: controller.selectedButton.value == 2
                ? AppTheme.Buttoncolor
                : Colors.grey.withOpacity(0.5),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          controller.selectedButton.value = 2;
          controller.userDataProvider
              .setGetItNow(controller.selectedButton.value);
          ispickupmode = false;
          isdeliverymode = true;
         setState(() {
           Helper.orderMode = "Delivery";
          // addNumber();
         });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.schedule, size: 16, color: Colors.black),
            const SizedBox(width: 8),
            Text(
              "Delivery",
              style: GoogleFonts.poppins(
                  fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  addNumber() {
    // Safely convert to double with fallback to 0.0
    double a = double.tryParse(controller.total.value.toString()) ?? 0.0;
    double b =
        double.tryParse(Controller.getCartInfos.deliveryFee.toString()) ?? 0.0;
    print('>>>>>>>>.print a ${a}');
    print('>>>>>>>>.print b ${b}');

    // Perform the calculation
    if (ispickupmode == true) {
      pickupvariable = a + 0;
      print('>>>>>>>>>print pickup ${pickupvariable}');
    } else if (isdeliverymode == true) {
      deliveryvariable = a + b;
      print('>>>>>>>>>>>>delivery ${deliveryvariable}');
    }
    double result = a + b;

    // Update the total in the controller
    controller.total.value = result.toString();

    // Print for debugging
    setState(() {
      print("calculation result: $result");
    });

    // Return the result
    return result.toString(); // Optional: Format to 2 decimal places
  }

  Widget CartListView(BuildContext context) {
    return Obx(
          () => controller.CartProdct.isNotEmpty
          ? RefreshIndicator(
            
            onRefresh: ()async { 
               controller.refreshData();
             },
            child: ListView.builder(
                    //physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.CartProdct.length,
                    itemBuilder: (context, index) {
            print("cart data -->${controller.CartProdct[index].discountAvailable}");
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                
                shadowColor: Colors.grey.shade50,
                color: Colors.white,
                elevation: 5.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    CartCommonComponent(
                      productImage:
                      controller.CartProdct[index].productImage ?? "",
                      productName:
                      controller.CartProdct[index].productName ?? "",
                      productQty:
                      controller.CartProdct[index].productQty ?? "",
                      productPriceChangeable: controller
                          .CartProdct[index].productPrice
                          .toString(),
                      productPrice: controller
                          .CartProdct[index].productPrice
                          .toString(),
                      productDescription: "",
                      productDiscountPrice: controller
                          .CartProdct[index].productDiscountPrice
                          .toString(),
                      discountAvailable:
                      controller.CartProdct[index].discountAvailable,
            
                      OnPressed: () async {
                        controller.index = index;
                        controller.DeleteCartApi(index, context);
                        controller.update();
                      },
                      decrementCounter: () async {
                        if (!controller.getLoading(index)) {
                          controller.setLoading(index, true);
                          await controller.decrementCounter(
                              Scaffold.of(context).context, index);
                          controller.setLoading(index, false);
                        }
                      },
                      incrementCounter: () async {
                        if (!controller.getLoading(index)) {
                          controller.setLoading(index, true);
                          await controller.incrementCounter(
                              Scaffold.of(context).context, index);
                          controller.setLoading(index, false);
                        }
                      },
                      counter: controller.CartProdct[index].cartQty ?? 1,
                      actualprice: controller.CartProdct[index].actualPrice.toString(),
                      index: index, 
                      discountpersentage: controller.CartProdct[index].discountPercentage.toString(), 
                      category: controller.CartProdct[index].category.toString(),
                    ),
                  ],
                ),
              ),
            );
                    },
                  ),
          )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Image.asset("assets/images/nodata.png"),
            SizedBox(height: 20),
            Text("Your cart is empty", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

// Helper function to safely parse strings to double
  double _safeParseDouble(String value) {
    try {
      return double.parse(value);
    } catch (e) {
      return 0.0; // Return 0.0 if parsing fails
    }
  }
}


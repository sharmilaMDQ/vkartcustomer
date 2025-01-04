import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vkartcustomer/Controller/LoginScreenController.dart';
import 'package:vkartcustomer/Controller/cartItem/cartItem_controller.dart';
import 'package:vkartcustomer/Models/offerslist_model/offers_click_model.dart';
import 'package:vkartcustomer/Provider/ProductProvider.dart';
import 'package:vkartcustomer/utility/AppPreference.dart';
import '../../Components/AppTheme.dart';
import '../../Components/ProductDisplayCommonComponent.dart';
import '../../Controller/CartScreenController.dart';
import '../../Controller/ProductHomeScreenController.dart';
import '../../Helper/Helper.dart';
import '../CartScreen/CartScreen.dart';



class ProductHomeScreen extends StatefulWidget {
  List<OffersClickData>? offerData = [];

  ProductHomeScreen({super.key, this.offerData});

  @override
  State<ProductHomeScreen> createState() => _ProductHomeScreenState();
}

class _ProductHomeScreenState extends State<ProductHomeScreen>  
 with SingleTickerProviderStateMixin{
  final CartScreenController cartcontroller = Get.put(CartScreenController());
  int ss = 0;
  ProductHomeScreenController homeController =
      Get.put(ProductHomeScreenController());
  final appPreference = AppPreference();

  final LoginScreenController loginController =
      Get.find<LoginScreenController>();
  final cartitemController = Get.find<CartitemController>();

  // Scaffold key to control the drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    //print("CART COUNT CALLED");

    cartitemController.getCartCount(customerId: Helper.customerID);

    Future.delayed(Duration(seconds: 2), () {
      setState(() {});
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
    // Get instance of the controller
// Provide the ProductProvider to the controller
    homeController.userDataProvider =
        Provider.of<ProductProvider>(context, listen: false);

    // Call resetCounter at the start
    homeController.resetCounter();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("WIDGET ENTERED");

      if (Helper.customerID != 0) {
        if (ss <= 1) {
          setState(() {});
          ss++;
        }
//update();
      }

      if (!homeController.ishomeCall) {
        homeController.ishomeCall = true;
        homeController.SearchProductApi(); // Uncomment if needed
      }
    });

    return GetBuilder<ProductHomeScreenController>(
      init: ProductHomeScreenController(),
      id: "offer",
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppTheme.Buttoncolor,
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: AppTheme.Buttoncolor,
            automaticallyImplyLeading: false,
            bottomOpacity: 0.0,
            elevation: 0.0,
            toolbarHeight: 80,
            actions: [
              ScaleTransition(
                 scale: _scaleAnimation,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      controller.isSearchVisible.value =
                          !controller.isSearchVisible.value;
                      controller.isSearch.value = !controller.isSearch.value;
                      controller.HomeScreenApi();
                    });
                    // Get.to(navigateBar(initialIndex: 1,));
                  },
                  icon: Icon(
                    Icons.search,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  cartcontroller.GetCartApi().then((data) {
                    Future.delayed(Duration(milliseconds: 500), () {
                      Get.to(() => CartScreen(
                            total: cartcontroller.total.value,
                          ));
                    });
                  });
                },
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 22,
                      color: Colors.white,
                    ),
                    Visibility(
                      visible: int.parse(
                              cartitemController.itemCount.value.toString()) >
                          0,
                      child: Positioned(
                          right: -6,
                          top: -6,
                          child: Obx(() => CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.red,
                                child: Text(
                                  cartitemController.itemCount.value.toString(),
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 10),
                                ),
                              ))),
                    )
                  ],
                ),
              ),
            ],
            leading: ScaleTransition(
              scale: _scaleAnimation,
              child: IconButton(
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                icon: Icon(
                  Icons.sort_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            title: Obx(() {
              return controller.isSearchVisible.value
                  ? FadeTransition(
                    opacity: _fadeInAnimation,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextField(
                                onChanged: (value) {
                                  controller.isSearch.value = true;
                                  controller.SearchProductApi();
                                  //controller.isSearch.value = false;
                                  //controller.searchController.clear();
                                },
                                controller: controller.searchController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hintText: 'Search Grocery',
                                  hintStyle: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  )
                  : FadeTransition(
                    opacity: _fadeInAnimation,
                    child: Row(
                        children: [
                          ValueListenableBuilder<String>(
                            valueListenable: appPreference.customerNameNotifier,
                            builder: (context, customerName, _) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    " ${customerName.isNotEmpty ? customerName : "Guest"}...",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                  );
            }),
          ),
          body: (){
            if(Helper.offerState == false && controller.product.isNotEmpty) {
              return FadeTransition(
                opacity: _fadeInAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: ListView(  
                    children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          controller.refreshData();
                        },
                        child: Container(
                  
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppTheme.ScreenBackground,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25)),
                          ),
                          child: Obx(
                                () => controller.initialLoading.value
                                ? const Center(
                                child: Image(
                                    height: 30,
                                    width: 30,
                                    image: AssetImage(
                                        "assets/images/vkart_10.png"))) // Show loading indicator
                                : controller.product.isNotEmpty
                                ? Column(
                              children: [
                                controller.isSearch.value
                                    ? SearchProductsListWidgets(
                                    context, controller)
                                    : ListView.builder(
                                  key: PageStorageKey(
                                      'scrollableList'),
                                  controller: controller
                                      .scrollController,
                                  shrinkWrap: true,
                                  itemCount:
                                  Helper.offerState == true
                                      ? Helper
                                      .offerData!.length
                                      : controller
                                      .product.length,
                                  itemBuilder:
                                      (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        controller
                                            .userDataProvider
                                            .SetParticularProduct(
                                            controller
                                                .product[
                                            index]);
                                      },
                                      child: Card(
                                        shadowColor:
                                        Colors.grey,
                                        color: Colors.white,
                                        shape:
                                        RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.only(
                                              topLeft: Radius
                                                  .circular(
                                                  25),
                                              topRight: Radius
                                                  .circular(
                                                  25)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceEvenly,
                                          children: [
                                            ProductDisplayCommonComponent(
                                              actualprice: Helper
                                                  .offerState ==
                                                  true
                                                  ? Helper
                                                  .offerData![
                                              index]
                                                  .actualPrice
                                                  : controller
                                                  .product[
                                              index]
                                                  .actualPrice ??
                                                  "0",
                                              productID: Helper
                                                  .offerState ==
                                                  true
                                                  ? Helper
                                                  .offerData![
                                              index]
                                                  .productId
                                                  : controller
                                                  .product[
                                              index]
                                                  .productId ??
                                                  0,
                                              productimage: Helper
                                                  .offerState ==
                                                  true
                                                  ? Helper
                                                  .offerData![
                                              index]
                                                  .productImage
                                                  : controller
                                                  .product[
                                              index]
                                                  .productImage ??
                                                  "",
                                              productname: Helper
                                                  .offerState ==
                                                  true
                                                  ? Helper
                                                  .offerData![
                                              index]
                                                  .productName
                                                  : controller
                                                  .product[
                                              index]
                                                  .productName ??
                                                  "",
                                              productCategory: Helper
                                                  .offerState ==
                                                  true
                                                  ? Helper
                                                  .offerData![
                                              index]
                                                  .productMainCategoryName
                                                  : controller
                                                  .product[
                                              index]
                                                  .productCategory
                                                  .toString() ??
                                                  "",
                                              shopName: Helper
                                                  .offerState ==
                                                  true
                                                  ? Helper
                                                  .offerData![
                                              index]
                                                  .shopName
                                                  : controller
                                                  .product[
                                              index]
                                                  .shopName
                                                  .toString() ??
                                                  "",
                                              productprice: Helper
                                                  .offerState ==
                                                  true
                                                  ? Helper
                                                  .offerData![
                                              index]
                                                  .productPrice
                                                  : controller
                                                  .product[
                                              index]
                                                  .productPrice,
                                              //                                                            productprice: Helper.offerState == true
                                              // ? int.tryParse(Helper.offerData![index].productPrice ?? '') ?? 0
                                              // : controller.productPriceDuplicate[index].value.toInt(),
                  
                                              // Ensure it's a double
                                              productQty: Helper
                                                  .offerState ==
                                                  true
                                                  ? Helper
                                                  .offerData![
                                              index]
                                                  .productQty
                                                  : controller
                                                  .product[
                                              index]
                                                  .productQty ??
                                                  "",
                                              // Handle null values
                                              productDuplicatePrice: Helper
                                                  .offerState ==
                                                  true
                                                  ? Helper
                                                  .offerData![
                                              index]
                                                  .actualPrice
                                                  : controller
                                                  .product[
                                              index]
                                                  .productPrice ??
                                                  0.0,
                                              // Handle null values
                                              productDiscountPrice: Helper
                                                  .offerState ==
                                                  true
                                                  ? Helper
                                                  .offerData![
                                              index]
                                                  .productDiscountPrice
                                                  : controller
                                                  .product[
                                              index]
                                                  .productDiscountPrice
                                                  ?.toString() ??
                                                  "",
                                              // Ensure it's a string or null
                                              discountAvailable: Helper
                                                  .offerState ==
                                                  true
                                                  ? Helper
                                                  .offerData![
                                              index]
                                                  .discountAvailable
                                                  : controller
                                                  .product[
                                              index]
                                                  .discountAvailable ??
                                                  0,
                                              // Ensure it's an int
                                              soldOut: Helper
                                                  .offerState ==
                                                  true
                                                  ? Helper
                                                  .offerData![
                                              index]
                                                  .soldOut
                                                  : controller
                                                  .product[
                                              index]
                                                  .soldOut ??
                                                  "",
                                              offerPercentage: Helper
                                                  .offerState ==
                                                  true
                                                  ? Helper
                                                  .offerData![
                                              index]
                                                  .discountPercentage
                                                  : controller
                                                  .product[
                                              index]
                                                  .discountPercentage
                                                  ?.toString() ??
                                                  "",
                                              // Ensure it's a string or null
                                              index: index,
                                              onTap: () async {
                                                controller
                                                    .index =
                                                    index;
                                              },
                                              decrementCounter:
                                                  () async {
                                                print(
                                                    "boolean check 1 --->${!controller.getLoading(index)}");
                                                if (!controller
                                                    .getLoading(
                                                    index)) {
                                                  print(
                                                      "DECREAMENT INIT");
                                                  controller
                                                      .setLoading(
                                                      index,
                                                      true);
                                                  await controller.decrementCounter(
                                                      Scaffold.of(
                                                          context)
                                                          .context,
                                                      index);
                                                  Future.delayed(
                                                      Duration(
                                                          milliseconds:
                                                          500),
                                                          () {
                                                        setState(
                                                                () {
                                                              controller.setLoading(
                                                                  index,
                                                                  false);
                                                              print(
                                                                  "boolean check 2 --->${!controller.getLoading(index)}");
                                                            });
                                                      });
                                                }
                                              },
                                              incrementCounter:
                                                  () async {
                                                if (!controller
                                                    .getLoading(
                                                    index)) {
                                                  controller
                                                      .setLoading(
                                                      index,
                                                      true);
                                                  await controller.incrementCounter(
                                                      Scaffold.of(
                                                          context)
                                                          .context,
                                                      index);
                                                      Future.delayed(
                                                      Duration(
                                                          milliseconds:
                                                          500),
                                                          () {
                                                        setState(
                                                                () {
                                                              controller.setLoading(
                                                                  index,
                                                                  false);
                                                              print(
                                                                  "boolean check 2 --->${!controller.getLoading(index)}");
                                                            });
                                                      });
                                                  // controller
                                                  //     .setLoading(
                                                  //     index,
                                                  //     false);
                                                }
                                              },
                                              counter: Helper
                                                  .offerState ==
                                                  true
                                                  ? Helper
                                                  .offerData![
                                              index]
                                                  .cartQuantity
                                                  : controller
                                                  .product[
                                              index]
                                                  .cartQuantity ??
                                                  0, // Ensure it's an int
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            )
                                : Center(
                              child: Container(
                                child: Image.asset(
                                  height: 250,
                                  width: 250,
                                  "assets/images/nodata.png",
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );

            }else if(Helper.offerState == false && controller.product.isEmpty){
              return Container(
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/no offers available screen.jpg",width: 200,height: 200,),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Products Are Empty \n Something Went Wrong !",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                      )
                    ]),
              );
            }else if(Helper.offerState == true && Helper.offerData!.isNotEmpty) {
              return ListView(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      controller.refreshData();
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height/1.2,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppTheme.ScreenBackground,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                      ),
                      child: Obx(
                            () => controller.initialLoading.value
                            ? const Center(
                            child: Image(
                                height: 30,
                                width: 30,
                                image: AssetImage(
                                    "assets/images/vkart_10.png"))) // Show loading indicator
                            : controller.product.isNotEmpty
                            ? Column(
                          children: [
                            controller.isSearch.value
                                ? SearchProductsListWidgets(
                                context, controller)
                                : ListView.builder(
                              key: PageStorageKey(
                                  'scrollableList'),
                              controller: controller
                                  .scrollController,
                              shrinkWrap: true,
                              itemCount:
                              Helper.offerState == true
                                  ? Helper
                                  .offerData!.length
                                  : controller
                                  .product.length,
                              itemBuilder:
                                  (context, index) {
                                return InkWell(
                                  onTap: () {
                                    controller
                                        .userDataProvider
                                        .SetParticularProduct(
                                        controller
                                            .product[
                                        index]);
                                  },
                                  child: Card(
                                    shadowColor:
                                    Colors.grey,
                                    color: Colors.white,
                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.only(
                                          topLeft: Radius
                                              .circular(
                                              25),
                                          topRight: Radius
                                              .circular(
                                              25)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        ProductDisplayCommonComponent(
                                          actualprice: Helper
                                              .offerState ==
                                              true
                                              ? Helper
                                              .offerData![
                                          index]
                                              .actualPrice
                                              : controller
                                              .product[
                                          index]
                                              .actualPrice ??
                                              "0",
                                          productID: Helper
                                              .offerState ==
                                              true
                                              ? Helper
                                              .offerData![
                                          index]
                                              .productId
                                              : controller
                                              .product[
                                          index]
                                              .productId ??
                                              0,
                                          productimage: Helper
                                              .offerState ==
                                              true
                                              ? Helper
                                              .offerData![
                                          index]
                                              .productImage
                                              : controller
                                              .product[
                                          index]
                                              .productImage ??
                                              "",
                                          productname: Helper
                                              .offerState ==
                                              true
                                              ? Helper
                                              .offerData![
                                          index]
                                              .productName
                                              : controller
                                              .product[
                                          index]
                                              .productName ??
                                              "",
                                          productCategory: Helper
                                              .offerState ==
                                              true
                                              ? Helper
                                              .offerData![
                                          index]
                                              .productMainCategoryName
                                              : controller
                                              .product[
                                          index]
                                              .productCategory
                                              .toString() ??
                                              "",
                                          shopName: Helper
                                              .offerState ==
                                              true
                                              ? Helper
                                              .offerData![
                                          index]
                                              .shopName
                                              : controller
                                              .product[
                                          index]
                                              .shopName
                                              .toString() ??
                                              "",
                                          productprice: Helper
                                              .offerState ==
                                              true
                                              ? Helper
                                              .offerData![
                                          index]
                                              .productPrice
                                              : controller
                                              .product[
                                          index]
                                              .productPrice,
                                          //                                                            productprice: Helper.offerState == true
                                          // ? int.tryParse(Helper.offerData![index].productPrice ?? '') ?? 0
                                          // : controller.productPriceDuplicate[index].value.toInt(),

                                          // Ensure it's a double
                                          productQty: Helper
                                              .offerState ==
                                              true
                                              ? Helper
                                              .offerData![
                                          index]
                                              .productQty
                                              : controller
                                              .product[
                                          index]
                                              .productQty ??
                                              "",
                                          // Handle null values
                                          productDuplicatePrice: Helper
                                              .offerState ==
                                              true
                                              ? Helper
                                              .offerData![
                                          index]
                                              .actualPrice
                                              : controller
                                              .product[
                                          index]
                                              .productPrice ??
                                              0.0,
                                          // Handle null values
                                          productDiscountPrice: Helper
                                              .offerState ==
                                              true
                                              ? Helper
                                              .offerData![
                                          index]
                                              .productDiscountPrice
                                              : controller
                                              .product[
                                          index]
                                              .productDiscountPrice
                                              ?.toString() ??
                                              "",
                                          // Ensure it's a string or null
                                          discountAvailable: Helper
                                              .offerState ==
                                              true
                                              ? Helper
                                              .offerData![
                                          index]
                                              .discountAvailable
                                              : controller
                                              .product[
                                          index]
                                              .discountAvailable ??
                                              0,
                                          // Ensure it's an int
                                          soldOut: Helper
                                              .offerState ==
                                              true
                                              ? Helper
                                              .offerData![
                                          index]
                                              .soldOut
                                              : controller
                                              .product[
                                          index]
                                              .soldOut ??
                                              "",
                                          offerPercentage: Helper
                                              .offerState ==
                                              true
                                              ? Helper
                                              .offerData![
                                          index]
                                              .discountPercentage
                                              : controller
                                              .product[
                                          index]
                                              .discountPercentage
                                              ?.toString() ??
                                              "",
                                          // Ensure it's a string or null
                                          index: index,
                                          onTap: () async {
                                            controller
                                                .index =
                                                index;
                                          },
                                          decrementCounter:
                                              () async {
                                            print(
                                                "boolean check 1 --->${!controller.getLoading(index)}");
                                            if (!controller
                                                .getLoading(
                                                index)) {
                                              print(
                                                  "DECREAMENT INIT");
                                              controller
                                                  .setLoading(
                                                  index,
                                                  true);
                                              await controller.decrementCounter(
                                                  Scaffold.of(
                                                      context)
                                                      .context,
                                                  index);
                                              Future.delayed(
                                                  Duration(
                                                      milliseconds:
                                                      500),
                                                      () {
                                                    setState(
                                                            () {
                                                          controller.setLoading(
                                                              index,
                                                              false);
                                                          print(
                                                              "boolean check 2 --->${!controller.getLoading(index)}");
                                                        });
                                                  });
                                            }
                                          },
                                          incrementCounter:
                                              () async {
                                            if (!controller
                                                .getLoading(
                                                index)) {
                                              controller
                                                  .setLoading(
                                                  index,
                                                  true);
                                              await controller.incrementCounter(
                                                  Scaffold.of(
                                                      context)
                                                      .context,
                                                  index);
                                              controller
                                                  .setLoading(
                                                  index,
                                                  false);
                                            }
                                          },
                                          counter: Helper
                                              .offerState ==
                                              true
                                              ? Helper
                                              .offerData![
                                          index]
                                              .cartQuantity
                                              : controller
                                              .product[
                                          index]
                                              .cartQuantity ??
                                              0, // Ensure it's an int
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        )
                            : Center(
                          child: Container(
                            child: Image.asset(
                              height: 250,
                              width: 250,
                              "assets/images/nodata.png",
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );

            }else{
              return Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/no offers available screen.jpg",width: 200,height: 200,),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                            "Currently, no offers are available for this product. \n Stay tuned for upcoming deals!",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                      )
                    ]),
              );
            }

              }()


        );
      },
    );
  }

  Widget SearchProductsListWidgets(
      BuildContext context, ProductHomeScreenController hcontroller) {
    final cartitemController = Get.find<CartitemController>();
    ProductHomeScreenController controller =
        Get.put(ProductHomeScreenController());

    // if(search == 0){
    //   setState(() {
    //
    //   });
    //   search++;
    // }

    controller.SearchProductApi();
    return SingleChildScrollView(
      child: Obx(() => Padding(
            padding: const EdgeInsets.all(10.0),
            child: FadeTransition(
              opacity: _fadeInAnimation,
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.searchproduct.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.5,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      final product = controller.searchproduct[index];
                      print("CART QUANTITY ==>${product.cartQuantity}");
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 2,
                                offset: const Offset(0, 0.75),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(8)),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 130,
                                      width: 300,
                                      child: Image.network(
                                        product.productImage ?? '',
                                        // fit: BoxFit.fitHeight,
                                        // height: 120,
                                        fit: BoxFit.fill,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Center(
                                            child: Icon(Icons.error,
                                                size: 40, color: Colors.red),
                                          );
                                        },
                                      ),
                                    ),
                                    if (product.discountAvailable == 1)
                                      Positioned(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/icons/discount.png',
                                              height: 25,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 5),
                                              child: Text(
                                                '${double.parse(product.discountPercentage.toString()).round().toString()} %',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.productName ?? 'Unknown Product',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      controller.product[index].shopName
                                              .toString() ??
                                          'Unknown Shop',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          product.productCategory.toString() ??
                                              'No Category',
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                        Text(
                                          '${product.productQty} ',
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    product.discountAvailable == 1
                                        ? Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '\₹${product.productPrice}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '\₹${product.productDiscountPrice}',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: AppTheme.Buttoncolor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  product.actualPrice!
                                                              .isNotEmpty &&
                                                          product.actualPrice != 0
                                                      ? Text(
                                                          '\₹${product.actualPrice.toString()}',
                                                          style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppTheme
                                                                .Buttoncolor,
                                                          ),
                                                        )
                                                      : Text(''),
                                                ],
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '\₹${product.productPrice}',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: AppTheme.Buttoncolor,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  // Text(
                                                  //   '${product.actualPrice}',
                                                  //   style: const TextStyle(
                                                  //       fontSize: 12,
                                                  //       color: Colors.grey),
                                                  // ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                    SizedBox(
                                      height: 50,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // Ensure that the list has the right index and length
              
                                              product.cartQuantity.toString() !=
                                                          "" &&
                                                      product.cartQuantity! > 0
                                                  ? Row(
                                                      children: [
                                                        // Decrement button
                                                        InkWell(
                                                          onTap: () {
                                                            Helper.productID =
                                                                product
                                                                    .productId!;
                                                            controller
                                                                .decrementCounter(
                                                                    context,
                                                                    index);
                                                            cartitemController
                                                                .itemCount
                                                                .value--;
                                                            cartitemController
                                                                .update();
              
                                                            Future.delayed(
                                                                Duration(
                                                                    milliseconds:
                                                                        200), () {
                                                              setState(() {
                                                                controller
                                                                    .SearchProductApi();
                                                              });
                                                            });
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(5),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              color: controller
                                                                              .counter
                                                                              .length >
                                                                          index &&
                                                                      controller
                                                                              .counter[
                                                                                  index]
                                                                              .value >
                                                                          0
                                                                  ? Colors.red
                                                                  : AppTheme
                                                                      .IconBackground,
                                                            ),
                                                            child: Icon(
                                                              CupertinoIcons
                                                                  .minus,
                                                              color: controller
                                                                              .counter
                                                                              .length >
                                                                          index &&
                                                                      controller
                                                                              .counter[
                                                                                  index]
                                                                              .value >
                                                                          0
                                                                  ? Colors.white
                                                                  : AppTheme
                                                                      .Buttoncolor,
                                                              size: 15,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        // Counter value
                                                        Text(
                                                          product.cartQuantity
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        // Increment button
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() async {
                                                              Helper.productID =
                                                                  product
                                                                      .productId!;
                                                              await controller
                                                                  .incrementCounter(
                                                                      context,
                                                                      index);
                                                              cartitemController
                                                                  .itemCount
                                                                  .value++;
                                                              cartitemController
                                                                  .update();
              
                                                              Future.delayed(
                                                                  Duration(
                                                                      milliseconds:
                                                                          200),
                                                                  () {
                                                                setState(() {
                                                                  controller
                                                                      .SearchProductApi();
                                                                });
                                                              });
                                                            });
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(5),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              color: AppTheme
                                                                  .Buttoncolor,
                                                            ),
                                                            child: Icon(
                                                              Icons.add,
                                                              color: Colors.white,
                                                              size: 15,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        Helper.productID =
                                                            product.productId!;
                                                        controller
                                                            .incrementCounter(
                                                                context, index);
                                                        cartitemController
                                                            .itemCount.value++;
                                                        cartitemController
                                                            .update();
                                                        Future.delayed(
                                                            Duration(
                                                                milliseconds:
                                                                    200), () {
                                                          setState(() {
                                                            controller
                                                                .SearchProductApi();
                                                          });
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 33,
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                vertical: 9,
                                                                horizontal: 20),
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: AppTheme
                                                              .Buttoncolor,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            'Add',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}


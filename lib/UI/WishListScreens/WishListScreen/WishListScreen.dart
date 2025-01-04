import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vkartcustomer/Provider/ProductProvider.dart';

import '../../../Components/AppTheme.dart';
import '../../../Components/wishlistScreenComponent.dart';
import '../../../Controller/WishListScreenController.dart';
import '../../../Pageroutes/App_routes.dart';

class WishListScreen extends GetView<WishListScreenController> {
  WishListScreen({Key? key}) : super(key: key);

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    WishListScreenController homeController = Get.put(WishListScreenController());

    controller.userDataProvider = Provider.of<ProductProvider>(context, listen: false);

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (!controller.ishomeCall) {
        controller.ishomeCall == true;
        controller.wishListApi();
        // controller.SearchProductApi();
      }
    });

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
          // IconButton(
          //     onPressed: () {
          //       controller.isSearchVisible.value =
          //       !controller.isSearchVisible.value;
          //       controller.isSearch.value = !controller.isSearch.value;
          //       controller.HomeScreenApi();
          //     },
          //     icon: Icon(
          //       Icons.search,
          //       size: 18,
          //       color: Colors.black,
          //     ))
        ],
        title: Text(
          "Favarouite Products",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        // leading: IconButton(
        //   onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        //   icon: Icon(
        //     Icons.sort_outlined,
        //   ),
        // ),
        // title: Obx(() => controller.isSearchVisible.value
        //     ? Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     // Visibility(
        //     //   visible: controller.isSearch.value,
        //     //   child: InkWell(
        //     //     onTap: () {
        //     //       controller.isSearch.value = false;
        //     //       controller.initialLoading.value = true;
        //     //       controller.initialLoading.value = false;
        //     //       controller.searchController.clear();
        //     //     },
        //     //     child: Icon(Icons.arrow_back),
        //     //   ),
        //     // ),
        //     // SizedBox(width: MediaQuery
        //     //     .of(context)
        //     //     .size
        //     //     .width * 0.04),
        //     Expanded(
        //       child: Container(
        //         //color: Colors.white,
        //         child: TextField(
        //           onChanged: (value) {
        //             controller.isSearch.value = true;
        //             controller.SearchProductApi();
        //           },
        //           controller: controller.searchController,
        //           decoration: InputDecoration(
        //             contentPadding:
        //             EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        //             border: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(5),
        //             ),
        //             focusedBorder: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(5),
        //               borderSide: BorderSide(color: Colors.black),
        //             ),
        //             hintText: 'Search Grocery',
        //             hintStyle: GoogleFonts.poppins(
        //               color: Colors.black,
        //               fontSize: 12,
        //               fontWeight: FontWeight.w400,
        //             ),
        //             prefixIcon: Icon(
        //               Icons.search,
        //               size: 18,
        //               color: Colors.black,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // )
        //     : Row(
        //   children: [
        //     Obx(
        //           () => Text(
        //         " Welcome  ${controller.customerName.toString()}",
        //         style: GoogleFonts.poppins(
        //           color: Colors.black,
        //           fontSize: 15,
        //           fontWeight: FontWeight.w600,
        //         ),
        //       ),
        //     ),
        //     SizedBox(
        //       width: 10,
        //     ),
        //
        //     // Expanded(
        //     //   child: Text(
        //     //     controller.customerName.toString(),
        //     //     style: GoogleFonts.poppins(
        //     //       color: Colors.black,
        //     //       fontSize: 15,
        //     //       fontWeight: FontWeight.w600,
        //     //     ),
        //     //   ),
        //     // )
        //   ],
        // )),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: AppTheme.ScreenBackground, borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Obx(
          () => controller.initialLoading.value
              ? Center(child: CircularProgressIndicator())
              : controller.wishListProducts.isNotEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        controller.isSearch.value == true ? SearchProductsListWidgets(context) : ProductsListWidgets(context),
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
      drawer: Padding(
        padding: EdgeInsets.only(top: 80, bottom: 20, left: 20, right: 140),
        child: Drawer(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: AppTheme.Buttoncolor,
          elevation: 5,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('Food', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                        InkWell(
                          onTap: () {
                            homeController.toggleVisibility();
                          },
                          child: Obx(
                            () => homeController.arrowIsVisible.value
                                ? Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 30)
                                : Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30),
                          ),
                        )
                      ],
                    ),
                    Obx(
                      () => Visibility(
                          visible: homeController.isVisible.value,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text('Deli', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 130),
                                        child: AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          actions: [
                                            Container(
                                              height: MediaQuery.of(context).size.height * 0.6,
                                              width: MediaQuery.of(context).size.width,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                            child: Stack(
                                                          children: <Widget>[
                                                            ClipRRect(
                                                              borderRadius: BorderRadius.circular(4.0),
                                                              child: Image.asset(
                                                                'assets/images/Carrot.png',
                                                                fit: BoxFit.cover,
                                                                height: 50,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "    Carrot",
                                                                  style: TextStyle(color: Colors.black26, fontWeight: FontWeight.w400, fontSize: 16),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '    \$110.0',
                                                                  style: TextStyle(
                                                                      color: AppTheme.Buttoncolor, fontWeight: FontWeight.w400, fontSize: 16),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                            child: Stack(
                                                          children: <Widget>[
                                                            ClipRRect(
                                                              borderRadius: BorderRadius.circular(4.0),
                                                              child: Image.asset(
                                                                'assets/images/strawberry1.png',
                                                                fit: BoxFit.cover,
                                                                height: 50,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "       Strawberry",
                                                                  style: TextStyle(color: Colors.black26, fontWeight: FontWeight.w400, fontSize: 16),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '\$125.0',
                                                                  style: TextStyle(
                                                                      color: AppTheme.Buttoncolor, fontWeight: FontWeight.w400, fontSize: 16),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                            child: Stack(
                                                          children: <Widget>[
                                                            ClipRRect(
                                                              borderRadius: BorderRadius.circular(4.0),
                                                              child: Image.asset(
                                                                'assets/images/Bananas.png',
                                                                fit: BoxFit.cover,
                                                                height: 35,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Bananas",
                                                                  style: TextStyle(color: Colors.black26, fontWeight: FontWeight.w400, fontSize: 12),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '\$10.0',
                                                                  style: TextStyle(
                                                                      color: AppTheme.Buttoncolor, fontWeight: FontWeight.w400, fontSize: 16),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10),
                                                          child: Container(
                                                              child: Stack(
                                                            children: <Widget>[
                                                              ClipRRect(
                                                                borderRadius: BorderRadius.circular(4.0),
                                                                child: Image.asset(
                                                                  'assets/images/Pinapple.png',
                                                                  fit: BoxFit.cover,
                                                                  height: 50,
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 0),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "       Pineapple",
                                                                    style:
                                                                        TextStyle(color: Colors.black26, fontWeight: FontWeight.w400, fontSize: 16),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '\$12.0',
                                                                    style: TextStyle(
                                                                        color: AppTheme.Buttoncolor, fontWeight: FontWeight.w400, fontSize: 16),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                                          child: Container(
                                                              child: Stack(
                                                            children: <Widget>[
                                                              ClipRRect(
                                                                borderRadius: BorderRadius.circular(4.0),
                                                                child: Image.asset(
                                                                  'assets/images/Cabbage.png',
                                                                  fit: BoxFit.cover,
                                                                  height: 40,
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                        ),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "    Cabbage",
                                                                  style: TextStyle(color: Colors.black26, fontWeight: FontWeight.w400, fontSize: 16),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '\$5.60',
                                                                  style: TextStyle(
                                                                      color: AppTheme.Buttoncolor, fontWeight: FontWeight.w400, fontSize: 16),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                                          child: Container(
                                                              child: Stack(
                                                            children: <Widget>[
                                                              ClipRRect(
                                                                borderRadius: BorderRadius.circular(4.0),
                                                                child: Image.asset(
                                                                  'assets/images/Egg.png',
                                                                  fit: BoxFit.cover,
                                                                  height: 50,
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                        ),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Egg",
                                                                  style: TextStyle(color: Colors.black26, fontWeight: FontWeight.w400, fontSize: 16),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '     \$10.00',
                                                                  style: TextStyle(
                                                                      color: AppTheme.Buttoncolor, fontWeight: FontWeight.w400, fontSize: 16),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                'Vegetable',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text(
                              'Fruit ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text(
                              'Frozen',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text(
                              'Drink & beverage',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Spicyice',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                          ])),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('Baby', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                        InkWell(
                            onTap: () {
                              homeController.toggleVisibility1();
                            },
                            child: Obx(
                              () => homeController.arrowIsVisible1.value
                                  ? Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 30)
                                  : Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30),
                            ))
                      ],
                    ),
                    Obx(
                      () => Visibility(
                          visible: homeController.isVisible1.value,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text('Deli', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Vegetable', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Fruit ', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Frozen', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Drink & beverage', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Spicyice', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                          ])),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('Health&beauty', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                        InkWell(
                            onTap: () {
                              homeController.toggleVisibility2();
                            },
                            child: Obx(
                              () => homeController.arrowIsVisible2.value
                                  ? Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 30)
                                  : Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30),
                            ))
                      ],
                    ),
                    Obx(
                      () => Visibility(
                          visible: homeController.isVisible2.value,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Deli', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Vegetable', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Fruit ', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Frozen', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Drink & beverage', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Spicyice', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                          ])),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('Pet supplies', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                        InkWell(
                            onTap: () {
                              homeController.toggleVisibility3();
                            },
                            child: Obx(
                              () => homeController.arrowIsVisible3.value
                                  ? Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 30)
                                  : Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30),
                            ))
                      ],
                    ),
                    Obx(
                      () => Visibility(
                          visible: homeController.isVisible3.value,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Deli', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Vegetable', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Fruit ', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Frozen', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Drink & beverage', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Spicyice', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 5,
                            ),
                          ])),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('Pet supplies', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                        InkWell(
                            onTap: () {
                              homeController.toggleVisibility4();
                            },
                            child: Obx(
                              () => homeController.arrowIsVisible4.value
                                  ? Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 30)
                                  : Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30),
                            ))
                      ],
                    ),
                    Obx(
                      () => Visibility(
                          visible: homeController.isVisible4.value,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Deli', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Vegetable', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Fruit ', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Frozen', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Drink & beverage', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Spicyice', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                          ])),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('Bathroom', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                        InkWell(
                            onTap: () {
                              homeController.toggleVisibility5();
                            },
                            child: Obx(
                              () => homeController.arrowIsVisible5.value
                                  ? Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 30)
                                  : Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30),
                            ))
                      ],
                    ),
                    Obx(
                      () => Visibility(
                          visible: homeController.isVisible5.value,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text('Deli', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Vegetable', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Fruit ', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Frozen', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Drink & beverage', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text('Spicyice', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 5,
                            ),
                          ])),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget ProductsListWidgets(BuildContext context) {
  //   return Expanded(
  //     child: SingleChildScrollView(
  //         scrollDirection: Axis.vertical,
  //         child: Obx(() => Padding(
  //             padding: const EdgeInsets.symmetric(),
  //             child: Column(
  //               children: [
  //                 Container(
  //                   padding: EdgeInsets.symmetric(
  //                     horizontal: 10,
  //                     vertical: 10,
  //                   ),
  //                   child: GridView.count(
  //                     physics: ScrollPhysics(),
  //                     crossAxisCount: 2,
  //                     childAspectRatio: 0.63,
  //                     crossAxisSpacing: 8,
  //                     mainAxisSpacing: 5,
  //                     shrinkWrap: true,
  //                     children: List.generate(
  //                       controller.product.length,
  //                       (index) {
  //                         return InkWell(
  //                           onTap: () {
  //                             controller.userDataProvider.SetProduct(controller.product[index]);
  //                             Get.toNamed(AppRoutes.producthomescreen.toName);
  //                           },
  //                           child: Card(
  //                             shadowColor: Colors.grey,
  //                             color: Colors.white,
  //                             //surfaceTintColor: Colors.grey,
  //                             elevation: 5,
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(20),
  //                             ),
  //                             child: Container(
  //                               padding: EdgeInsets.only(right: 10, left: 10),
  //                               child: Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                                 children: [
  //                                   // Stack(
  //                                   //   children: [
  //                                   //     Positioned(
  //                                   //
  //                                   //       child: Align(
  //                                   //         alignment: Alignment.topRight,
  //                                   //         child: Obx(() => InkWell(
  //                                   //             onTap: () {
  //                                   //               controller
  //                                   //                       .onClickList[index] =
  //                                   //                   !controller
  //                                   //                       .onClickList[index];
  //                                   //             },
  //                                   //             child: controller
  //                                   //                     .onClickList[index]
  //                                   //                 ? Icon(
  //                                   //                     Icons.favorite,
  //                                   //                     size: 25,
  //                                   //                     color: Colors.redAccent,
  //                                   //                   )
  //                                   //                 : Icon(
  //                                   //                     Icons.favorite_border,
  //                                   //                     size: 25,
  //                                   //                     color: Colors.redAccent,
  //                                   //                   ))),
  //                                   //       ),
  //                                   //     ),
  //                                   //
  //                                   //   ],
  //                                   // ),
  //                                   ProductDisplayCommonComponent(
  //                                     productimage: controller.product[index].productImage ?? "",
  //                                     productname: controller.product[index].productName ?? "",
  //                                     productCategory: controller.product[index].productCategory.toString() ?? "",
  //                                     shopName: controller.product[index].shopName.toString() ?? "",
  //                                     productprice: controller.product[index].productPrice ?? "",
  //                                     productQty: controller.product[index].productQty ?? "",
  //                                     onTap: () {
  //                                       controller.userDataProvider.SetProduct(controller.product[index]);
  //                                       if (controller.product[index].wishList == true) {
  //                                         controller.deleteWishListApi();
  //                                       } else {
  //                                         controller.AddWishListApi();
  //                                       }
  //                                       //controller.HomeScreenApi();
  //                                     },
  //                                     isFavaurite: controller.product[index].wishList == true,
  //                                     productDiscountPrice: '',
  //                                     discountAvailable: 0,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             )))),
  //   );
  // }

  Widget ProductsListWidgets(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : controller.wishListProducts!.value.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.wishListProducts.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.userDataProvider.SetWishListProduct(controller.wishListProducts[index]);
                          Get.toNamed(AppRoutes.producthomescreen.toName);
                        },
                        child: Card(
                          shadowColor: Colors.grey,
                          color: Colors.white,
                          //surfaceTintColor: Colors.grey,
                          // elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              WishlistScreenCommonComponent(
                                productimage: controller.wishListProducts[index].productImage ?? "",
                                productname: controller.wishListProducts[index].productName ?? "",
                                productCategory: controller.wishListProducts[index].productCategory.toString() ?? "",
                                productprice: controller.wishListProducts[index].productPrice ?? "",
                                productQty: controller.wishListProducts[index].productQty ?? "",
                                productDiscountPrice: controller.wishListProducts[index].productDiscountPrice ?? "",
                                // isFavaurite: controller.product[index].wishList == true,
                                // productDuplicatePrice: controller.product[index].productPrice ?? "",
                                // shopName: controller.wishListProducts[index].shopName.toString() ?? "",
                                onTap: () {
                                  // controller.index = index;
                                  // controller.userDataProvider.SetProduct(controller.product[index]);
                                  controller.userDataProvider.SetWishListProduct(controller.wishListProducts[index]);
                                  print("gvjg${controller.wishListProducts[index]}");
                                  //   if (controller.product[index].wishList == true) {
                                  //     controller.deleteWishListApi();
                                  //   } else {
                                  //     controller.AddWishListApi();
                                  //   }
                                  //   //controller.HomeScreenApi();
                                  // },
                                  // decrementCounter: () {
                                  //   controller.decrementCounter(index);
                                  //   // controller
                                  //   //     .onClickCounterList[
                                  //   // index];
                                  // },
                                  // incrementCounter: () {
                                  //   controller.incrementCounter(index);
                                  //   // controller
                                  //   //     .onClickCounterList[
                                  //   // index];
                                  // },
                                  // counter: controller.counter[index].value,
                                  // productDiscountPrice: controller.product[index].productDiscountPrice.toString(),
                                  // discountAvailable: controller.product[index].discountAvailable,
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 100),
                        Image.asset("assets/images/nodata.png"),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget SearchProductsListWidgets(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Obx(() => Padding(
                padding: const EdgeInsets.symmetric(),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      //color: Colors.blue,
                      child: GridView.count(
                        physics: ScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 5,
                        shrinkWrap: true,
                        children: List.generate(
                          controller.searchproduct.length,
                          (index) {
                            return InkWell(
                              onTap: () {
                                // controller.userDataProvider
                                //     .SetProduct(controller
                                //     .searchproduct[index]);
                                Get.toNamed(AppRoutes.producthomescreen.toName);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  padding: EdgeInsets.only(right: 10, left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      WishlistScreenCommonComponent(
                                        productimage: controller.searchproduct[index].productImage ?? "",
                                        productname: controller.searchproduct[index].productName ?? "",
                                        shopName: controller.product[index].shopName.toString() ?? "",
                                        productCategory: controller.searchproduct[index].productCategory.toString() ?? "",
                                        productprice: controller.searchproduct[index].productPrice ?? "",
                                        productQty: controller.searchproduct[index].productQty ?? "",
                                        onTap: () {
                                          controller.onClickList[index] = !controller.onClickList[index];
                                        },
                                        // isFavaurite: controller.product[index].wishList == true,
                                        productDiscountPrice: '',
                                        discountAvailable: 0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )))));
  }
}

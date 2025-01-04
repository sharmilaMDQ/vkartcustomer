import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vkartcustomer/Provider/ProductProvider.dart';
import '../../Components/AppTheme.dart';
import '../../Components/ProductDisplayCommonComponent.dart';
import '../../Controller/ProductHomeScreenController.dart';
import '../../Pageroutes/App_routes.dart';

class OfferDetailScreen extends GetView<ProductHomeScreenController> {
  OfferDetailScreen({Key? key}) : super(key: key);

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    ProductHomeScreenController homeController = Get.put(ProductHomeScreenController());
    controller.userDataProvider = Provider.of<ProductProvider>(context, listen: false);

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (!controller.ishomeCall) {
        controller.ishomeCall = true;
        // controller.HomeScreenApi();
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
        leading: Padding(
          padding: EdgeInsets.only(
            top: 20, bottom: 20, right: 0, left: 15),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green.shade700, 
                borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(
                horizontal: 2,
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white, // customize color as per requirement
              ),
            ),
          ),
        ),
        title: Text(
          "offer Details",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[],
      ),
      // appBar: AppBar(
      //   backgroundColor: AppTheme.Buttoncolor,
      //   automaticallyImplyLeading: false,
      //   bottomOpacity: 0.0,
      //   elevation: 0.0,
      //   toolbarHeight: 80,
      //
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           controller.isSearchVisible.value =
      //           !controller.isSearchVisible.value;
      //           controller.isSearch.value = !controller.isSearch.value;
      //         },
      //         icon: Icon(
      //           Icons.search,
      //           size: 18,
      //           color: Colors.black,
      //         ))
      //   ],
      //   // bottom: PreferredSize(
      //   //   preferredSize: Size.fromHeight(20.0),
      //   //   child: Padding(
      //   //     padding: const EdgeInsets.only(left: 0),
      //   //     child: Row(
      //   //       mainAxisAlignment: MainAxisAlignment.center,
      //   //       children: [
      //   //         Obx(() => Visibility(
      //   //             visible: controller.isSearch.value,
      //   //             child: InkWell(
      //   //                 onTap: () {
      //   //                   controller.isSearch.value = false;
      //   //                   controller.initialLoading.value = true;
      //   //                   controller.initialLoading.value = false;
      //   //                   controller.searchController.clear();
      //   //                 },
      //   //                 child: Icon(Icons.arrow_back)))),
      //   //         SizedBox(width: MediaQuery.of(context).size.width * 0.04),
      //   //         Obx(() => Visibility(
      //   //           visible: controller.isSearchVisible.value,
      //   //           child: Container(
      //   //             color: Colors.black,
      //   //             width: controller.isSearch.value
      //   //                 ? MediaQuery.of(context).size.width * 0.68
      //   //                 : MediaQuery.of(context).size.width * 0.7,
      //   //             // height: MediaQuery.of(context).size.height * 0.,
      //   //             child: TextField(
      //   //               onChanged: (value) {
      //   //                 controller.isSearch.value = true;
      //   //                 controller.SearchProductApi();
      //   //               },
      //   //               controller: controller.searchController,
      //   //               decoration: InputDecoration(
      //   //                   contentPadding: EdgeInsets.symmetric(
      //   //                       horizontal: 15, vertical: 8),
      //   //                   border: OutlineInputBorder(
      //   //                     borderRadius: BorderRadius.circular(5),
      //   //                   ),
      //   //                   focusedBorder: OutlineInputBorder(
      //   //                     borderRadius: BorderRadius.circular(5),
      //   //                     borderSide: BorderSide(color: Colors.black),
      //   //                   ),
      //   //                   hintText: 'Search Golocery',
      //   //                   hintStyle: GoogleFonts.poppins(
      //   //                     color: Colors.black,
      //   //                     fontSize: 12,
      //   //                     fontWeight: FontWeight.w400,
      //   //                   ),
      //   //                   prefixIcon: Icon(
      //   //                     Icons.search,
      //   //                     size: 18,
      //   //                     color: Colors.black,
      //   //                   )),
      //   //             ),
      //   //           ),
      //   //         ))
      //   //       ],
      //   //     ),
      //   //   ),
      //   // ),
      //
      //   // bottom: PreferredSize(
      //   //   preferredSize: Size(100, 100),
      //   //   child: PreferredSizeWidget(
      //   //
      //   //   ),
      //   // ),
      //   leading: IconButton(
      //     onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      //     icon: Icon(Icons.sort_outlined,),
      //   ),
      //   // title: controller.isSearchVisible.value
      //   //     ? Obx(() => Visibility(
      //   //           visible: true,
      //   //           child: Text(
      //   //             "Welcome",
      //   //             style: TextStyle(color: Colors.black),
      //   //           ),
      //   //         ))
      //   //     : Obx(() => Visibility(
      //   //           visible: controller.isSearchVisible.value,
      //   //           child: Padding(
      //   //             padding: const EdgeInsets.only(left: 0),
      //   //             child: Row(
      //   //               mainAxisAlignment: MainAxisAlignment.center,
      //   //               children: [
      //   //                 Obx(() => Visibility(
      //   //                     visible: controller.isSearch.value,
      //   //                     child: InkWell(
      //   //                         onTap: () {
      //   //                           controller.isSearch.value = false;
      //   //                           controller.initialLoading.value = true;
      //   //                           controller.initialLoading.value = false;
      //   //                           controller.searchController.clear();
      //   //                         },
      //   //                         child: Icon(Icons.arrow_back)))),
      //   //                 SizedBox(
      //   //                     width: MediaQuery.of(context).size.width * 0.04),
      //   //                 Obx(() => Visibility(
      //   //                       visible: controller.isSearchVisible.value,
      //   //                       child: Container(
      //   //                         width: controller.isSearch.value
      //   //                             ? MediaQuery.of(context).size.width * 0.68
      //   //                             : MediaQuery.of(context).size.width * 0.7,
      //   //                         // height: MediaQuery.of(context).size.height * 0.,
      //   //                         child: TextField(
      //   //                           onChanged: (value) {
      //   //                             controller.isSearch.value = true;
      //   //                             controller.SearchProductApi();
      //   //                           },
      //   //                           controller: controller.searchController,
      //   //                           decoration: InputDecoration(
      //   //                               contentPadding: EdgeInsets.symmetric(
      //   //                                   horizontal: 15, vertical: 8),
      //   //                               border: OutlineInputBorder(
      //   //                                 borderRadius: BorderRadius.circular(5),
      //   //                               ),
      //   //                               focusedBorder: OutlineInputBorder(
      //   //                                 borderRadius: BorderRadius.circular(5),
      //   //                                 borderSide:
      //   //                                     BorderSide(color: Colors.black),
      //   //                               ),
      //   //                               hintText: 'Search Golocery',
      //   //                               hintStyle: GoogleFonts.poppins(
      //   //                                 color: Colors.black,
      //   //                                 fontSize: 12,
      //   //                                 fontWeight: FontWeight.w400,
      //   //                               ),
      //   //                               prefixIcon: Icon(
      //   //                                 Icons.search,
      //   //                                 size: 18,
      //   //                                 color: Colors.black,
      //   //                               )),
      //   //                         ),
      //   //                       ),
      //   //                     ))
      //   //               ],
      //   //             ),
      //   //           ),
      //   //         )),
      //   title: Obx(() =>
      //   controller.isSearchVisible.value
      //       ? Row(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //       Visibility(
      //         visible: controller.isSearch.value,
      //         child: InkWell(
      //           onTap: () {
      //             controller.isSearch.value = false;
      //             controller.initialLoading.value = true;
      //             controller.initialLoading.value = false;
      //             controller.searchController.clear();
      //           },
      //           child: Icon(Icons.arrow_back),
      //         ),
      //       ),
      //       SizedBox(width: MediaQuery
      //           .of(context)
      //           .size
      //           .width * 0.04),
      //       Expanded(
      //         child: Container(
      //           //color: Colors.white,
      //           child: TextField(
      //             onChanged: (value) {
      //               controller.isSearch.value = true;
      //               controller.SearchProductApi();
      //             },
      //             controller: controller.searchController,
      //             decoration: InputDecoration(
      //               contentPadding: EdgeInsets.symmetric(
      //                   horizontal: 15, vertical: 8),
      //               border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(5),
      //               ),
      //               focusedBorder: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(5),
      //                 borderSide: BorderSide(color: Colors.black),
      //               ),
      //               hintText: 'Search Grocery',
      //               hintStyle: GoogleFonts.poppins(
      //                 color: Colors.black,
      //                 fontSize: 12,
      //                 fontWeight: FontWeight.w400,
      //               ),
      //               prefixIcon: Icon(
      //                 Icons.search,
      //                 size: 18,
      //                 color: Colors.black,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   )
      //       : Row(
      //     children: [
      //       Obx(() =>   Text(
      //         " Welcome \n ${controller.customerName.toString()}",
      //         style: GoogleFonts.poppins(
      //           color: Colors.black,
      //           fontSize: 15,
      //           fontWeight: FontWeight.w600,
      //         ),
      //       ),),
      //       SizedBox(width: 10,),
      //
      //       // Expanded(
      //       //   child: Text(
      //       //     controller.customerName.toString(),
      //       //     style: GoogleFonts.poppins(
      //       //       color: Colors.black,
      //       //       fontSize: 15,
      //       //       fontWeight: FontWeight.w600,
      //       //     ),
      //       //   ),
      //       // )
      //     ],
      //   )),
      // ),
      body: Container(
        decoration: BoxDecoration(
            color: AppTheme.ScreenBackground, borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Obx(() => controller.initialLoading.value
            ? Center(child: CircularProgressIndicator())
            : controller.product.isNotEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ProductsListWidgets(context),
                    ],
                  )
                : Container()),
      ),
    );
  }

  // Widget ProductsListWidgets(BuildContext context) {
  //   return Expanded(
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.vertical,
  //       child: Obx(() =>
  //           Padding(
  //             padding: const EdgeInsets.symmetric(),
  //             child: controller.product!.value.isNotEmpty
  //                 ? SingleChildScrollView(
  //               child: controller.initialLoading.isFalse
  //                   ? Column(
  //                 children: [
  //                   Container(
  //                     padding: EdgeInsets.symmetric(
  //                       horizontal: 10,
  //                       vertical: 10,
  //                     ),
  //                     child: GridView.count(
  //                       physics: ScrollPhysics(),
  //                       crossAxisCount: 2,
  //                       childAspectRatio: 0.65,
  //                       crossAxisSpacing: 8,
  //                       mainAxisSpacing: 5,
  //                       shrinkWrap: true,
  //                       children: List.generate(
  //                         controller.product.length,
  //                             (index) {
  //                           return InkWell(
  //                             onTap: () {
  //                               controller.userDataProvider
  //                                   .SetProduct(
  //                                   controller.product[index]);
  //                               Get.toNamed(AppRoutes
  //                                   .producthomescreen.toName);
  //                             },
  //                             child: Card.filled(
  //                               shadowColor: Colors.grey,
  //                               color: Colors.white,
  //                               //surfaceTintColor: Colors.grey,
  //                               elevation: 5,
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius:
  //                                 BorderRadius.circular(20),
  //                               ),
  //                               child: Container(
  //                                 padding: EdgeInsets.only(
  //                                     right: 10, left: 10),
  //                                 child: Column(
  //                                   mainAxisAlignment:
  //                                   MainAxisAlignment
  //                                       .spaceEvenly,
  //                                   children: [
  //                                     ProductDisplayCommonComponent(
  //                                       productimage: controller
  //                                           .product[index]
  //                                           .productImage ??
  //                                           "",
  //                                       productname: controller
  //                                           .product[index]
  //                                           .productName ??
  //                                           "",
  //                                       productCategory: controller
  //                                           .product[index]
  //                                           .productCategory
  //                                           .toString() ??
  //                                           "",
  //                                       productprice: controller
  //                                           .product[index]
  //                                           .productPrice ??
  //                                           "",
  //                                       productQty: controller
  //                                           .product[index]
  //                                           .productQty ??
  //                                           "",
  //                                     )
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               )
  //                   : Center(
  //                 child: Container(
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       SizedBox(height: 100),
  //                       Image.asset("assets/images/nodata.png"),
  //                       SizedBox(height: 20),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             )
  //                 : Center(
  //               child: Container(
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     SizedBox(height: 100),
  //                     Image.asset("assets/images/nodata.png"),
  //                     SizedBox(height: 20),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           )),
  //     ),
  //   );
  // }

  Widget ProductsListWidgets(BuildContext context) {
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
                    child: GridView.count(
                      physics: ScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 5,
                      shrinkWrap: true,
                      children: List.generate(
                        controller.product.length,
                        (index) {
                          return InkWell(
                            onTap: () {
                              controller.userDataProvider!.SetProduct(controller.product[index]);
                              Get.toNamed(AppRoutes.producthomescreen.toName);
                            },
                            child: Card(
                              shadowColor: Colors.grey,
                              color: Colors.white,
                              //surfaceTintColor: Colors.grey,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(right: 10, left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ProductDisplayCommonComponent(
                                      productID: controller.product[index].productId ?? 0,
                                      productimage: controller.product[index].productImage ?? "",
                                      shopName: controller.product[index].shopName.toString() ?? "",
                                      productname: controller.product[index].productName ?? "",
                                      productCategory: controller.product[index].productCategory.toString() ?? "",
                                      productprice: controller.product[index].productPrice ?? "",
                                      productQty: controller.product[index].productQty ?? "",
                                      index: controller.counter[index].value,
                                      onTap: () {},
                                      isFavaurite: false,
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
              )))),
    );
  }
}

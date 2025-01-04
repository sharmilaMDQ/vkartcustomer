import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vkartcustomer/Components/AppTheme.dart';
// import 'package:intl/intl.dart';
import '../../Components/Forms.dart';
import '../../Components/wishlistScreenComponent.dart';
import '../../Controller/particularHomeScreenProductController.dart';
import '../../Forms/AppSnackBar.dart';

//
//this page used to add the home page product to cart and Show the Discription of the Selected Product
//
class particularHomeScreenProduct extends GetView<particularHomeScreenProductController> {
  particularHomeScreenProduct({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    particularHomeScreenProductController Controller = Get.put(particularHomeScreenProductController());

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller.selecedParticularProduct(context);
      controller.SelectedScreenApi();
    });
    return GetBuilder<particularHomeScreenProductController>(
      init: particularHomeScreenProductController(),
      builder: (controller) {
        return Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(
              color: Colors.transparent,
            ),
          ),
          child: Scaffold(
              persistentFooterButtons: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: Row(
                            children: [
                              Text('₹',
                                  style: GoogleFonts.poppins(
                                    color: AppTheme.Buttoncolor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Text(Controller.userDataProvider.particularProduct?.productPrice ?? "",
                                  style: GoogleFonts.poppins(
                                    color: AppTheme.Buttoncolor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.20,
                        ),
                        Button(
                          widthFactor: 0.4,
                          heightFactor: 0.06,
                          onPressed: () {
                            //   if (controller.userDataProvider.product!.sellerId == controller.CartProdct[0].sellerId || controller.CartProdct.isEmpty) {
                            //     controller.CartApi(context);
                            //   } else {
                            //     print("If you want to add Products");
                            //     showReplaceCartDialog(context);
                            // }
//
// for(int i = 0; i < controller.CartProdct.length; i++ ){
//   if (controller.userDataProvider.product!.sellerId == controller.CartProdct[i].sellerId || controller.CartProdct.isEmpty ) {
//     controller.CartApi(context);
//   } else {
//     print("If you want to add Products");
//     showReplaceCartDialog(context);
//   }
// }
                            if (Controller.CartProdct.isNotEmpty) {
                              if (controller.userDataProvider.particularProduct!.sellerId == controller.CartProdct[0].sellerId) {
                                controller.CartApi(context);
                              } else {
                                print("Do you want to replace the Order");
                                showReplaceCartDialog(context);
                              }
                            } else {
                              controller.CartApi(context);
                            }
                            // if (controller.userDataProvider.product!.sellerId == controller.CartProdct[0].sellerId) {
                            //   controller.CartApi(context);
                            // } else {
                            //   print("If you want to add Products");
                            //   showReplaceCartDialog(context);
                            // }

                            // if(controller.CartProdct.isEmpty){
                            //
                            // if(controller.userDataProvider.product!.sellerId ==
                            // controller.CartProdct[0].sellerId ) {  controller.CartApi(context); } else{ print( "Do you want to replace the\Order");}
                            //
                            // }
                            // controller.userDataProvider.product!.sellerId ==
                            //     controller.CartProdct[0].sellerId ?
                            // controller
                            //     .CartProdct.isEmpty ?
                            // controller.CartApi(context) : print(
                            //     "If you call want add Products") :  print(
                            //     "If you call want add Products");
                          },
                          child: controller.isLoading.value
                              ? Container(
                                  height: height * 0.04,
                                  width: height * 0.04,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ))
                              : Text(
                                  "Add to cart".tr,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              body: Obx(
                () => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 40, left: 20),
                                  child: InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: AppTheme.IconBackground,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        color: AppTheme.Buttoncolor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 280,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: Image.network(
                                    Controller.userDataProvider.particularProduct?.productImage ?? "",
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height * 0.3,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.image); // Placeholder icon for error
                                    },
                                  ),
                                ),
                                // Positioned(
                                //   top: 20,
                                //   child: InkWell(
                                //           onTap: (){
                                //             if (controller.userDataProvider.product!.wishList == true) {
                                //               controller.deleteWishListApi();
                                //             } else {
                                //               controller.AddWishListApi();
                                //             }
                                //           },
                                //           child: Icon(
                                //                   controller.userDataProvider.product!.wishList == true
                                //                   ? Icons.favorite
                                //                   : Icons.favorite_border,
                                //               size: 25,
                                //               color: Colors.redAccent,
                                //             ),
                                //           ),),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(Controller.userDataProvider.particularProduct?.productName ?? "",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  // Align(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: RatingBar.builder(
                                  //       initialRating: Controller
                                  //           .userDataProvider.products!.rating!
                                  //           .toDouble(),
                                  //       // minRating: 1,
                                  //       direction: Axis.horizontal,
                                  //       allowHalfRating: true,
                                  //       itemCount: 5,
                                  //       itemSize: 20,
                                  //       itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                  //       itemBuilder: (context, _) => Icon(
                                  //         Icons.star,
                                  //         color: Colors.amber,
                                  //       ),
                                  //       onRatingUpdate: (rating) {
                                  //         print(
                                  //             Controller.userDataProvider.products!.rating ??
                                  //                 "");
                                  //       },
                                  //       ignoreGestures: true),
                                  // ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * 0.015,
                            // ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(Controller.userDataProvider.particularProduct?.productDescription ?? "",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    size: 20,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * 0.01,
                            // ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: 'Fruits details ',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black26,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            )),
                                        TextSpan(
                                            text: 'More',
                                            style: GoogleFonts.poppins(
                                              color: Colors.orange,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            )
                                            // Add onTap function if needed
                                            ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Nutrition & Ingredients',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    size: 20,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Explore more related product',
                                      style: GoogleFonts.poppins(
                                        color: AppTheme.Buttoncolor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                            ),
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 0),
                                child: controller.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : controller.SelectedRelatedproduct.value.isNotEmpty
                                        ? SingleChildScrollView(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: controller.SelectedRelatedproduct.length,
                                              itemBuilder: (context, index) {
                                                return Card(
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
                                                        productimage: controller.SelectedRelatedproduct[index].productImage ?? "",
                                                        productname: controller.SelectedRelatedproduct[index].productName ?? "",
                                                        productprice: controller.SelectedRelatedproduct[index].productPrice ?? "",
                                                        shopName: "",
                                                        productQty: controller.SelectedRelatedproduct[index].productQty ?? "",
                                                        productCategory: controller.SelectedRelatedproduct[index].mainCategory ?? "",
                                                        onTap: () {},
                                                        isFavaurite: false,
                                                        productDiscountPrice: '',
                                                        discountAvailable: 0,
                                                      )
                                                    ],
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
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   'Price',
                                  //   style:  GoogleFonts.poppins(
                                  //     color: AppTheme.Buttoncolor,
                                  //     fontSize: 18,
                                  //     fontWeight: FontWeight.w600,
                                  //   )
                                  // )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.002,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            //
                            //
                          ],
                        ),
                      ),
              )),
        );
      },
    );
  }
}

void showReplaceCartDialog(BuildContext context) {
  particularHomeScreenProductController controller = Get.put(particularHomeScreenProductController());
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Replace cart item?'),
        content: Text(
          'Your cart contains dishes from Ambur Star Briyani. Do you want to discard the selection and add dishes from Anjappar?',
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppButton2(
                width: width * 0.30,
                height: 40,
                title: 'Cancel',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  Get.back();
                },
                color: Colors.white,
                titleColor: AppTheme.bottomTabsLabelInActiveColor,
                borderColor: AppTheme.cancelBorder,
              ),
              AppButton2(
                width: width * 0.30,
                height: 40,
                title: 'Replace',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                onPressed: () {
                  // controller.DeleteAllCart();
                  controller.CartApi(context);
                },
                titleColor: Colors.white,
                color: AppTheme.Buttoncolor,
                borderColor: AppTheme.Buttoncolor,
              ),
            ],
          ),
        ],
      );
    },
  );
}

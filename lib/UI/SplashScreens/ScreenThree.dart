import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vkartcustomer/Components/AppTheme.dart';
import 'package:vkartcustomer/UI/LoginScreen/LoginScreen.dart';
import '../../Controller/ScreenThreeController.dart';

class ScreenThree extends GetView<ScreenThreeController> {
  final List<String> imagePaths = [
    'assets/images/shopimage.png',
    'assets/images/delivery-concept-handsome-african-american-delivery-man-carrying-package-box-grocery-food-drink-from-store-isolated-grey-studio-background-copy-space.png',
  ];
  RxInt currents = RxInt(0);
  @override
  ScreenThreeController controller = ScreenThreeController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<ScreenThreeController>(
      init: ScreenThreeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, right: 20),
                    child: InkWell(
                      onTap: (){
                       // Get.to(OfferScreen());
                         Get.to(LoginScreen());
                      },
                      child: Text(
                        'Skip',
                        style: GoogleFonts.poppins(
                          color: AppTheme.Buttoncolor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Image.asset(
              //       'assets/images/Grosshop G.png',
              //       height: 50,
              //     ),
              //     Text(
              //       'express',
              //       style: GoogleFonts.poppins(
              //         color: Colors.black,
              //         fontSize: 40,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),  
              Container(
                height: 280,
                width: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.brown.shade50
                ),
                child: Center(
                  child: CarouselSlider(
                    items: controller.productImages.map((image) => Image.asset(image,
                    fit: BoxFit.contain,
                    height: 50,),
                    ).toList(),
                    // carouselController: controller.carouselController,
                    options: CarouselOptions(
                      height: 300,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        print('indexONPAGE$index');
                        controller.current.value = index;
                        controller.updateTabIndex(index);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      controller.headingText.value,
                      style: GoogleFonts.poppins(
                        color: AppTheme.Frontcolor,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // )
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.SubHeadingText.value,
                        style: GoogleFonts.poppins(
                          color: AppTheme.Frontcolor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              DotsIndicator(
                dotsCount: imagePaths.length,
                position: controller.current.value,
                decorator: DotsDecorator(
                  color: Colors.black26,
                  activeColor: AppTheme.Buttoncolor,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              /* Center(
                child: Button(
                  widthFactor: 0.9,
                  heightFactor: 0.06,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    controller.Buttons.value,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),*/
              SizedBox(
                height: 40,
              ),
               Obx(()=>
                 InkWell(
                  onTap:  controller.onPressed,
                  child: Container(
                    height: 45,
                    width: 200,
                    decoration: BoxDecoration(
                      gradient:LinearGradient(colors: [
                         Colors.green.shade400,
                        Colors.green.shade700,
                       
                      ],
                      begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child:controller.isLoading.value
                          ? SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 3,
                              ),
                            )
                :
                     Text( controller.Buttons.value,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),),
                    ),
                  ),
                ),
              ),
              // Center(
              //   child: Obx(() {
              //     // Using Obx to react to changes in the isLoading state
              //     return Button(
              //       widthFactor: 0.9,
              //       heightFactor: 0.06,
              //       onPressed: controller.onPressed, // Call the onPressed method in the controller
              //       child: controller.isLoading.value
              //           ? SizedBox(
              //               width: 15, // Adjust the size of the circular indicator
              //               height: 15,
              //               child: CircularProgressIndicator(
              //                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              //                 strokeWidth: 3, // Adjust the thickness of the spinner
              //               ),
              //             )
              //           : Text(
              //         controller.Buttons.value,
              //               style: GoogleFonts.poppins(
              //                 color: Colors.white,
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //     );
              //   }),
              // ),
            ],
          ),
        );
      },
    );
  }
}

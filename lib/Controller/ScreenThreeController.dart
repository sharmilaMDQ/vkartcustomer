import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../UI/LoginScreen/LoginScreen.dart';

class ScreenThreeController extends GetxController {
  final CarouselController carouselController = CarouselController();

  RxInt current = RxInt(0);
  RxString currentIndex = RxString('');
  RxBool isLoading = false.obs; 
  RxString headingText = RxString('Shop From Anywhere');
  RxString SubHeadingText = RxString(
    'Shop local flyers & deal and earn \n       '
    ' our optimum points ',
  );
  RxString Buttons = RxString('Next');

  List<String> productImages = [
    'assets/images/rb_856.png',
    'assets/images/delivery-concept-handsome-african-american-delivery-man-carrying-package-box-grocery-food-drink-from-store-isolated-grey-studio-background-copy-space.png',
  ];

  @override
  void onInit() async {
    super.onInit();
    updateTabIndex(current.value);
  }

  updateTabIndex(int index) {
    print('INDEXHEAD$current');
    if (current.value == 1) {
      headingText.value = 'Pick and Delivery';
      SubHeadingText.value = 'Pick up your orders in-store or have \n       '
          ' it delivered to your door ';
      Buttons.value = 'Got it';
      update();
      print('HEAD$headingText');
      print(headingText.value);
    } else {
      headingText.value = 'Shop From Anywhere';
      SubHeadingText.value = '   Shop local flyers & deal and earn \n       '
          '    our optimum points ';
      Buttons.value = 'Next';
      update();
      print('HEAD$headingText');
      print(headingText.value);
    }
  }

  Future<void> onPressed() async {
    isLoading.value = true; // Show the loading indicator

    // Simulate a delay (e.g., network request)
    await Future.delayed(Duration(seconds: 1));

    Get.to(() => LoginScreen());

    isLoading.value = false; // Hide the loading indicator after the operation
  }
}

import 'package:get/get.dart';

import '../UI/SplashScreens/ScreenThree.dart';

class ScreenTwoController extends GetxController {
  @override
  RxBool isLoading = false.obs;
  void onInit() async {
    super.onInit();
  }

  // Function to handle the button press logic
  Future<void> onPressed() async {
    isLoading.value = true; // Show the loading indicator

    // Simulate a delay (e.g., network request)
    await Future.delayed(Duration(seconds: 1));

    // After the delay, you can do any action, for example, navigate to the next screen
    Get.to(ScreenThree());

    isLoading.value = false; // Hide the loading indicator after the operation
  }
}

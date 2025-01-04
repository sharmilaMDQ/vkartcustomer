import 'package:get/get.dart';

class ChangePasswordScreenController extends GetxController {
  RxBool isVisible = false.obs;
  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

  @override
  void onInit() async {
    super.onInit();
  }
}

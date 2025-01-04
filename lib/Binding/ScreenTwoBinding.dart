import 'package:get/get.dart';
import '../Controller/ScreenTwoController.dart';

class ScreenTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScreenTwoController>(() => ScreenTwoController());
  }
}

import 'package:get/get.dart';
import '../Controller/ScreenThreeController.dart';

class ScreenThreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScreenThreeController>(() => ScreenThreeController());
  }
}

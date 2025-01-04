import 'package:get/get.dart';
import '../Controller/ScreenOneController.dart';

class ScreenOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScreenOneController>(() => ScreenOneController());
  }
}

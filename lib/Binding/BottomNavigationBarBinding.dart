import 'package:get/get.dart';
import '../Controller/BottomNavigationBarController.dart';

class BottomNavigationBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationBarController>(
        () => BottomNavigationBarController());
  }
}

import 'package:get/get.dart';
import '../Controller/particularHomeScreenProductController.dart';

class ParticularHomeScreenProductBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<particularHomeScreenProductController>(() => particularHomeScreenProductController());
  }
}

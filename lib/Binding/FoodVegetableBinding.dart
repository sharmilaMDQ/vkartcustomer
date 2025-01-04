import 'package:get/get.dart';
import '../Controller/FoodVegetableController.dart';

class FoodVegetableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodVegetableController>(() => FoodVegetableController());
  }
}

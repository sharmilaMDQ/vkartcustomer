import 'package:get/get.dart';
import '../Controller/FoodFruitScreenController.dart';

class FoodFruitScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodFruitScreenController>(() => FoodFruitScreenController());
  }
}

import 'package:get/get.dart';

import '../Controller/ProductHomeScreenController.dart';

class ProductHomeScreenBinding  extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductHomeScreenController>(() => ProductHomeScreenController());
  }
}

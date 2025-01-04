import 'package:get/get.dart';
import '../Controller/OrderListScreenController.dart';

class OrderListScreenBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<OrderListScreenController>(() => OrderListScreenController());
  }

}

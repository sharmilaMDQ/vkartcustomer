import 'package:get/get.dart';
import '../Controller/OfferDetailScreenController.dart';

class OfferDetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfferDetailScreenController>(
        () => OfferDetailScreenController());
  }
}

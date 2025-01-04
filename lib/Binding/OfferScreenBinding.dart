import 'package:get/get.dart';
import '../Controller/OfferScreenController.dart';

class OfferScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<OfferScreenController>(
            () => OfferScreenController());
  }
}
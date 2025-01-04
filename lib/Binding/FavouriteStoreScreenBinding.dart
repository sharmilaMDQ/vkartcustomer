import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import '../Controller/FavouriteStoreScreenController.dart';

class FavouriteStoreScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouriteStoreScreenController>(
        () => FavouriteStoreScreenController());
  }
}

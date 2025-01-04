import 'package:get/get.dart';
import '../Controller/CreateAccountScreenController.dart';

class CreateAccountScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAccountScreenController>(
        () => CreateAccountScreenController());
  }
}

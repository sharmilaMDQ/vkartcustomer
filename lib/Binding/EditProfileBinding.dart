import 'package:get/get.dart';
import '../Controller/EditProfileController.dart';

class EditProfileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileScreenController>(
            () => EditProfileScreenController());
  }
}

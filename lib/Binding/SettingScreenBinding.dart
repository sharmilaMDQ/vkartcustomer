import 'package:get/get.dart';

import '../Controller/SettingScreenController.dart';

class SettingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingScreenController>(() => SettingScreenController());
  }
}

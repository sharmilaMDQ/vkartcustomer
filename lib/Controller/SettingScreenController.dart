import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Apiconnect/ApiConnect.dart';
import '../Models/ParticularCustomerResponseModel.dart';
import '../utility/AppPreference.dart';

class SettingScreenController extends GetxController {
  RxBool initialLoading = RxBool(false);
  // RxString ImageUrl = RxString('');
  RxString imageString = RxString("");
  ParticularCustomerResponseData? getParticularCustomer;
  RxString customerName = RxString("");
  final ApiConnect _connect = Get.put(ApiConnect());
  @override
  void onInit() async {
    super.onInit();
    getParticularCustomerApi();
  }
  getParticularCustomerApi() async {
    print("SellerId ${AppPreference().UserId}");

    Map<String, dynamic> payload = {

      'customerId': AppPreference().UserId};
    print(" getParticularSeller_payload ${payload}");
    initialLoading.value = true;
    var response = await _connect.GetParticularCustomer(payload);
    initialLoading.value = false;
    print('getParticularSeller_Response${response.toJson()}');

    if (!response.error!) {
      // Fluttertoast.showToast(
      //   msg: response.message!,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      // );

      getParticularCustomer = response.data;
      customerName.value = response.data!.customerName!;
      imageString.value = response.data!.customerProfile!;
    } else {
      // Fluttertoast.showToast(
      //   msg: response.message!,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      // );
    }

  }


}

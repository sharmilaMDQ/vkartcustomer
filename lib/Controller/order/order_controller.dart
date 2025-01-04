import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:vkartcustomer/ApiConfig/service/order/order_expected_api_service.dart';

class OrderController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPickupMode = true.obs; // Observable for pickup mode
  RxBool isDeliveryMode = false.obs; // Observable for delivery mode
  RxString pickup = ''.obs; // Observable variable for pickup
  RxString deliveryOption = ''.obs; // Observable variable for delivery

  OrderExpectedApiService orderexpectedapiservice = OrderExpectedApiService();

  Future<void> getExpectedOrder({
    required int customerId,
    required String orderType,
    required String deliveryOption,
    required String pickupTime,
  }) async {
    isLoading(true);

    dio.Response<dynamic> response = await orderexpectedapiservice.orderexpectedApi(
      coustomerId: customerId,
      ordertype: orderType,
      deliveryoption: deliveryOption,
      pickuptime: pickupTime,
    );

    isLoading(false);
    if (response.statusCode == 200) {
      if (isPickupMode.value) {
        pickup.value = pickupTime;
      } else {
        this.deliveryOption.value = deliveryOption;
      }
      update();
    } else {
      // Handle error
    }
  }

  void toggleMode({required bool pickupMode}) {
    isPickupMode(pickupMode);
    isDeliveryMode(!pickupMode);
    update();
  }
}

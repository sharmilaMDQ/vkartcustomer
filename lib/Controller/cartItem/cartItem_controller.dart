
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:vkartcustomer/ApiConfig/service/cart/cart_item_count_api_service.dart';



class CartitemController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt itemCount = 0.obs; // Reactive cart item count

  CartItemCountApiService cartitemcountapiservice = CartItemCountApiService();

 Future<void> getCartCount({required int customerId}) async {
  try {
    isLoading(true);
    dio.Response response = await cartitemcountapiservice.cartitemcountApi(customerId: customerId);
    
    // Print the full response to debug
    print('Full API Response: ${response.data}');
    
    if (response.statusCode == 200) {
      // Check if data exists in the response
      if (response.data != null && response.data['data'] != null) {
        print('Cart Item Count: ${response.data['data']}');
        itemCount.value = response.data['data'];
        update();
        update();
      } else {
        print('No data in response');
      }
    } else {
      print('Error: ${response.statusCode} ${response.statusMessage}');
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    isLoading(false);
  }
}

}
import 'package:get/get.dart';

import '../Apiconnect/ApiConnect.dart';
import '../Models/OffersListResponse.dart';

class OfferScreenController extends GetxController {
  RxString listScreen = RxString('');
  RxList<OffersListResponseData> offerDetailsProducts = RxList();
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  bool ishomeCall = false;
  RxBool isCall = RxBool(false);
  @override
  void onInit() async {
    super.onInit();
    GetCartApi();
  }

  GetCartApi() async {
    isLoading.value = true;
    var response = await _connect.GetOfferList();
    isLoading.value = false;
    print("offersListScreen${response.toJson()}");
    if (!response.error!) {
      print('check cart api');
      offerDetailsProducts.value = response.data!;
      update();
    } else {}
  }
}

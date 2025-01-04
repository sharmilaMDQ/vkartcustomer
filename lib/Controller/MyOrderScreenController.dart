import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Apiconnect/ApiConnect.dart';
import '../Components/ProductDetails.dart';
import '../Models/GetParticularOrderListModel.dart';
import '../Provider/ProductProvider.dart';
import '../utility/AppPreference.dart';
import '../utility/keys.dart';

class MyOrderScreenController extends GetxController {
  RxInt selectedTabIndex = 0.obs;
  RxInt CurrentIndex = RxInt(0);
  RxInt index = RxInt(0);
  RxBool isVisibles = true.obs;
  RxBool isLoading = true.obs;
  bool hide = false;
  late ProductProvider userDataProvider;
  GetParticularData? getParticularOrderList;
  final ApiConnect _connect = Get.put(ApiConnect());
  List<Keyvalues> MyOrderTablist = [
    Keyvalues(key: "0", value: "Product list"),
    Keyvalues(key: "1", value: "Process"),
    Keyvalues(key: "2", value: "Track"),
  ];

  final List<ProductDetails> MyOrderstproducts = [
    ProductDetails(
      image: 'assets/images/Tomato.png',
      ProductName: 'Tomato',
      weight: '1 kg',
      Price: '\$1.60',
      ProductType: '',
    ),
    ProductDetails(
      image: 'assets/images/Bananas.png',
      ProductName: 'Banana',
      weight: '1 ea',
      Price: '\$3.50',
      ProductType: '',
    ),
    ProductDetails(
      image: 'assets/images/Orange.png',
      ProductName: 'Orange',
      weight: '1kg   ',
      Price: '\$2.80',
      ProductType: '',
    ),
  ];
  RxInt current = RxInt(0);
  RxString currentIndex = RxString('');

  RxString headingText1 = RxString('Order Process');
  RxString headingText2 = RxString('Product');
  RxString headingText3 = RxString('Processing');
  RxString headingText4 = RxString('On the way');
  RxString headingText5 = RxString('Delivery');

  RxString SubHeadingText1 = RxString('Order the product and is delivery based on location');
  RxString SubHeadingText2 = RxString('Order the product and is delivery based on location');
  RxString SubHeadingText3 = RxString('Order the product and is delivery based on location');
  RxString SubHeadingText4 = RxString('Order the product and is delivery based on location');
  RxString SubHeadingText5 = RxString('Order the product and is delivery based on location');

  RxInt currentStep = 0.obs;

  void updateCurrentStep(int step) {
    print("tab$step");
    currentStep.value = step;
  }

  RxInt currentindex = RxInt(0);
  RxBool isVisible = true.obs;

  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

  @override
  void onInit() async {
    super.onInit();
    userDataProvider = Provider.of<ProductProvider>(Get.context!, listen: false);
    getParticularOrder();
  }

  updateCurrentTabIndex(int index) {
    print("INDEX$index");
    selectedTabIndex.value = index;
    MyOrderTablist[selectedTabIndex.value].key;
    update();
  }

  Future<void> getParticularOrder() async {
    Map<String, dynamic> payload = {"customerId": AppPreference().UserId, "orderId": userDataProvider.getCounterClear.toString()};
    print(" getParticularOrderId_payload ${payload}");

    isLoading.value = true;
    var response = await _connect.GetParticularOrderList(payload);
    isLoading.value = false;

    print('getOrderList_Response${response.toJson()}');
    if (!response.error!) {
      getParticularOrderList = response.data!;
    } else {}
  }
}

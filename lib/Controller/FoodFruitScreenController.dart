import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Components/ProductDetails.dart';

class FoodFruitScreenController extends GetxController {
  final List<ProductDetails> FruitsProducts = [
    ProductDetails(
      image: 'assets/images/Strawberry.png',
      ProductName: 'Strawberry',
      ProductType: 'Fruits',
      Price: '\$10.06',
      weight: '',
    ),
    ProductDetails(
      image: 'assets/images/Bananas.png',
      ProductName: 'Bananas',
      ProductType: 'Fruits',
      Price: '\$10.06',
      weight: '',
    ),
    ProductDetails(
      image: 'assets/images/AppleFruit.png',
      ProductName: 'Apple',
      ProductType: 'Fruits',
      Price: '\$10.06',
      weight: '',
    ),
    ProductDetails(
      image: 'assets/images/Orange.png',
      ProductName: 'Orange',
      ProductType: 'Fruits',
      Price: '\$1.60',
      weight: '',
    ),
    ProductDetails(
      image: 'assets/images/Guava.png',
      ProductName: 'Guava',
      ProductType: 'Fruits',
      Price: '\$1.60',
      weight: '',
    ),
    ProductDetails(
      image: 'assets/images/Watermelon.png',
      ProductName: 'Watermelon',
      ProductType: 'Fruits',
      Price: '\$1.60',
      weight: '',
    ),
  ];
  @override
  void onInit() async {
    super.onInit();
  }
}

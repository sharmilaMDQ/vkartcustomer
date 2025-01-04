import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../Components/ProductDetails.dart';

class FoodVegetableController extends GetxController {
  final List<ProductDetails> VegetableProducts = [
    ProductDetails(
      image: 'assets/images/Tomato.png',
      ProductName: 'Tomato',
      ProductType: 'Vegetable',
      Price: '\$10.06',
      weight: '',
    ),
    ProductDetails(
      image: 'assets/images/avocado.png',
      ProductName: 'Avacado',
      ProductType: 'Vegetable',
      Price: '\$10.06',
      weight: '',
    ),
    ProductDetails(
      image: 'assets/images/Broccoli.png',
      ProductName: 'Broccoli',
      ProductType: 'Vegetable',
      Price: '\$10.06',
      weight: '',
    ),
    ProductDetails(
      image: 'assets/images/Beans.png',
      ProductName: 'Beans',
      ProductType: 'Vegetable',
      Price: '\$1.60',
      weight: '',
    ),
    ProductDetails(
      image: 'assets/images/Cabbage.png',
      ProductName: 'Cabbage',
      ProductType: 'Vegetable',
      Price: '\$1.60',
      weight: '',
    ),
    ProductDetails(
      image: 'assets/images/Carrot.png',
      ProductName: 'Carrot',
      ProductType: 'Vegetable',
      Price: '\$1.60',
      weight: '',
    ),
  ];
  @override
  void onInit() async {
    super.onInit();
  }
}

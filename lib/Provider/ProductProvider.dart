import 'package:flutter/cupertino.dart';

import '../Models/GetCustomerOrderLIstResponseModel.dart';
import '../Models/wishListResponseModel.dart';
import '../Pojo/DisplaySelectedProductScreenResponse.dart';
import '../Pojo/ProductHomeScreenResponse.dart';

class ProductProvider extends ChangeNotifier {
  Data? product;
  WishlistData? wishListProducts;
  String? productPriceDuplicate;
  String? addressTypeDuplicate;
  String? wholeAddress;
  Data? particularProduct;
  List<Data>? productData;
  Data? searchproduct;
  GetCustomerResponseModelData? customerOrderList;

  SelectedProductData? selectedproduct;

  String? location;
  String? latitude;
  String? longitude;
  int? nowGetIt;
  int? counterClear;
  get getproductPriceDuplicate => productPriceDuplicate;
  String? get getAddressTypeDuplicate => addressTypeDuplicate;
  String? get getwholeAddress => wholeAddress;

  String? get getLocation => location;

  String? get getLongitude => longitude;

  String? get getLatitude => latitude;

  int? get getItNow => nowGetIt;
  int? get getCounterClear => counterClear;

  Data? get products => product;

  List<Data>? get productDatas => productData;

  WishlistData? get getWishListProducts => wishListProducts;

  Data? get getParticularProducts => particularProduct;

  Data? get searchproducts => searchproduct;

  SelectedProductData? get selectedproducts => selectedproduct;

  GetCustomerResponseModelData? get getCustomerOrderLIst => customerOrderList;

  void SetParticularProduct(Data? data) {
    particularProduct = data;
    notifyListeners();
  }

  void SetWishListProduct(WishlistData? data) {
    wishListProducts = data;
    notifyListeners();
  }

  void SetProduct(Data? data) {
    product = data;
    notifyListeners();
  }

  void SetCustomerOrderList(GetCustomerResponseModelData? data) {
    customerOrderList = data;
    notifyListeners();
  }

  void SetProductList(List<Data>? data) {
    productData = data;
    notifyListeners();
  }

  void SetSearchProduct(Data? data) {
    searchproduct = data;
    notifyListeners();
  }

  void SetSelectedProduct(SelectedProductData? data) {
    selectedproduct = data;
    notifyListeners();
  }

  void SetSelectedLocation(String? data) {
    location = data;
    notifyListeners();
  }

  void setLongitude(String? data) {
    longitude = data;
    notifyListeners();
  }

  void setLatitude(String? data) {
    latitude = data;
    notifyListeners();
  }

  void setGetItNow(int? data) {
    nowGetIt = data;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void setCounterEmpty(int? data) {
    counterClear = data;
    notifyListeners();
  }

  void setTheDuplicatePrice(String? prices) {
    productPriceDuplicate = prices;
    notifyListeners();
  }

  void setAddressType(String addressType) {
    addressTypeDuplicate = addressType;
    notifyListeners();
  }

  void setWholeAddress(String addressType) {
    wholeAddress = addressType;
    notifyListeners();
  }
}

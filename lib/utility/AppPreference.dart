import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static const STORAGE_NAME = 'Grosh_Shop';
  static const _MOBILE_NUMBER = 'mobile_number';
  static const PRODUCT_ID = 'Product_ID';
  static const PRODUCT_NAME = 'Product_Name';
  static const ADDCART = 'Cart';
  static const USER_ID = '_USER_ID';
  static const SELLER_ID = '_SELLER_ID';
  static const PICK_UP = '_PICK_UP';
  static const DELIVERY = '_DELIVERY';
  static const CUSTOMER_NAME = '_CUSTOMER_NAME';
  
  final _storage = GetStorage(STORAGE_NAME);
  
  // ValueNotifier for CustomerName
  final ValueNotifier<String> customerNameNotifier = ValueNotifier("");

  AppPreference() {
    // Initialize the ValueNotifier with the current value
    customerNameNotifier.value = _storage.read(CUSTOMER_NAME) ?? "";
    // Listen to storage changes and update notifier
    _storage.listen(() {
      customerNameNotifier.value = _storage.read(CUSTOMER_NAME) ?? "";
    });
  }

  Future<void> init() async {
    await _storage.initStorage;
  }

  void updateMobileNumber(String mobileNumber) {
    _storage.write(_MOBILE_NUMBER, mobileNumber);
  }

  String get mobileNumber {
    try {
      return _storage.read(_MOBILE_NUMBER) ?? "";
    } catch (e) {
      return "";
    }
  }

  void updatePickUp(String pickup) {
    _storage.write(PICK_UP, pickup);
  }

  String get pickup {
    try {
      return _storage.read(PICK_UP) ?? "";
    } catch (e) {
      return "";
    }
  }

  void updateDelivery(String delivery) {
    _storage.write(DELIVERY, delivery);
  }

  String get delivery {
    try {
      return _storage.read(DELIVERY) ?? "";
    } catch (e) {
      return "";
    }
  }

  void updateProductId(String productId) {
    _storage.write(PRODUCT_ID, productId);
  }

  String get ProductId {
    try {
      return _storage.read(PRODUCT_ID) ?? "";
    } catch (e) {
      return "";
    }
  }

  void updateUserId(String userId) {
    _storage.write(USER_ID, userId);
  }

  String get UserId {
    try {
      return _storage.read(USER_ID) ?? "";
    } catch (e) {
      return "";
    }
  }

  void updateSellerId(String sellerId) {
    _storage.write(SELLER_ID, sellerId);
  }

  String get SellerId {
    try {
      return _storage.read(SELLER_ID) ?? "";
    } catch (e) {
      return "";
    }
  }

  void updateProductName(String productName) {
    _storage.write(PRODUCT_NAME, productName);
  }

  String get ProductName {
    try {
      return _storage.read(PRODUCT_NAME) ?? "";
    } catch (e) {
      return "";
    }
  }

  void updateCartName(String cartName) {
    _storage.write(ADDCART, cartName);
  }

  String get AddCart {
    try {
      return _storage.read(ADDCART) ?? "";
    } catch (e) {
      return "";
    }
  }

  // Methods for CustomerName
  void updateCustomerName(String customerName) {
    _storage.write(CUSTOMER_NAME, customerName);
  }

  String get CustomerName {
    try {
      return _storage.read(CUSTOMER_NAME) ?? "";
    } catch (e) {
      return "";
    }
  }

  void clearData() {
    _storage.erase();
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_ID);
  }

  Future<void> clearCustomerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('customerId'); // Removing customerId
  }
}

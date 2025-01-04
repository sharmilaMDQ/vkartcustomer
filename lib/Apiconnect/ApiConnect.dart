import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../ApiConfig/ApiUrl.dart';
import '../Models/AddCartProductResponse.dart';
import '../Models/AddCustomerAddresses.dart';
import '../Models/DeleteCustomerAddressModel.dart';
import '../Models/GetCartInfoResponseModel.dart';
import '../Models/GetCustomerAddressResponseModel.dart';
import '../Models/GetCustomerOrderLIstResponseModel.dart';
import '../Models/GetParticularOrderListModel.dart';
import '../Models/OffersListResponse.dart';
import '../Models/ParticularCustomerResponseModel.dart';
import '../Models/RegisterIdResponse.dart';
import '../Models/SearchProductsResponse.dart';
import '../Models/UpdateCartQuantityModel.dart';
import '../Models/couponCodeModel/couponCodeResponseModel.dart';
import '../Models/getParticularHomeScreenModel.dart';
import '../Models/wishListResponseModel.dart';
import '../Pojo/AddCartProductResponse.dart';
import '../Pojo/DeleteCartResponse.dart';
import '../Pojo/DisplaySelectedProductScreenResponse.dart';
import '../Pojo/FovouiteStoreScreenResponse.dart';
import '../Pojo/GetCartProductResponse.dart';
import '../Pojo/LoginScreenResponse.dart';
import '../Pojo/ProductHomeScreenResponse.dart';
import '../Pojo/RegisterResponse.dart';
import '../utility/AppUtility.dart';

class ApiConnect extends GetConnect {
  // HttpService httpService = HttpService();

  @override
  onInit() async {
    // await httpService.init();
    super.onInit();
    super.allowAutoSignedCert = true;
    super.onInit();

    httpClient.addResponseModifier((request, response) {
      debugPrint("------------ AUTH ------------");
      debugPrint("REQUEST METHOD: ${request.method} ; ENDPOINT:  ${request.url}");
      debugPrint("RESPONSE : ${response.bodyString}");
      return response;
    });
  }

  // Future<LoginResponse> LoginScreenres(Map<String, dynamic> payload) async {
  //   httpService.init();
  //   var Response = await httpService.request(
  //       url: ApiUrl.login, method: Method.POST, params: payload);
  //   if (Response is dio.Response) {
  //     if (Response.data == null) {
  //       throw Exception(AppUtility.connectivityMessage);
  //     }
  //     return LoginResponse.fromJson(Response.data);
  //   }
  //   return LoginResponse();
  // }

  Future<LoginResponse> LoginScreenres(Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'x-api-key': '655f636f6d6d657263655f6d6f62696c65',
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.login, formData, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    print("body ${response.body}");
    return LoginResponse.fromJson(response.body);
  }

  // Future<RegisterResponse> RegisterScreen(Map<String, dynamic> payload) async {
  //    FormData formData = FormData(payload);
  //    var response = await post(ApiUrl.baseUrl + ApiUrl.register, formData);
  //    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
  //    return RegisterResponse.fromJson(response.body);
  //  }
  Future<RegisterCustomerIdResponse> registerUpload(Map<String, dynamic> payload, String endpoint) async {
    Map<String, String> header = {
      'x-api-key': '655f636f6d6d657263655f6d6f62696c65',
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + endpoint, formData, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return RegisterCustomerIdResponse.fromJson(response.body);
  }

  Future<RegisterResponse> forgotPassword(Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'x-api-key': '655f636f6d6d657263655f6d6f62696c65',
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.forgotPassword, formData, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    print("body ${response.body}");
    return RegisterResponse.fromJson(response.body);
  }

  Future<RegisterCustomerIdResponse> imgRegisterCall(
    String url,
    XFile? imageFile,
    Map<String, String> payload,
  ) async {
    print("URL$url");
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));
    if (imageFile != null) {
      var imageStream = http.ByteStream(imageFile.openRead());
      var imageLength = await imageFile.length();
      var multipartFile = http.MultipartFile('customerImage', imageStream, imageLength, filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
    }
    request.fields.addAll(payload);
    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return RegisterCustomerIdResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = RegisterCustomerIdResponse.fromJson(parsedResponse);
    print("Status_Code ${response.statusCode}");

    return convertedResponse;
  }

  Future<FavoriteScreenRes> favoriteScreen(Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    Map<String, String> header = {
      'x-api-key': '655f636f6d6d657263655f6d6f62696c65',
    };
    var response = await post(ApiUrl.baseUrl + ApiUrl.favoriteScreen, formData, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return FavoriteScreenRes.fromJson(response.body);
  }

  // Future<RegisterResponse> RegisterScreen(Map<String, dynamic> payload) async {
  //   httpService.init();
  //   var Response = await httpService.request(
  //       url: ApiUrl.register, method: Method.POST, params: payload);
  //   if (Response is dio.Response) {
  //     if (Response.data == null) {
  //       throw Exception(AppUtility.connectivityMessage);
  //     }
  //     return RegisterResponse.fromJson(Response.data);
  //   }
  //   return RegisterResponse();
  // }

  // Future<FavoriteScreenRes> favoriteScreen(Map<String, dynamic> payload) async {
  //   httpService.init();
  //   var Response = await httpService.request(
  //       url: ApiUrl.favoriteScreen, method: Method.POST, params: payload);
  //   if (Response is dio.Response) {
  //     if (Response.data == null) {
  //       throw Exception(AppUtility.connectivityMessage);
  //     }
  //     return FavoriteScreenRes.fromJson(Response.data);
  //   }
  //   return FavoriteScreenRes();
  // }

  // Future<ProductHomeResponse> HomeScreen(Map<String, dynamic> payload) async {
  //   httpService.init();
  //   var Response = await httpService.request(
  //       url: ApiUrl.homeScreen, method: Method.POST, params: payload);
  //
  //   if (Response is dio.Response) {
  //     if (Response.data == null) {
  //       throw Exception(AppUtility.connectivityMessage);
  //     }
  //     return ProductHomeResponse.fromJson(Response.data);
  //   }
  //   return ProductHomeResponse();
  // }

  Future<ProductHomeResponse> HomeScreen(Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'x-api-key': '655f636f6d6d657263655f6d6f62696c65',
    };
    print("HOME PAYLOAD ===>${payload}");
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.homeScreen, formData, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    print("get near by products body ${response.body}");
    for(var ss in response.body["data"]){
      print(ss["cartQuantity"]);
    }
    return ProductHomeResponse.fromJson(response.body);
  }

  Future<AddCartResponse> AddWishList(Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'x-api-key': '655f636f6d6d657263655f6d6f62696c65',
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.addWishList, formData, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    print("body ${response.body}");
    return AddCartResponse.fromJson(response.body);
  }

  Future<AddCartResponse> DeleteWishList(Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'x-api-key': '655f636f6d6d657263655f6d6f62696c65',
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.deleteWishList, formData, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    print("body ${response.body}");
    return AddCartResponse.fromJson(response.body);
  }

  Future<ProductHomeResponse> DeleteCartAll(Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'x-api-key': '655f636f6d6d657263655f6d6f62696c65',
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.deleteCart, formData, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    print("body ${response.body}");
    return ProductHomeResponse.fromJson(response.body);
  }

  Future<DisplaySelectedProductResponse> DisplaySelectScreen(Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'x-api-key': '655f636f6d6d657263655f6d6f62696c65',
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.SelectProductScreen, formData, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    print("body ${response.body}");
    return DisplaySelectedProductResponse.fromJson(response.body);
  }

  Future<GetCustomerResponseModel> GetCustomerOrderList(Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'x-api-key': '655f636f6d6d657263655f6d6f62696c65',
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getCustomerOrderlist, formData, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    print("body ${response.body}");
    return GetCustomerResponseModel.fromJson(response.body);
  }

  Future<AddCartProductResponse> AddCart(Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'x-api-key': '655f636f6d6d657263655f6d6f62696c65',
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.addcart, formData, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    print("body ${response.body}");
    return AddCartProductResponse.fromJson(response.body);
  }

  Future<GetCartResponse> GetCart(Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'x-api-key': '655f636f6d6d657263655f6d6f62696c65',
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getcart, formData, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    print("body ${response.body}");
    return GetCartResponse.fromJson(response.body);
  }

  Future<AddCartResponse> PlaceOrderList(Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'x-api-key': '655f636f6d6d657263655f6d6f62696c65',
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getCustomerPlaceOrderList, formData, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    print("body ${response.body}");
    return AddCartResponse.fromJson(response.body);
  }

  Future<OffersListResponse> GetOfferList() async {
    Map<String, String> header = {
      'x-api-key': '655f636f6d6d657263655f6d6f62696c65',
    };
    var response = await get(ApiUrl.baseUrl + ApiUrl.getOfferslist, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    print("body ${response.body}");
    return OffersListResponse.fromJson(response.body);
  }

  Future<DeleteCartResponse> DeleteCart(Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'x-api-key': '655f636f6d6d657263655f6d6f62696c65',
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.deletecart, formData, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    print("body ${response.body}");
    return DeleteCartResponse.fromJson(response.body);
  }

  // Future<DisplaySelectedProductResponse> DisplaySelectScreen(
  //     Map<String, dynamic> payload) async {
  //   httpService.init();
  //   var Response = await httpService.request(
  //       url: ApiUrl.SelectProductScreen, method: Method.POST, params: payload);
  //
  //   if (Response is dio.Response) {
  //     if (Response.data == null) {
  //       throw Exception(AppUtility.connectivityMessage);
  //     }
  //     return DisplaySelectedProductResponse.fromJson(Response.data);
  //   }
  //   return DisplaySelectedProductResponse();
  // }

  // Future<AddCartResponse> AddCart(Map<String, dynamic> payload) async {
  //   httpService.init();
  //   var Response = await httpService.request(
  //       url: ApiUrl.addcart, method: Method.POST, params: payload);
  //
  //   if (Response is dio.Response) {
  //     if (Response.data == null) {
  //       throw Exception(AppUtility.connectivityMessage);
  //     }
  //     return AddCartResponse.fromJson(Response.data);
  //   }
  //   return AddCartResponse();
  // }

  // Future<GetCartResponse> GetCart(Map<String, dynamic> payload) async {
  //   httpService.init();
  //   var Response = await httpService.request(
  //       url: ApiUrl.getcart, method: Method.POST, params: payload);
  //
  //   if (Response is dio.Response) {
  //     if (Response.data == null) {
  //       throw Exception(AppUtility.connectivityMessage);
  //     }
  //     return GetCartResponse.fromJson(Response.data);
  //   }
  //   return GetCartResponse();
  // }

  // Future<DeleteCartResponse> DeleteCart(Map<String, dynamic> payload) async {
  //   httpService.init();
  //   var Response = await httpService.request(
  //       url: ApiUrl.deletecart, method: Method.POST, params: payload);
  //
  //   if (Response is dio.Response) {
  //     if (Response.data == null) {
  //       throw Exception(AppUtility.connectivityMessage);
  //     }
  //     return DeleteCartResponse.fromJson(Response.data);
  //   }
  //   return DeleteCartResponse();
  // }
  //
  // Future<ProductHomeResponse> SearchProduct(
  //     Map<String, dynamic> payload) async {
  //   httpService.init();
  //   var Response = await httpService.request(
  //       url: ApiUrl.SearchProduct, method: Method.POST, params: payload);
  //   if (Response is dio.Response) {
  //     if (Response.data == null) {
  //       throw Exception(AppUtility.connectivityMessage);
  //     }
  //     return ProductHomeResponse.fromJson(Response.data);
  //   }
  //   return ProductHomeResponse();
  // }

  Future<SearchProductsResponse> SearchProduct(Map<String, dynamic> payload) async {
    Map<String, String> header = {'x-api-key': '655f636f6d6d657263655f6d6f62696c65'};
    print("SEARCH PAY LOAD ==>${payload} ");
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.SearchProduct, formData, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    print("body ${response.body}");
    return SearchProductsResponse.fromJson(response.body);
  }

  Future<ParticularCustomerResponse> GetParticularCustomer(Map<String, dynamic> payload) async {
    Map<String, String> header = {'x-api-key': '655f636f6d6d657263655f6d6f62696c65'};
    print("PAY LOAD CART ===>${payload}");
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getParticularCustomer, formData, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    print("body ${response.body}");
    return ParticularCustomerResponse.fromJson(response.body);
  }

  /// Upcomings are Integrated by mohan
  Future<wishListApiResponseModel> wishListApiCall(Map<String, dynamic> payload) async {
    const String apiKey = '655f636f6d6d657263655f6d6f62696c65';

    final String url = '${ApiUrl.baseUrl}${ApiUrl.getWishList}';

    try {
      FormData formData = FormData(payload);

      Map<String, String> header = {'x-api-key': apiKey};

      var response = await post(url, formData, headers: header);
      if (response.statusCode == 200) {
        print("Status_Code: ${response.statusCode}");
        print("Response body: ${response.body}");
        return wishListApiResponseModel.fromJson(response.body);
      } else {
        throw Exception("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("API call error: $e");
      throw Exception("Error fetching wishlist data. Please try again.");
    }
  }

  Future<getParticularHomeScreenProducts> particularHomeScreenProduct(Map<String, dynamic> payload) async {
    const String apiKey = '655f636f6d6d657263655f6d6f62696c65';

    final String url = '${ApiUrl.baseUrl}${ApiUrl.getParticularProduct}';

    try {
      FormData formData = FormData(payload);

      Map<String, String> header = {'x-api-key': apiKey};

      var response = await post(url, formData, headers: header);
      if (response.statusCode == 200) {
        print("Status_Code: ${response.statusCode}");
        print("Response body: ${response.body}");
        return getParticularHomeScreenProducts.fromJson(response.body);
      } else {
        throw Exception("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("API call error: $e");
      throw Exception("Error fetching wishlist data. Please try again.");
    }
  }

//delete address
  Future<DeleteCustomerAddress> deleteCustomerAddresses(Map<String, dynamic> payload) async {
    const String apiKey = '655f636f6d6d657263655f6d6f62696c65';

    final String url = '${ApiUrl.baseUrl}${ApiUrl.deleteCustomerAddress}';

    try {
      FormData formData = FormData(payload);

      Map<String, String> header = {'x-api-key': apiKey};

      var response = await post(url, formData, headers: header);
      if (response.statusCode == 200) {
        print("Status_Code: ${response.statusCode}");
        print("Response body: ${response.body}");
        return DeleteCustomerAddress.fromJson(response.body);
      } else {
        throw Exception("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("API call error: $e");
      throw Exception("Error Deleting Data. Please try again.");
    }
  }

  //get address
  Future<GetCustomerAddressModel> getCustomerAddress(Map<String, dynamic> payload) async {
    const String apiKey = '655f636f6d6d657263655f6d6f62696c65';

    final String url = '${ApiUrl.baseUrl}${ApiUrl.getCustomerAddress}';

    try {
      FormData formData = FormData(payload);

      Map<String, String> header = {'x-api-key': apiKey};

      var response = await post(url, formData, headers: header);
      if (response.statusCode == 200) {
        print("Status_Code: ${response.statusCode}");
        print("Response body: ${response.body}");
        return GetCustomerAddressModel.fromJson(response.body);
      } else {
        throw Exception("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("API call error: $e");
      throw Exception("Error Deleting Data. Please try again.");
    }
  }

  //add address
  Future<AddAddressesResponseModel> addCustomerAddress(Map<String, dynamic> payload) async {
    const String apiKey = '655f636f6d6d657263655f6d6f62696c65';

    final String url = '${ApiUrl.baseUrl}${ApiUrl.addCustomerAddress}';

    try {
      FormData formData = FormData(payload);

      Map<String, String> header = {'x-api-key': apiKey};

      var response = await post(url, formData, headers: header);
      if (response.statusCode == 200) {
        print("Status_Code: ${response.statusCode}");
        print("Response body: ${response.body}");
        return AddAddressesResponseModel.fromJson(response.body);
      } else {
        throw Exception("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("API call error: $e");
      throw Exception("Error Deleting Data. Please try again.");
    }
  }

  //getcart info

  Future<GetCartInfoResponseModel> getCartInfo(Map<String, dynamic> payload) async {
    const String apiKey = '655f636f6d6d657263655f6d6f62696c65';

    final String url = '${ApiUrl.baseUrl}${ApiUrl.getCartInformation}';

    try {
      FormData formData = FormData(payload);

      Map<String, String> header = {'x-api-key': apiKey};

      var response = await post(url, formData, headers: header);
      if (response.statusCode == 200) {
        print("Status_Code: ${response.statusCode}");
        print("Response body: ${response.body}");
        return GetCartInfoResponseModel.fromJson(response.body);
      } else {
        throw Exception("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("API call error: $e");
      throw Exception("Error Deleting Data. Please try again.");
    }
  }
   
   //update cart quality
  Future<UpdateCartQuantityModel> updateCartQuantities(Map<String, dynamic> payload) async {
    const String apiKey = '655f636f6d6d657263655f6d6f62696c65';

    final String url = '${ApiUrl.baseUrl}${ApiUrl.updateCartQuantities}';

    try {
      FormData formData = FormData(payload);

      Map<String, String> header = {'x-api-key': apiKey};

      var response = await post(url, formData, headers: header);
      if (response.statusCode == 200) {
        print("Status_Code: ${response.statusCode}");
        print("Response body: ${response.body}");
        return UpdateCartQuantityModel.fromJson(response.body);
      } else {
        throw Exception("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("API call error: $e");
      throw Exception("Error Deleting Data. Please try again.");
    }
  }
  
  //get particular orderlist
  Future<GetParticularOrderListModel> GetParticularOrderList(Map<String, dynamic> payload) async {
    const String apiKey = '655f636f6d6d657263655f6d6f62696c65';

    final String url = '${ApiUrl.baseUrl}${ApiUrl.getParticularMyOrder}';

    try {
      FormData formData = FormData(payload);

      Map<String, String> header = {'x-api-key': apiKey};

      var response = await post(url, formData, headers: header);
      if (response.statusCode == 200) {
        print("Status_Code: ${response.statusCode}");
        print("Response body: ${response.body}");
        return GetParticularOrderListModel.fromJson(response.body);
      } else {
        throw Exception("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("API call error: $e");
      throw Exception("Error Deleting Data. Please try again.");
    }
  }

  Future<CouponCodeApplyModel> ApplyCouponCode(Map<String, dynamic> payload) async {
    const String apiKey = '655f636f6d6d657263655f6d6f62696c65';

    final String url = '${ApiUrl.baseUrl}${ApiUrl.applyCouponCode}';

    try {
      FormData formData = FormData(payload);

      Map<String, String> header = {'x-api-key': apiKey};

      var response = await post(url, formData, headers: header);
      if (response.statusCode == 200) {
        print("Status_Code: ${response.statusCode}");
        print("Response body: ${response.body}");
        return CouponCodeApplyModel.fromJson(response.body);
      } else {
        throw Exception("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("API call error: $e");
      throw Exception("Error Applying Code. Please try again.");
    }
  }
}

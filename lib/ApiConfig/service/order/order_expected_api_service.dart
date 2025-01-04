import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkartcustomer/ApiConfig/ApiUrl.dart';

class OrderExpectedApiService  extends ApiUrl{

  Future orderexpectedApi({
  required int coustomerId,
  required String ordertype,
  required String deliveryoption,
  required String pickuptime})async{
   dynamic responseJson;

   try{
    var dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    String? authtoken = await prefs.getString('authtoken');
    FormData formData = FormData.fromMap({
      "customerId":coustomerId,
      "orderType":ordertype,
      "deliveryOption":deliveryoption,
      "pickupTime":pickuptime
    });
    var response = await dio.post(ApiUrl.orderexpectedUrl,
    options: Options(
      headers: {
        "Accept":"application/json",
        "x-api-key": "655f636f6d6d657263655f6d6f62696c65"
      },
      followRedirects: false,
      validateStatus: (status){
        return status!<=500;
      }
    ),data: formData
    );
    print("::::::::::::Order Expected Api Service::::::::::::<status code>:::::::::::::");
    print(response.statusCode);
    print(response.data);
    responseJson = response.data;
   }
   on SocketException{
    print('no internet');
   }
   return responseJson;
  }
}
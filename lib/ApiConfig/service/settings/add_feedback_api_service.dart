import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkartcustomer/ApiConfig/ApiUrl.dart';

class AddFeedbackApiService extends ApiUrl {

  Future addfeedbackApi({
    required int customerId,
    required String rating,
    required String reviewText})async{
    dynamic responseJson;

    try{
      var dio = Dio(); 
      final prefs = await SharedPreferences.getInstance();
      String? authoken = prefs.getString("authtoken");
      FormData formdata = FormData.fromMap({
        "sellerId":"2",
        "customerId":customerId,
        "rating":rating,
        "reviews":reviewText
      });
      var response = await dio.post(ApiUrl.addfeedbackUrl,
      options: Options(
        headers: {
          "Accept":"application/json",
          "x-api-key": "655f636f6d6d657263655f6d6f62696c65"
        },
        followRedirects: false,
        validateStatus: (status){
          return status!<=500;
        }
      ),
      data: formdata
      );
      print("::::::::::::Add FeedBack Api Service:::::::::::::<status code>::::::::::::");
      print(response.statusCode);
      print(response.data);
    responseJson = response;
    }
    on SocketException{
      print('no internet');
    }
    return responseJson;
  }




  Future getFeedbackApi({required String customerId})async{
    dynamic responseJson;

    try{
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      String? authoken = prefs.getString("authtoken");
      FormData formdata = FormData.fromMap({
        "customerId":customerId,
      });
      var response = await dio.post(ApiUrl.getfeedbackUrl,
          options: Options(
              headers: {
                "Accept":"application/json",
                "x-api-key": "655f636f6d6d657263655f6d6f62696c65"
              },
              followRedirects: false,
              validateStatus: (status){
                return status!<=500;
              }
          ),
          data: formdata
      );
      print("::::::::::::Add FeedBack Api Service:::::::::::::<status code>::::::::::::");
      print(response.statusCode);
      print(response.data);
      responseJson = response;
    }
    on SocketException{
      print('no internet');
    }
    return responseJson;
  }
}
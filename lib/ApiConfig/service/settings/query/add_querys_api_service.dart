import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkartcustomer/ApiConfig/ApiUrl.dart';
import 'package:vkartcustomer/Models/settings/add_querys_model.dart';

class AddQuerysApiService extends ApiUrl {

  Future addQuerysApi({required AddQuerysModel addquerysmodel})async{
   dynamic responseJson;

   try{
    var dio = Dio();
    final prefs = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "sellerId":"2",
      "customerId":addquerysmodel.coustomerId,
      "queryOptionId":addquerysmodel.queryId,
      "query":addquerysmodel.querys
    });
    String? authtoken = prefs.getString("authtoken");

    var response = await dio.post(ApiUrl.addquerysUrl,
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
    data: formData
    );
    print("::::::::::::::Add Query Api Service:::::::::::::::<status code>:::::::::");
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
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkartcustomer/ApiConfig/ApiUrl.dart';

class RupeesSymbolApiService extends ApiUrl {

  Future rupeesymbolApi()async{

    dynamic responseJson;

    try{
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      String? authtoken = prefs.getString('authtoken');
      var response = await dio.get(ApiUrl.rupeessymbolUrl,
      options: Options(
        headers: {
          "Accept":"application/json",
          'x-api-key': '655f636f6d6d657263655f6d6f62696c65'
        },
        followRedirects: false,
        validateStatus: (status) {
          return status!<=500;
        },
      ),
      );
      print(":::::::::::Rupees Symbol Api Service::::::::::<status code>:::::::::::");
      print(response.statusCode);
      print(response.data);
      responseJson = response;
    }
    on SocketException{
      print("no internet");
    }
    return responseJson;
  }
}
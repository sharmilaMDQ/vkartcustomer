import 'dart:io';
import 'package:dio/dio.dart';
import 'package:vkartcustomer/ApiConfig/ApiUrl.dart';

class CartItemCountApiService extends ApiUrl {

  Future<dynamic> cartitemcountApi({required int customerId}) async {
    dynamic responseJson;

    try {
      var dio = Dio();
      
      // Setting the API key header
      dio.options.headers = {
        "Accept": "application/json",
        "x-api-key": "655f636f6d6d657263655f6d6f62696c65", // Replace with your actual API key
      };

      // Prepare the form data
      FormData formData = FormData.fromMap({
        "customerId": customerId.toString(), // Ensure it's a string as the curl request has "customerId=\"7\""
      });

      // Send the POST request
      var response = await dio.post(
        ApiUrl.getItemcountUrl,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! <= 500;
          },
        ),
      );
  
      // Print the response for debugging
      print('Response data cart item count APi Service: ${response.data}');
      
      if (response.statusCode == 200 && response.data != null) {
        responseJson = response;
      } else {
        responseJson = null; // Handle error or missing data
      }
    } on SocketException {
      print('No internet connection');
      responseJson = 'No internet connection';
    } catch (e) {
      print('Error: $e');
      responseJson = 'Error: $e';
    }

    return responseJson; // Return the response or error message
  }
}

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:vkartcustomer/ApiConfig/ApiUrl.dart';

class OffersListApiService extends ApiUrl {
  Future<Response<dynamic>> offerslistAPi() async {
    try {
      var dio = Dio();
      //final prefs = await SharedPreferences.getInstance();
      //String? authtoken = prefs.getString('authtoken');

      var response = await dio.get(
        ApiUrl.getoffersSliderlist,
        options: Options(
          headers: {
            "Accept": "application/json",
            // "Authorization": authtoken != null ? "Bearer $authtoken" : null,
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! <= 500;
          },
        ),
      );

      print("::: Offers List Slider API ::: <Status Code>: ${response.statusCode}");
      print("Response Data: ${response.data}");
      return response;
    } on DioError catch (e) {
      print("Dio Error: ${e.message}");
      rethrow; // Re-throw the exception to handle it in the controller
    } on SocketException {
      print("No internet connection");
      throw Exception("No internet connection");
    }
  }
}

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkartcustomer/ApiConfig/ApiUrl.dart';
import 'package:vkartcustomer/Models/settings/profile_update_model.dart';

class GetUpdateApiService extends ApiUrl {
  Future getupdateApi({required ProfileUpdateModel profileupdatemodel}) async {
  dynamic responseJson;

  try {
    var dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    String? authtoken = prefs.getString("authtoken");

  FormData formData = FormData.fromMap({

      "customerId": profileupdatemodel.customerId,
      "customerMobile": profileupdatemodel.mobileNumber,
      "firstName": profileupdatemodel.name,
      "customerAddress": profileupdatemodel.address,
      "customerCity": profileupdatemodel.city,
      "customerState": profileupdatemodel.state,
      "customerCountry": profileupdatemodel.country,
      "customerPincode": profileupdatemodel.pincode,
      "customerEmail": profileupdatemodel.emailId,
      "customerImage": profileupdatemodel.image != null && !profileupdatemodel.image.toString().contains("http")
          ? await MultipartFile.fromFile(profileupdatemodel.image!)
          : profileupdatemodel.image!, // Ensure the image is properly handled as a file
    });

    var response = await dio.post(
      ApiUrl.getupdateprofileUrl,
      options: Options(
        headers: {
          "x-api-key": "655f636f6d6d657263655f6d6f62696c65",
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! <= 500;
        },
      ),
      data: formData,
    );

    print('Response: ${response.statusCode}');
    responseJson = response;
  } on DioError catch (e) {
    print('DioError: ${e.message}');
  } on SocketException {
    print('No internet connection');
  } catch (e) {
    print('Unexpected error: $e');
  }
  return responseJson;
}


}
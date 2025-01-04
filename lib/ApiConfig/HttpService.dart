import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetX;
import '../Forms/AppSnackBar.dart';
import '../utility/ThemeWidget.dart';
import 'ApiUrl.dart';


enum Method { POST, GET, PUT, DELETE, PATCH }

const bool isProductionUrl = true;

const String BASE_URL = isProductionUrl
    ? "https://mdqualityapps.in/API/gross_shop/uat/"
    : "https://mdqualityapps.in/API/gross_shop/uat/";

class HttpService {
  Map<String, String> headers = {"Content-Type": "application/json"};
  late Dio _dio;

  Future<HttpService> init({bool enableAuth = true}) async {
    if (enableAuth) {
      headers['x-api-key'] = '655f636f6d6d657263655f6d6f62696c65';

    }
    _dio = Dio(BaseOptions(baseUrl: BASE_URL, headers: headers));

    initInterceptors();
    return this;
  }

  void initInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          print(
              "REQUEST[${requestOptions.method}] => PATH: ${requestOptions.path}"
              "=> REQUEST VALUES: ${requestOptions.queryParameters} => HEADERS: ${requestOptions.headers}");
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          print("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        onError: (err, handler) {
          print("Error[${err.response?.statusCode}]");
          return handler.next(err);
        },
      ),
    );
  }

  Future<dynamic> request(
      {required String url,
      required Method method,
      Map<String, dynamic>? params}) async {
    Response response;
    try {
      if (method == Method.POST) {
        FormData formData = FormData.fromMap(params!);

        response = await GetX.Get.showOverlay(
            asyncFunction: () => _dio.post(url, data: formData),
            loadingWidget: loadingWidget());
        print(params);
      } else if (method == Method.GET) {
        response = await GetX.Get.showOverlay(
            asyncFunction: () => _dio.get(url), loadingWidget: loadingWidget());
      } else if (method == Method.PUT) {
        response = await GetX.Get.showOverlay(
            asyncFunction: () => _dio.put(url, data: params),
            loadingWidget: loadingWidget());
      } else {
        response = await GetX.Get.showOverlay(
            asyncFunction: () => _dio.get(url, queryParameters: params),
            loadingWidget: loadingWidget());
      }
      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 400) {
        throw Exception("Bad Request");
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else {
        throw Exception("Something does wen't wrong");
      }
    } on SocketException catch (e) {
      print(e);
      throw Exception("Not Internet Connection");
    } on FormatException catch (e) {
      print(e);
      throw Exception("Bad response format");
    } on DioError catch (e) {
      print(e);
      if (e.response == null) {
        AppSnackBar.error(message: "Invalid user name or password");
      } else {
        AppSnackBar.error(message: e.response!.data['message']);
      }
    } catch (e) {
      print(e);
      throw Exception("Something wen't wrong");
    }
  }
}

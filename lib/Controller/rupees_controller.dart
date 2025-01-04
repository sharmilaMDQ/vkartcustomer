import 'package:get/get.dart';
import 'package:dio/dio.dart'as dio;
import 'package:vkartcustomer/ApiConfig/service/rupees_symbol_api_service.dart';

class RupeesController extends GetxController {

RxBool isLoading = false.obs;

RupeesSymbolApiService rupeessymbolapiservice = RupeesSymbolApiService();

getcurrencyruppes()async{

  isLoading(true);
  dio.Response<dynamic> response = await rupeessymbolapiservice.rupeesymbolApi();

  isLoading(false);
  if(response.statusCode==200){
    
  }
  
}
}
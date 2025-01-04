
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart'as dio;
import 'package:motion_toast/motion_toast.dart';
import 'package:vkartcustomer/ApiConfig/service/settings/add_feedback_api_service.dart';
import 'package:vkartcustomer/ApiConfig/service/settings/get_profile_api_service.dart';
import 'package:vkartcustomer/ApiConfig/service/settings/get_update_api_service.dart';
import 'package:vkartcustomer/ApiConfig/service/settings/query/add_querys_api_service.dart';
import 'package:vkartcustomer/ApiConfig/service/settings/query/get_querys_option_api_service.dart';
import 'package:vkartcustomer/Models/settings/add_querys_model.dart';
import 'package:vkartcustomer/Models/settings/feedbackMOdel.dart';
import 'package:vkartcustomer/Models/settings/get_querys_option_model.dart';
import 'package:vkartcustomer/Models/settings/profile_model.dart';
import 'package:vkartcustomer/Models/settings/profile_update_model.dart';

import '../../Helper/Helper.dart';

class SettingsController extends GetxController {

RxBool isLoading = false.obs;
late BuildContext context;
// var responseMessage = ''.obs; 
  var rating = 0.0.obs;
    RxBool feedbackSuccess = false.obs;
     TextEditingController reviewTextController = TextEditingController();



GetProfileApiService  getprofileapiservice = GetProfileApiService();
 ProfileData? profiledata;
  FeedBackDatum? feeddata;

 getprofile({required String customerId})async{

  isLoading(true);
  dio.Response<dynamic> response = await getprofileapiservice.getprofileApi(customerId: customerId);

  isLoading(false);
  if(response.statusCode==200){
    ProfileModel profilemodel = ProfileModel.fromJson(response.data);
    profiledata = profilemodel.data;
    update();
  }
  else{
   _showErrorToast(response.statusMessage.toString());
  }

 }
//profile update

GetUpdateApiService getupdateapiservice = GetUpdateApiService();

getupdateprofile({required ProfileUpdateModel profileupdatemodel,required BuildContext context})async{
  isLoading(true);
  dio.Response<dynamic> response = await getupdateapiservice.getupdateApi(profileupdatemodel: profileupdatemodel);

  isLoading(false);
  if(response.statusCode==200){
    MotionToast.success(
        title:  Text("Success", style: TextStyle(color: Colors.black, fontSize: 14)),
        description: Text(response.data["message"], style: const TextStyle(color: Colors.white, fontSize: 12)),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 60,
        borderRadius: 10,
        displaySideBar: false,
        enableAnimation: false,
      ).show(context);
      update();
    // _showErrorToast(response.statusMessage.toString());
  }else{
     MotionToast.error(
        title:  Text("Error", style: TextStyle(color: Colors.black, fontSize: 14)),
        description: Text(response.data["message"], style: const TextStyle(color: Colors.white, fontSize: 12)),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 60,
        borderRadius: 10,
        displaySideBar: false,
        enableAnimation: false,
      ).show(context);
  }
}

//messsage
 void _showErrorToast(String message) {
    final context = Get.context;
    if (context != null) {
      MotionToast.error(
        title: const Text("Error", style: TextStyle(color: Colors.black, fontSize: 14)),
        description: Text(message, style: const TextStyle(color: Colors.white, fontSize: 12)),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 60,
        borderRadius: 10,
        displaySideBar: false,
        enableAnimation: false,
      ).show(context);
    }
  }

  //querysoption

  GetQuerysOptionApiService getquerysoptionapiservice = GetQuerysOptionApiService();
  List<QuerysoptionData> queryoptiondata = [];

  getquerysoption()async{
    isLoading(true);
    dio.Response<dynamic> response = await getquerysoptionapiservice.getquerysoptionAPi();

    isLoading(false);
    if(response.statusCode==200){
     GetqureyoptionModel getqureyoptionModel = GetqureyoptionModel.fromJson(response.data);
      queryoptiondata = getqureyoptionModel.data;
      update();
    }
    else{
      
    }
  }

  //add query

  AddQuerysApiService addqueryapiservice = AddQuerysApiService();
  
  getaddQerys({required AddQuerysModel addquerysmodel,required BuildContext context})async{

    isLoading(true);
    dio.Response<dynamic>response = await addqueryapiservice.addQuerysApi(addquerysmodel: addquerysmodel);


    isLoading(false);
    if(response.statusCode==200){
      MotionToast.success(
        title:  Text("Success", style: TextStyle(color: Colors.black, fontSize: 14)),
        description: Text(response.data["message"], style: const TextStyle(color: Colors.white, fontSize: 12)),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 60,
        borderRadius: 10,
        displaySideBar: false,
        enableAnimation: false,
      ).show(context);
       //_showErrorToast(response.data["message"].toString());
      update();
    }else{
      _showErrorToast(response.statusMessage.toString());
    }

  }
 void setLoading(bool value) {
    isLoading.value = value;
    update();
  }
   
     AddFeedbackApiService addfeedbackapiservice = AddFeedbackApiService();

  Future<void> addfeedback({required int customerId, required String rating,required String reviewText}) async {
    try {
      setLoading(true);

      dio.Response<dynamic> response = await addfeedbackapiservice.addfeedbackApi(
        customerId: customerId,
        rating: rating, 
        reviewText: reviewText,
      );

      setLoading(false);

      if (response.statusCode == 200) {
        feedbackSuccess.value = true;
      } else {
        feedbackSuccess.value = false;
      }
    } catch (e) {
      setLoading(false);
      feedbackSuccess.value = false;
    } finally {
      update();
    }
  }

  // //addfeed

  // AddFeedbackApiService addfeedbackapiservice = AddFeedbackApiService();

  // addfeedback({required int customerId, required String rating})async{
  //   isLoading(true);
  //   dio.Response<dynamic> response = await addfeedbackapiservice.addfeedbackApi(customerId: customerId, rating: rating);

  //   isLoading(false);
  //   if(response.statusCode==200){
  //     _showErrorToast(response.statusMessage.toString());
  //     update();
  //   }else{
  //     _showErrorToast(response.statusMessage.toString());
  //   }
  // }

  getFeedBack({required String customerId})async{

    isLoading(true);
    dio.Response<dynamic> response = await addfeedbackapiservice.getFeedbackApi(customerId: customerId);

    isLoading(false);
    if(response.statusCode==200){
      GetFeedbackModel fmodel = GetFeedbackModel.fromJson(response.data);
      feeddata = fmodel.data;

      Helper.rating = feeddata!.rating;
      update();
    }
    else{
      _showErrorToast(response.statusMessage.toString());
    }

  }

   Future<void> refreshData() async {
    getprofile(customerId: Helper.customerID.toString());
    return Future.delayed(Duration(seconds: 0));
  }

}
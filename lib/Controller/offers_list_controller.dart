import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:vkartcustomer/ApiConfig/service/offers/offers_clicked_api_service.dart';
import 'package:vkartcustomer/ApiConfig/service/offers/offers_list_api_service.dart';
import 'package:vkartcustomer/ApiConfig/service/offers/offers_rowaddrs_api_service.dart';
import 'package:vkartcustomer/Models/offerslist_model/offers_click_model.dart';
import 'package:vkartcustomer/Models/offerslist_model/offers_list_model.dart';
import 'package:vkartcustomer/Models/offerslist_model/offers_row_adds_model.dart';

import '../Helper/Helper.dart';

class OffersListController extends GetxController {


  RxBool isLoading = false.obs;

  OffersData? offersdata;

  OffersListApiService offerslistapiservice = OffersListApiService();

  getslideroffers(context) async {
  
    isLoading(true);

    dio.Response<dynamic> response = await offerslistapiservice.offerslistAPi();

    isLoading(false);
    if (response.statusCode == 200) {
      OfferesSliderModel offerslidermodel = await OfferesSliderModel.fromJson(response.data);
      offersdata = offerslidermodel.data;
      //  Fluttertoast.showToast(
      //   msg: response.statusMessage!,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      // );
      update();
    } else {
       MotionToast.success(
        title: const Text("Success",
            style: TextStyle(color: Colors.black, fontSize: 14)),
        description: Text(response.statusMessage ?? "",
            style: TextStyle(color: Colors.white, fontSize: 12)),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 60,
        borderRadius: 10,
        displaySideBar: false,
        enableAnimation: false,
      ).show(context);
      // Fluttertoast.showToast(
      //   msg: response.statusMessage!,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      // );
    }
  }

  // offers clicked
  @override
void dispose() {
  offersclikeddata.clear(); // Clears the clicked data when the screen is disposed
  super.dispose();
}


  OffersClickedApiService offeresclickedapiservice = OffersClickedApiService();

  List<OffersClickData> offersclikeddata=[];

  getoffersclicked({required String type , required String sellerid, required String contentId, required String coustomerId,})async{

   // isLoading(true);
    offersclikeddata.clear();
    dio.Response<dynamic> response = await offeresclickedapiservice.offersclickedApi(
      type: type, contentId: contentId, sellerId: sellerid, coustomerId: coustomerId);

   // isLoading(false);
    if(response.statusCode==200){
     OffersClickModel offersclickedmodel = OffersClickModel.fromJson(response.data);
      offersclikeddata = offersclickedmodel.data;
      Helper.offerData = offersclikeddata;
      print(">>>>>>>>>>>>controller________${Helper.offerData!.length}");
      //Get.to(navigateBar(initialIndex: 1,));


    }
    update();
   }

   OffersRowaddrsApiService offersrowaddspiservice = OffersRowaddrsApiService();

   RowoffersData? rowoffersdata;

   getrowadds(BuildContext context)async{
   
    isLoading(true);
    dio.Response<dynamic> response = await offersrowaddspiservice.getrowaddsApi();

    isLoading(false);
    if(response.statusCode==200){
      OfferRowAddsModel offersrowaddsmodel = OfferRowAddsModel.fromJson(response.data);
      rowoffersdata = offersrowaddsmodel.data;
     update(); 
    }else{
        MotionToast.error(
        title: const Text("Error",
            style: TextStyle(color: Colors.black, fontSize: 14)),
        description: Text(response.statusMessage ?? "",
            style: TextStyle(color: Colors.white, fontSize: 12)),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 60,
        borderRadius: 10,
        displaySideBar: false,
        enableAnimation: false,
      ).show(context);
    }


   }
}

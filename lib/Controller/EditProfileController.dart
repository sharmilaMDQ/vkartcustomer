import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../Apiconnect/ApiConnect.dart';
import '../Components/image_pickers.dart';
import '../Models/ParticularCustomerResponseModel.dart';
import '../Models/RegisterIdResponse.dart';
import '../utility/AppPreference.dart';

class EditProfileScreenController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isVisible = false.obs;
  RxBool name = RxBool(false);
  RxBool mobilenum = RxBool(false);
  RxBool password = RxBool(false);
  RxBool address = RxBool(false);
  RxBool city = RxBool(false);
  RxBool state = RxBool(false);
  RxBool pincode = RxBool(false);
  RxBool isLoading = RxBool(false);
  RxBool country = RxBool(false);
  RxBool cusimage = RxBool(false);
  Rx<PickedImage?> item_image = Rx<PickedImage?>(null);
  RxString imageString = RxString("");
  RxBool isImageSelected = false.obs;
  ParticularCustomerResponseData? getParticularCustomer;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController mobilenumcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController countrycontroller = TextEditingController();
  TextEditingController deliverycontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopDescriptionController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  RxBool initialLoading = RxBool(true);
  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

  @override
  void onInit() async {
    super.onInit();
    getParticularCustomerApi();
  }

  RegisterApi(context) async {
    if (namecontroller.value.text.isEmpty) {
      name.value = true;
      Fluttertoast.showToast(
        msg: "Please enter Your Name!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
    if (mobilenumcontroller.value.text.isEmpty) {
      mobilenum.value = true;
      Fluttertoast.showToast(
        msg: "Please enter  Mobile Number!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    if (addresscontroller.value.text.isEmpty) {
      address.value = true;
      Fluttertoast.showToast(
        msg: "Please enter Your Address!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
    if (citycontroller.value.text.isEmpty) {
      city.value = true;
      Fluttertoast.showToast(
        msg: "Please enter Your City!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
    if (statecontroller.value.text.isEmpty) {
      state.value = true;
      Fluttertoast.showToast(
        msg: "Please enter Your State!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
    if (pincodecontroller.value.text.isEmpty) {
      pincode.value = true;
      Fluttertoast.showToast(
        msg: "Please enter Your Pincode!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
    if (countrycontroller.value.text.isEmpty) {
      country.value = true;
      Fluttertoast.showToast(
        msg: "Please enter Your Country!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    // MediaType contentType = MediaType.parse('image/jpeg');
    // MultipartFileExtended imageFile = multipartFileFromPathSync(
    //   item_image!.value!.file!.path,
    //   filename: item_image!.value!.file!.name,
    //   contentType: contentType,
    // );
    // Map<String, String> payload = {
    //   'customerName': namecontroller.value.text.toString(),
    //   'customerMobile': mobilenumcontroller.value.text.toString(),
    //   'customerPassword': passwordcontroller.value.text.toString(),
    //   'customerAddress': addresscontroller.value.text.toString(),
    //   'customerCity': citycontroller.value.text.toString(),
    //   'customerState': statecontroller.value.text.toString(),
    //   'customerPincode': pincodecontroller.value.text.toString(),
    //   'customerCountry': countrycontroller.value.text.toString(),
    //   'customerEmail': emailcontroller.text.toString(),
    //   // 'delivery': deliverycontroller.text.toString(),
    //   // customerName:
    //   // customerMobile:9941859792
    //   // customerPassword:
    //   // customerAddress:
    //   // customerCity:
    //   // customerState:
    //   // customerPincode:
    //   // customerCountry:
    //   // customerEmail:
    //   // delivery:home
    // };
    // print(payload);
    isLoading.value = true;
    RegisterCustomerIdResponse response;
    if (item_image.value == null) {
      // response = await _connect.registerUpload(payload, ApiUrl.editProfile);
    } else {
      //response = await _connect.imgRegisterCall(ApiUrl.editProfile, item_image.value!.file!, payload);
    }
    isLoading.value = false;
   // debugPrint("loginCallResponse: ${response.toJson()}");
    // if (!response.error!) {
    //   //  MotionToast.success(
    //   //   title: const Text("",
    //   //       style: TextStyle(color: Colors.black, fontSize: 14)),
    //   //   description: Text(response.message ?? "",
    //   //       style: TextStyle(color: Colors.white, fontSize: 12)),
    //   //   width: MediaQuery.of(context).size.width * 0.9,
    //   //   height: 60,
    //   //   borderRadius: 10,
    //   //   displaySideBar: false,
    //   //   enableAnimation: false,
    //   // ).show(context);
    //   // AppSnackBar.success(message: response.message!);
    //   Get.offNamed(AppRoutes.register.toName);
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => const navigateBar(
    //               initialIndex: 0,
    //             )),
    //   );
    //   getParticularCustomerApi();
    // } else {
    //   //  MotionToast.success(
    //   //   title: const Text("",
    //   //       style: TextStyle(color: Colors.black, fontSize: 14)),
    //   //   description: Text(response.message ?? "",
    //   //       style: TextStyle(color: Colors.white, fontSize: 12)),
    //   //   width: MediaQuery.of(context).size.width * 0.9,
    //   //   height: 60,
    //   //   borderRadius: 10,
    //   //   displaySideBar: false,
    //   //   enableAnimation: false,
    //   // ).show(context);
    //   // AppSnackBar.error(message: response.message!);
    // }
  }

  getParticularCustomerApi() async {
    print("SellerId ${AppPreference().UserId}");

    Map<String, dynamic> payload = {'customerId': AppPreference().UserId};
    print(" getParticularSeller_payload ${payload}");
    initialLoading.value = true;
    var response = await _connect.GetParticularCustomer(payload);
    initialLoading.value = false;
    print('getParticularSeller_Response${response.toJson()}');

    if (!response.error!) {
      // Fluttertoast.showToast(
      //   msg: response.message!,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      // );
      getParticularCustomer = response.data;
      namecontroller.text = response.data!.customerName!;
      mobilenumcontroller.text = response.data!.customerMobile!;
      countrycontroller.text = response.data!.customerCountry!;
      pincodecontroller.text = response.data!.customerPincode!.toString();
      statecontroller.text = response.data!.customerState!;
      citycontroller.text = response.data!.customerCity!;
      addresscontroller.text = response.data!.customerAddress!;
      emailcontroller.text = response.data!.customerEmail!;
      imageString.value = response.data!.customerProfile!;
    } else {
      // Fluttertoast.showToast(
      //   msg: response.message!,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      // );
    }
  }
}

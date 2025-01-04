import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';

import '../../Components/AppTheme.dart';
import '../../Components/Forms.dart';
import '../../Components/image_pickers.dart';
import '../../Controller/CreateAccountScreenController.dart';

List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: scopes,
);

class CreateAccountScreen extends GetView<CreateAccountScreenController> {
  CreateAccountScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final CreateAccountScreenController controller = Get.put(CreateAccountScreenController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text("Create Account",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18
        ),),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back,
          color: Colors.white,)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Column(
              
                children: [
                 SizedBox(
                  height: 20,
                 ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                       Text(
                    'Create account to see top pick for you!',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                   Text(
                        'Lets Get Started',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                 
                  SizedBox(
                    height: 25,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Center(
                            child: Stack(children: [
                          Obx(
                            () => Container(
                              width: 120,
                              height: 120,
                              child: controller.item_image.value != null
                                  ? CircleAvatar(
                                      backgroundImage: Image.file(
                                        controller.item_image.value?.imagePath,
                                        fit: BoxFit.cover,
                                      ).image,
                                    )
                                  : controller.imageString.value != null && controller.imageString.value.isNotEmpty
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(controller.imageString.value),
                                        )
                                      : const CircleAvatar(
                                          backgroundImage:
                                              NetworkImage('https://autorevog.blob.core.windows.net/autorevog/uploads/images/18942381.jpg'),
                                        ),
                            ),
                          ),
                          Positioned(
                            right: -25,
                            bottom: 5,
                            child: MaterialButton(
                                color: AppTheme.primaryColor,
                                shape: const CircleBorder(),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ImagePicks(
                                                previewImageList: [],
                                                isMultiple: true,
                                                title: "Select Image",
                                                onClose: () => Get.back(),
                                                onSave: (List<PickedImage> images) {
                                                  if (images.isNotEmpty) {
                                                    controller.item_image.value = images.first;
                                                  }
                                                  Get.back();
                                                },
                                              )));
                                },
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                )),
                          ),
                        ])), 
                      
                        const SizedBox(
                          height: 30,
                        ),
                        TextInput1(
                          label: "First Name",
                          onPressed: () {},
                          contentPaddingV: 15,
                          controller: controller.namecontroller,
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          hintText: "Enter  Your Name",
                          onTextChange: (String) {},
                        ),
                      SizedBox(
                          height: 7,
                        ),
                        TextInput1(
                          label: "Last Name",
                          onPressed: () {},
                          contentPaddingV: 15,
                          controller: controller.lastnamecontroller,
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          hintText: "Enter Your Last Name",
                          
                          onTextChange: (String) {},
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        TextInput1(
                          label: "EmailId",
                          onPressed: () {},
                          contentPaddingV: 15,
                          controller: controller.emailcontroller,
                          textInputType: TextInputType.emailAddress,
                          textColor: Color(0xCC252525),
                          hintText: "Enter Your Last EmailId",
                          onTextChange: (String) {},
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        TextInput1(
                          label: "Mobile Number",
                          onPressed: () {},
                          contentPaddingV: 15,
                          controller: controller.mobilenumcontroller,
                          textInputType: TextInputType.number,
                          textColor: Color(0xCC252525),
                          hintText: "Enter  Your Mobile Number",
                          onTextChange: (String) {},
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Obx(
                          () => TextInput1(
                              // height: 300,
                              label: "Password ",
                              onPressed: () {},
                              onPressedSuffixIcon: () {
                                controller.toggleVisibility();
                              },
                              contentPaddingV: 15,
                              controller: controller.passwordcontroller,
                              textInputType: TextInputType.text,
                              obscureText: true,
                              textVisible: !controller.isVisible.value,
                              textColor: Color(0xCC252525),
                              hintText: "Enter Password",
                              onTextChange: (String) {},
                              sufficIcon: controller.isVisible.value
                                  ? Icon(
                                      Icons.visibility,
                                      color: AppTheme.Buttoncolor,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: AppTheme.Buttoncolor,
                                    )),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        TextInput1(
                          label: "Address",
                          onPressed: () {},
                          contentPaddingV: 15,
                          controller: controller.addresscontroller,
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          hintText: "Enter Your Address",
                          onTextChange: (String) {},
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        TextInput1(
                          label: "City",
                          onPressed: () {},
                          contentPaddingV: 15,
                          controller: controller.citycontroller,
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          hintText: "Enter Your City",
                          onTextChange: (String) {},
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        TextInput1(
                          label: "State",
                          onPressed: () {},
                          contentPaddingV: 15,
                          controller: controller.statecontroller,
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          hintText: "Enter Your State",
                          onTextChange: (String) {},
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        TextInput1(
                          label: "PinCode",
                          onPressed: () {},
                          contentPaddingV: 15,
                          controller: controller.pincodecontroller,
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          hintText: "Enter Your PinCode",
                          onTextChange: (String) {},
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        TextInput1(
                          label: "Country",
                          onPressed: () {},
                          contentPaddingV: 15,
                          controller: controller.countrycontroller,
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          hintText: "Enter Your Country",
                          onTextChange: (String) {},
                        ),
                        
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Center(
                  //   child: Button(
                  //       widthFactor: 0.9,
                  //       heightFactor: 0.06,
                  //       onPressed: () {
                  //         if (_formKey.currentState!.validate()) {
                  //           controller.RegisterApi(context);
                  //         }
                  //       },
                  //       child: Text(
                  //         "Create Account",
                  //         style: GoogleFonts.poppins(
                  //           color: Colors.white,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       )),
                  // ),
                   // Login button
                Obx(
                  () {
                  
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            fixedSize: const Size(290, 50),
                            backgroundColor: AppTheme.Buttoncolor,
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                            
                              controller.RegisterApi(context);
                              // controller.isLoading.value?Lottie.asset("assets/icons/Animation - 1735798051072.json",
                              // height: 300,width: 300,fit: BoxFit.fill):"";
                            }
                          },
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    strokeWidth: 3,
                                  ),
                                )
                              : Text(
                                  "Create Account".tr,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("If You Have Account?",
                    style: GoogleFonts.poppins(
                      fontSize: 12
                    ),),
                    Text(" Please Login",
                    style: GoogleFonts.poppins(
                      fontSize: 13.5,
                      color: Colors.green,
                      fontWeight: FontWeight.w700
                    ),)
                  ],
                ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

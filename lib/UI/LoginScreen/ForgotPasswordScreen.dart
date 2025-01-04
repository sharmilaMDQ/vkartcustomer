
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../Components/AppTheme.dart';
import '../../Components/Forms.dart';
import '../../Controller/ForgotPasswordScreenController.dart';  

class ForgotPasswordScreen extends GetView<ForgotPasswordScreenController> {
  @override
  Widget build(BuildContext context) { 
    return GetBuilder<ForgotPasswordScreenController>(
      init: ForgotPasswordScreenController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 45,
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            title: Text(
              'Forgot Password',
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'We will send an email with a confirmation\n'
                          'code to this number',
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TextInput1(
                      label: "Mobile Number",
                      onPressed: () {},
                      contentPaddingV: 15,
                      controller: controller.usercontroller,
                      textInputType: TextInputType.number,
                      textColor: Color(0xCC252525),
                      hintText: "Enter Your Mobile Number",
                      onTextChange: (String) {},
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  // Lottie animation when OTP is sent successfully
                  Obx(
                    () => controller.isLoading.value
                        ? Lottie.asset(
                            'assets/icons/Animation - 1735627705840 (1).json', // Path to Lottie animation
                            width: 250,
                            height: 250,
                            fit: BoxFit.fill,
                          )
                        : SizedBox(), // Hide animation when not loading
                  ),

                  // Next Button
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        fixedSize: const Size(290, 50),
                        backgroundColor: AppTheme.Buttoncolor,
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (controller.isLoading.value) return;

                        // Set loading to true to show the animation
                        controller.isLoading.value = true;
                        controller.ForgotPasswordApi(context);
                        controller.startResendTimer();
                      },
                      child: Obx(
                        () {
                          // Check if the timer is still active or the button is in loading state
                          if (controller.isLoading.value) {
                            return const SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 3,
                              ),
                            );
                          } else if (!controller.isResendButtonActive.value) {
                            // Show "Send" text when the button is not in resend state
                            return Text(
                              "Resend".tr,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          } else {
                            // Show the text for the button once the timer finishes
                            return Text(
                              "Send".tr,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => controller.isResendButtonActive.value
                        ? Text('')
                        : TextButton(
                            onPressed: () {
                              if (controller.isResendButtonActive.value) {
                                controller.ForgotPasswordApi(context);
                                controller.startResendTimer();
                              }
                            },
                            child: Text(
                                'Resend OTP in ${controller.timerSeconds.value} sec'),
                          ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

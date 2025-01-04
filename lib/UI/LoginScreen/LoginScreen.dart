import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:vkartcustomer/ApiConfig/ApiUrl.dart';
import 'package:vkartcustomer/Components/AppTheme.dart';
import '../../Components/Forms.dart';
import '../../Controller/LoginScreenController.dart';
import 'CreateAccountScreen.dart';
import 'ForgotPasswordScreen.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginScreenController controller = Get.put(LoginScreenController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GetBuilder<LoginScreenController>(
      init: LoginScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Top section with curved design and character image
                Stack(
                  children: [
                    Container(
                      height: height * 0.3,
                      decoration: const BoxDecoration(
                        color: AppTheme.Buttoncolor, // Background color
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          //bottomRight: Radius.circular(20), // Curved bottom-left corner
                        ),
                      ),
                    ),
                  
                    Positioned(
                      right: 20,
                      bottom: 10,
                      child: Image.asset(
                        'assets/images/rb_175922.png', // Replace with your character image path
                        height: 180,
                      ),
                    ),
                    Positioned(
                       bottom: 2,
                        left: 60,
                      child: Lottie.asset("assets/icons/Animation - 1735810754821.json",
                      height: 100,
                      fit: BoxFit.fill)),
                    // Positioned(
                    //   right: 27,
                    //   bottom: 0,
                    //   //left: 20,
                    //   child: Lottie.asset(
                    //     'assets/icons/Animation - 1735809492231.json', // Replace with your character image path
                    //     height: 180,
                    //   ),
                    // ),
                  ],
                ),

                SizedBox(height: height * 0.05),

                // "Login to continue" text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Login to continue',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                SizedBox(height: height * 0.05),

                // Mobile number input
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInput1(
                    label: "Mobile Number",
                    onPressed: () {},
                    contentPaddingV: 15,
                    MaxLength: 10,
                    controller: controller.mobileNumberController,
                    textInputType: TextInputType.number,
                    textColor: const Color(0xCC252525),
                    hintText: "Enter Your Mobile Number",
                    onTextChange: (text) {},
                  ),
                ),

                SizedBox(height: 20),

                // Password input with visibility toggle
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInput1(
                      label: "Password",
                      onPressed: () {},
                      onPressedSuffixIcon: controller.toggleVisibility,
                      contentPaddingV: 15,
                      controller: controller.passwordController,
                      textInputType: TextInputType.text,
                      obscureText: true,
                      textVisible: !controller.isVisible.value,
                      textColor: const Color(0xCC252525),
                      hintText: "Enter Password",
                      sufficIcon: controller.isVisible.value
                          ? const Icon(Icons.visibility, color: AppTheme.Buttoncolor)
                          : const Icon(Icons.visibility_off, color: AppTheme.Buttoncolor),
                      onTextChange: (text) {},
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Forgot Password
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Image.asset(
                      //   'assets/images/rb_175922.png', // Replace with the correct path
                      //   height: 15,
                      // ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          Get.to(() => ForgotPasswordScreen());
                        },
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.1),

                // Login button
                Obx(
                  () {
                    bool isButtonEnabled = controller.mobileNumber.isNotEmpty && controller.password.isNotEmpty;
                    return Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          fixedSize: const Size(290, 50),
                          backgroundColor: AppTheme.Buttoncolor,
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (controller.isLoading.value) return;
                          controller.loginApi(context);
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
                                "Login".tr,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      ),
                    );
                  },
                ),

                SizedBox(height: height * 0.03),

                // Create account link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.poppins(
                        color: const Color(0x80252525),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => CreateAccountScreen());
                      },
                      child: Text(
                        ' Create?',
                        style: GoogleFonts.poppins(
                          color: AppTheme.Buttoncolor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: height * 0.06),

                // App version
                Text(
                  ApiUrl.appVersion,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Components/AppTheme.dart';
import '../../Components/Forms.dart';
import '../../Controller/ChangePasswordScreenController.dart';


class ChangePasswordScreen extends GetView<ChangePasswordScreenController> {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChangePasswordScreenController passwordController =
        Get.put(ChangePasswordScreenController());
    return GetBuilder<ChangePasswordScreenController>(
      init: ChangePasswordScreenController(),
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50, left: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppTheme.IconBackground,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: AppTheme.Buttoncolor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Change Password ',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Enter Your New Password ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black26),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: TextFormField(
                        obscureText: !passwordController.isVisible.value,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppTheme.Buttoncolor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppTheme.Buttoncolor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: ' Current password',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.black26,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              passwordController.toggleVisibility();
                            },
                            child: Icon(
                              color: AppTheme.Buttoncolor,
                              passwordController.isVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black26)),
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: TextFormField(
                        obscureText: !passwordController.isVisible.value,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppTheme.Buttoncolor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppTheme.Buttoncolor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                          hintText: '   New password',
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.black26,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              passwordController.toggleVisibility();
                            },
                            child: Icon(
                              color: AppTheme.Buttoncolor,
                              passwordController.isVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black26)),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Button(
                      widthFactor: 0.9,
                      heightFactor: 0.06,
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => navigateBar()));
                      },
                      child: const Text("Change",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600))),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

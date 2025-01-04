import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../Components/AppTheme.dart';
import '../../Components/Forms.dart';
import '../../Controller/VerifyNumberScreenController.dart';
import '../../utility/BottomNavigationBar.dart';

class VerifyNumberScreen extends GetView<VerifyNumberScreenController> {
  const VerifyNumberScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyNumberScreenController>(
      init: VerifyNumberScreenController(),
      builder: (controller) {
        return Scaffold(
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, left: 20),
                    child: Container(
                      height: 40,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppTheme.IconBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppTheme.Buttoncolor,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
                      'Verify your number ',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),
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
                      'Enter  the 4- digit code we sent you  ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black26),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  4,
                  (index) => SizedBox(
                    width: 60,
                    height: 50,
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppTheme.Buttoncolor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppTheme.Buttoncolor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black26),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            if (index < 3) {
                              FocusScope.of(context).nextFocus();
                            } else {
                              FocusScope.of(context).unfocus();
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Expired 00:59',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.red),
                    ),
                    Text(
                      'Resend Code',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppTheme.Buttoncolor),
                    ),
                  ],
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => navigateBar(
                                  initialIndex: 0,
                                )),
                      );
                    },
                    child: const Text("Continue", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600))),
              ),
            ],
          ),
        );
      },
    );
  }
}
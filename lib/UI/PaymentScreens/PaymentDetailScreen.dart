import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/AppTheme.dart';
import '../../Components/Forms.dart';
import '../../Controller/PaymentDetailController.dart';

class PaymentDetailScreen extends GetView<PaymentDetailController> {
  PaymentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    PaymentDetailController homeController = Get.put(PaymentDetailController());
    return GetBuilder<PaymentDetailController>(
      init: PaymentDetailController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppTheme.Buttoncolor,
          appBar: AppBar(
            backgroundColor: AppTheme.Buttoncolor,
            automaticallyImplyLeading: false,
            bottomOpacity: 0.0,
            elevation: 0.0,
            toolbarHeight: 100,
            leading: Padding(
              padding: EdgeInsets.only(top: 25, bottom: 25, right: 0, left: 15),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 30,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
            title: Text("Payment detail",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
            centerTitle: true,
            actions: <Widget>[],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
            decoration:
                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Total Amount',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  //
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TextInput1(
                      height: 300,
                      label: " Total Amount",
                      onPressed: () {},
                      controller: controller.totalAmountController,
                      contentPaddingV: 15,
                      textInputType: TextInputType.number,
                      textColor: Color(0xCC252525),
                      hintText: "Enter Total Amount",
                      onTextChange: (String) {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Payment method',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  //
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TextInput1(
                      height: 300,
                      label: "Payment",
                      onPressed: () {},
                      controller: controller.paymentController,
                      contentPaddingV: 15,
                      textInputType: TextInputType.number,
                      textColor: Color(0xCC252525),
                      hintText: "Enter Payment",
                      onTextChange: (String) {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Card Expiry date',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: Container(
                          width: width / 2.1,
                          child: TextInput1(
                            height: 300,
                            label: "From Date",
                            onPressed: () {
                              DateTime now = DateTime.now();
                              showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 250,
                                      child: CupertinoDatePicker(
                                        onDateTimeChanged: (DateTime newTime) {
                                          String date =
                                              "${newTime.year}-${newTime.month.toString().length <= 1 ? "0${newTime.month}" : newTime.month.toString()}-${newTime.day.toString().length <= 1 ? "0${newTime.day}" : newTime.day.toString()}";
                                          controller.fromDateController.text = date;
                                        },
                                        minimumDate: DateTime(now.year - 104, now.month, now.day),
                                        maximumDate: DateTime.now(),
                                        initialDateTime: DateTime(2001, 5, 5),
                                        use24hFormat: true,
                                        mode: CupertinoDatePickerMode.date,
                                      ),
                                    );
                                  });
                            },
                            isReadOnly: true,
                            controller: controller.fromDateController,
                            contentPaddingV: 15,
                            textInputType: TextInputType.text,
                            textColor: Color(0xCC252525),
                            hintText: "yyyy-mm-dd",
                            onTextChange: (String) {},
                            obscureText: true,
                            sufficIcon: Icon(Icons.date_range_rounded),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          width: width / 2.1,
                          child: TextInput1(
                            obscureText: true,
                            sufficIcon: Icon(Icons.date_range_rounded),
                            height: 300,
                            label: "To Date",
                            onPressed: () {
                              DateTime now = DateTime.now();
                              showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 250,
                                      child: CupertinoDatePicker(
                                        onDateTimeChanged: (DateTime newTime) {
                                          String date =
                                              "${newTime.year}-${newTime.month.toString().length <= 1 ? "0${newTime.month}" : newTime.month.toString()}-${newTime.day.toString().length <= 1 ? "0${newTime.day}" : newTime.day.toString()}";
                                          controller.fromDateController.text = date;
                                        },
                                        minimumDate: DateTime(now.year - 104, now.month, now.day),
                                        maximumDate: DateTime.now(),
                                        initialDateTime: DateTime(2001, 5, 5),
                                        use24hFormat: true,
                                        mode: CupertinoDatePickerMode.date,
                                      ),
                                    );
                                  });
                            },
                            isReadOnly: true,
                            controller: controller.toDateController,
                            contentPaddingV: 15,
                            textInputType: TextInputType.text,
                            textColor: Color(0xCC252525),
                            hintText: "yyyy-mm-dd",
                            onTextChange: (String) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Card number',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  //
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TextInput1(
                      height: 300,
                      label: "Card number",
                      onPressed: () {},
                      contentPaddingV: 15,
                      controller: controller.cardNumberController,
                      textInputType: TextInputType.text,
                      textColor: Color(0xCC252525),
                      hintText: "Enter Card number",
                      onTextChange: (String) {},
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Security code',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  //
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TextInput1(
                      height: 300,
                      label: "Security code",
                      onPressed: () {},
                      contentPaddingV: 15,
                      controller: controller.securityCodeController,
                      textInputType: TextInputType.text,
                      textColor: Color(0xCC252525),
                      hintText: "Enter Security code",
                      onTextChange: (String) {},
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Button(
                      widthFactor: 0.9,
                      heightFactor: 0.06,
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => CreateAccountScreen()));
                      },
                      child: const Text(
                        "Pay now",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

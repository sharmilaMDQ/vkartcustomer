import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Components/AppTheme.dart';
import '../../Controller/AddressViewController.dart';
import '../../Forms/AppText.dart';
import '../../Forms/TextFormsFiled.dart';
import '../../utility/AppColor.dart';

class DetailedAddress extends GetView<AddressViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(CupertinoIcons.arrow_left),
                  ),
                  AppText('Select Delivery Location'),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: GoogleMap(
                  myLocationEnabled: false,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition: controller.initialPosition,
                  onMapCreated: (GoogleMapController googleMapController) {
                    controller.mapController.complete(googleMapController);
                  },
                  onCameraMove: controller.onCameraMove,
                ),
              ),
              SizedBox(height: 5),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 10),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.location_fill,
                          size: 23,
                          color: AppColors.buttonBgColor,
                        ),
                        Text(
                          controller.locality.value,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            controller.fullAddress.value,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xffFFFCF6).withOpacity(0.5),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'A detailed address will help our Delivery Partner reach your doorstep easily',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.brown.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Address input fields
              ..._buildAddressFields(context),
              // Address type selection
              _buildAddressTypeSelection(),
              // Default address checkbox
              _buildDefaultAddressCheckbox(),
              // Add address button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.Buttoncolor,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  onPressed: () {
                    controller.addAddresses(context);
                  },
                  child: Text(
                    "Add Address",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAddressFields(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: TextFormsField(
          title: "House / Flat / Block No",
          validate: controller.houseNo.value,
          hintText: "House / Flat / Block No",
          errorText: controller.houseNoErrorText.value,
          controller: controller.customerHouseNocontroller,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: TextFormsField(
          title: "Apartment / Road / Area (Optional)",
          hintText: "Apartment / Road / Area (Optional)",
          controller: controller.customerApartmentcontroller,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: TextFormsField(
          title: "Landmark",
          hintText: "Enter Landmark (Optional)",
          controller: controller.customerLandmarkController,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: TextFormsField(
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          title: "Mobile Number",
          hintText: "Enter Your Mobile Number  (Optional)",
          controller: controller.mobileNumberController,
        ),
      ),
    ];
  }

  Widget _buildAddressTypeSelection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 12.0,
        runSpacing: 8.0,
        children: ["Home", "Work", "Family", "Other"]
            .map((type) => Obx(() {
                  return InkWell(
                    onTap: () {
                      controller.addressType.value = type;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: controller.addressType.value == type
                            ? AppTheme.Buttoncolor.withOpacity(0.5)
                            : AppColors.white,
                        border: Border.all(
                          color: controller.addressType.value == type
                              ? AppTheme.Buttoncolor
                              : Colors.grey.withOpacity(0.7),
                        ),
                        boxShadow: controller.addressType.value == type
                            ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(2, 2),
                                  blurRadius: 5,
                                ),
                              ]
                            : [],
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(CupertinoIcons.checkmark_circle,
                              size: 18, color: Colors.black),
                          SizedBox(width: 8),
                          AppText(type),
                        ],
                      ),
                    ),
                  );
                }))
            .toList(),
      ),
    );
  }

  Widget _buildDefaultAddressCheckbox() {
    return Obx(() {
      return Row(
        children: [
          Checkbox(
            value: controller.isDefaultAddress.value,
            onChanged: (bool? newValue) {
              controller.isDefaultAddress.value = newValue ?? false;
            },
            activeColor: AppTheme.Buttoncolor,
          ),
          AppText('Default Address'),
        ],
      );
    });
  }
}

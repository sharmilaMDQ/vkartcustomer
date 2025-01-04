import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Components/AppTheme.dart';
import '../../Components/Forms.dart';
import '../../Controller/AddNewAddressController.dart';
import '../../Helper/Helper.dart';
import '../../Models/GetCustomerAddressResponseModel.dart';
import '../CartScreen/checkOutScreen.dart';
import 'MapAddresses.dart';

/*class AddNewAddressScreen extends GetView<AddNewAddressController> {
  AddNewAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        Get.off(() => CheckOutScreen());
        return false;
      },
      child: Scaffold(
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Button(
                widthFactor: 0.8,
                heightFactor: 0.06,
                onPressed: () {
                  if (controller.selectedAddress.value != null) {
      Get.off(() => CheckOutScreen(), arguments: controller.selectedAddress.value);
    } else {
      Get.snackbar("Error", "Please select an address before confirming.");
    }
                },
                child: Text(
                  "Confirm",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
        appBar: AppBar(
          backgroundColor: AppTheme.Buttoncolor,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          toolbarHeight: 50,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () {
              Get.off(() => CheckOutScreen());
            },
          ),
          title: Text(
            "Addresses",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  Get.to(() => AddressView());
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.grey.shade400),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.my_location, size: 20, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      "Choose Current Location",
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 0.05,
                width: double.infinity,
                color: Colors.white24,
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => AddressView());
                    },
                    child: Text(
                      "+ADD NEW ADDRESS",
                      style: GoogleFonts.poppins(
                        color: AppTheme.Buttoncolor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.Buttoncolor,
                          ),
                        )
                      : controller.getAddressesList.isEmpty
                          ? Center(child: Image.asset("assets/images/nodata.png"))
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.getAddressesList.length,
                              itemBuilder: (context, index) {
                                var model = controller.getAddressesList[index];
                                return AddressCard(
                                  index: index,
                                  model: model,
                                  controller: controller,
                                );
                              },
                            ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}*/

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> with SingleTickerProviderStateMixin{
  final controller = Get.put(AddNewAddressController());
       late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
   // ApiCall();
    super.initState();
                          // Initialize AnimationController and animations
  _animationController = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  );

  // Initialize _fadeInAnimation after AnimationController is initialized
  _fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ),
  );

  _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    ),
  );

  // Start the animation
  _animationController.forward();
   Future.delayed(Duration(seconds: 1),(){
       setState(() {

       });
     });
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        Get.off(() => CheckOutScreen());
        return false;
      },
      child: Scaffold(
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Button(
                widthFactor: 0.8,
                heightFactor: 0.06,
                onPressed: () {
                  if (controller.selectedAddress.value != null) {
                    Get.off(() => CheckOutScreen(), arguments: controller.selectedAddress.value);
                  } else {
                    Get.snackbar("Error", "Please select an address before confirming.");
                  }
                },
                child: Text(
                  "Confirm",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
        appBar: AppBar(
          backgroundColor: AppTheme.Buttoncolor,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          toolbarHeight: 50,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () {
              Get.back();
              // Get.off(() => CheckOutScreen());
            },
          ),
          title: Text(
            "Addresses",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: FadeTransition(
               opacity: _fadeInAnimation,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  TextButton(
                    onPressed: () {
                      Get.to(() => AddressView());
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.grey.shade400),
                      minimumSize: Size(400, 50),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.my_location, size: 20, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Text(
                          "Choose Current Location",
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.05,
                    width: double.infinity,
                    color: Colors.white24,
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => AddressView());
                        },
                        child: Text(
                          "+ADD NEW ADDRESS",
                          style: GoogleFonts.poppins(
                            color: AppTheme.Buttoncolor,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
              
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    child: /*controller.isLoading.value
                        ? Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.Buttoncolor,
                      ),
                    )
                        :*/ Helper. customerAddress!.isEmpty
                        ? Center(child: Image.asset("assets/images/nodata.png"))
                        : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Helper. customerAddress!.length,
                      itemBuilder: (context, index) {
                        var model = Helper. customerAddress![index];
                        return AddressCard(
                          index: index,
                          model: model,
                          controller: controller,
                          customerAddress: Helper.customerAddress,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void ApiCall(){
    AddNewAddressController().getCustomerAddress();
    AddNewAddressController().deleteCustomerAddress(0, context);

    Future.delayed(Duration(seconds: 1),(){
      setState(() {
    
      });
    });
  }
} 


class AddressCard extends StatefulWidget {
  final int index;
  final dynamic model;
  final AddNewAddressController controller;
   List<GetCustomerAddresses>? customerAddress = [];

   AddressCard({
    Key? key,
    required this.index,
    required this.model,
    required this.controller,
     this.customerAddress
  }) : super(key: key);

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
     Future.delayed(Duration(seconds: 1),(){
        AddNewAddressController().getCustomerAddress();
       setState(() {

       });
     });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey.withOpacity(0.5),
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Radio<int>(
                value: widget.index,
                groupValue: widget.controller.selectedRadioIndex.value,
                onChanged: (int? value) {
                  if (value != null) {
                    Helper.location = "${widget.customerAddress![value].customerAddress.toString()}, ${widget.customerAddress![value].customerCity.toString()},${widget.customerAddress![value].customerState.toString()}, ${widget.customerAddress![value].customerPincode.toString()}, ${widget.customerAddress![value].customerCountry.toString()}";
                    Helper.deliveryPlace = widget.model.addressType.toString();
                    print('CHANGED ADDRESS ===>${ Helper.location}');
                    widget.controller.selectedRadioIndex.value = value;

                  if(widget.controller.getAddressesList.isNotEmpty){
                    var selectedAddress = widget.controller.getAddressesList[value];
                    widget.controller.selectedAddress.value = selectedAddress;

                    widget.controller.userDataProvider.setWholeAddress(
                      '${selectedAddress.customerAddress ?? ''}, '
                          '${selectedAddress.appartmentName ?? ''}, '
                          '${selectedAddress.landmark ?? ''}, '
                          '${selectedAddress.customerCity ?? ''}, '
                          '${selectedAddress.customerState ?? ''}, '
                          '${selectedAddress.customerPincode ?? ''}, '
                          '${selectedAddress.customerCountry ?? ''}',
                    );
                  }
                  }
                },
                activeColor: Colors.red,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => Text(
                          widget.controller.selectedRadioIndex.value == widget.index
                              ? "Selected Address: "
                              : widget.model.isDefault == "yes"
                                  ? "Default Address: "
                                  : "",
                          style: GoogleFonts.poppins(
                            color: widget.controller.selectedRadioIndex.value == widget.index
                                ? Colors.green
                                : Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.model.addressType.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.model.customerAddress ?? '',
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                  ),
                  Text(
                    "${widget.model.customerCity}, ${widget.model.customerState} - ${widget.model.customerPincode}",
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                  ),
                  if (widget.model.appartmentName?.isNotEmpty ?? false)
                    Text( 
                      "${widget.model.appartmentName} (Apartment Name)",
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                    ),
                  if (widget.model.landmark?.isNotEmpty ?? false)
                    Text(
                      "${widget.model.landmark} (Landmark)",
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                    ),
                  Text(
                    widget.model.mobileNumber.toString(),
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.edit, size: 20, color: Colors.grey),
                  onPressed: () {
                    Get.to(() => AddressView());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, size: 20, color: Colors.grey),
                  onPressed: () {
                    widget.controller.deleteCustomerAddress(widget.index, context);
                    Future.delayed(Duration(milliseconds: 500),(){
                           widget.controller.getCustomerAddress();
                    });
                   
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

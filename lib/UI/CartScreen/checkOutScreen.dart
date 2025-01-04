import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:vkartcustomer/Controller/AddNewAddressController.dart';
import 'package:vkartcustomer/Controller/FavouriteStoreScreenController.dart';
import 'package:vkartcustomer/Controller/order/order_controller.dart';
import '../../Components/AppTheme.dart';
import '../../Components/Forms.dart';
import '../../Controller/CheckOutScreenController.dart';
import '../../Forms/AppSnackBar.dart';
import '../../Helper/Helper.dart';
import '../Addresses/addNewAddressScreen.dart';
import 'CartScreen.dart';




class CheckOutScreen extends StatefulWidget {

  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen>with SingleTickerProviderStateMixin {
  bool isSelected = false;
  var totalpriceshow ;
  int sp =0;

  CheckOutScreenController controller = Get.put(CheckOutScreenController());
       late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;
  


  @override
  void initState() {
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
    
  }
  double totalAmount(String subtotal, String discount, String deliveryFee, String promoCodeDiscount) {
  // Convert all string inputs to double
  double subtotalValue = double.tryParse(subtotal) ?? 0.0;
  double discountValue = double.tryParse(discount) ?? 0.0;
  double deliveryFeeValue = double.tryParse(deliveryFee) ?? 0.0;
  double promoCodeDiscountValue = double.tryParse(promoCodeDiscount) ?? 0.0;

  // Calculate the total amount
  return subtotalValue - discountValue + deliveryFeeValue - promoCodeDiscountValue;
}

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;

    final addressController = Get.put(FavouriteStoreScreenController());
    final showselectedController = Get.put(AddNewAddressController());
    final orderdateController = Get.find<OrderController>();
    final selectedAddress = Get.arguments;


    print("jtjftjfd${controller.CartProdct.length}");

    return WillPopScope(
      onWillPop: () async {
        Get.off(() => CartScreen());
        return false;
      },
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerTheme: const DividerThemeData(
            color: Colors.transparent,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          persistentFooterButtons: [
            // controller.CartProdct.value.isNotEmpty
            ScaleTransition(
               scale: _scaleAnimation,
              child: FadeTransition(
                 opacity: _fadeInAnimation, 
                child: Column(
                  children: [
                    Obx(
                          () => controller.isLoading.value
                          ? CircularProgressIndicator()
                          : Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: height * 0.24,
                            width: double.infinity,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text("Order Summary",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    )),
                               
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Discount",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                        )),
                                    Text(" -₹${controller.getCartInfos.discount.toString()}",
                                        style: GoogleFonts.poppins(
                                          color: Colors.red,
                                          fontSize: 15,
                                        )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Delivery Charges",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                        )),
                                    Text("₹ ${controller.getCartInfos.deliveryFee.toString()}",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                        )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Promo Code Discount",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                        )),
                                    Text("₹ ${controller.applyCoupon.promoCodeDiscount?.toString() ?? 0}",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                        )),
                                  ],
                                ),
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                        )),
                                    Text("₹ ${(controller.getCartInfos.total)}",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                        )),
                                  ],
                                ),
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Sub Total",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                        )),
                                    Text("₹ ${(controller.getCartInfos.subtotal.toString())}",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                        )),
                                  ],
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(0.5),
                                  thickness: 0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Your Order Total',
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600
                                        )),
                            Text(
                  '₹ ${totalAmount(
                        controller.getCartInfos.subtotal.toString(),
                        controller.getCartInfos.discount.toString(),
                        controller.getCartInfos.deliveryFee.toString(),
                        (controller.applyCoupon.promoCodeDiscount?.toString() ?? '0.0'))
                        .toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                
                
                                  ],
                                ),
                
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Button(
                      widthFactor: 0.8,
                      heightFactor: 0.06,
                      onPressed: () {
                        // Mobile number validation
                final mobileNumber = controller.mobileNumberController.text.trim();
                
                // Remove all non-digit characters to ensure only digits are considered
                final cleanedNumber = mobileNumber.replaceAll(RegExp(r'\D'), '');
                
                if (cleanedNumber.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "Please enter your mobile number",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                  );
                } else if (cleanedNumber.length != 10) {
                  Fluttertoast.showToast(
                    msg: "Mobile number must be exactly 10 digits",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                  );
                } else {
               
                  // Proceed if validation is successful
                  // if(controller.isLoading.isTrue){
                  //  Future.delayed(Duration(milliseconds: 500),(){
                  //     showBottomDialog(context);
                  //  });
                  // }else{

                  // }
                 
                  Helper.pickUPTime = controller.pickUptimeController.text;
                                  
                  showBottomDialog(context);
                
                  // Call the API after a slight delay
                  Future.delayed(const Duration(milliseconds: 1500), () {
                    controller.GetCartPlaceItemsApi(context);
                  });
                }
                
                      },
                      child: Text(
                        "Place Order",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                
                
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
            // : Container(),
          ],
          appBar: AppBar(
            backgroundColor: AppTheme.Buttoncolor,
            automaticallyImplyLeading: false,
            bottomOpacity: 0.0,
            elevation: 0.0,
            toolbarHeight: 50,
            leading: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 20, right: 0, left: 15),
              child: InkWell(
                onTap: () {
                  Get.back();
                //  WidgetsBinding.instance.addPostFrameCallback((callback){

                //    Get.off(() => CartScreen());
                //  });
                 },

                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white, // customize color as per requirement
                ),
                /*),*/
              ),
            ),
            title: Text("Place Order",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                )),
            centerTitle: true,
            actions: <Widget>[],
          ),
          body: SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: DefaultTabController(
                length: 1,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                     opacity: _fadeInAnimation, 
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.02,
                          decoration: BoxDecoration(color: Colors.white24),
                          child: Row(
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const WidgetSpan(
                                      child: Icon(
                                        Icons.location_on_outlined, // Choose your icon
                                        size: 16, // Adjust the icon size to match text
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " Deliver to ",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    // Office Text
                                    Text(
                                      Helper.deliveryPlace,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Center(child: Icon(Icons.arrow_drop_down)),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        AddNewAddressController().getCustomerAddress().then((onValue){
                                          Get.to(() => AddNewAddressScreen());
                                        });
                    
                                      },
                                      child: Container(
                                        height: MediaQuery.of(context).size.height * 0.08, // Dynamic height based on screen height
                                        width: MediaQuery.of(context).size.width * 0.25, // Dynamic width (responsive based on screen width)
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Change",
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [ 
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  Helper.location?? "Address not available",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Text(orderdateController.orderdateController())
                    
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cart Total',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Obx(
                                  () => controller.isLoading.value
                                  ? Container(height: 5, width: 5, child: CircularProgressIndicator())
                                  : Text(
                                controller.getCartInfos.total != null ? "₹ ${controller.getCartInfos.total.toString()}" : "No Data",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        SizedBox(
                          height: height * 0.5,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                    
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        controller.userDataProvider.getItNow == 2 ? Icons.local_shipping : Icons.store,
                                        color: AppTheme.Buttoncolor,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Mode:',
                                        style: GoogleFonts.poppins(
                                          color: Colors.black87,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    Helper.orderMode,
                                    style: GoogleFonts.poppins(
                                      color: AppTheme.Buttoncolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                    
                              const SizedBox(height: 15),
                              Expanded(
                                child: TabBarView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    if (controller.userDataProvider.getItNow == null || controller.userDataProvider.getItNow == 1)
                                      SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Pick Time Field
                                              _buildPickTimeField(context),
                                              const SizedBox(height: 15),
                                              Obx(() => _buildDropdownField()),
                                              const SizedBox(height: 15),
                                              _buildMobileNumberField(),
                                              const SizedBox(height: 15),
                                              Text(
                                                "HAVE A COUPON?",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              _buildCouponField(),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      controller.ApplyCouponCode();
                                                    },
                                                    child: Text(
                                                      "APPLY",
                                                      style: GoogleFonts.poppins(
                                                        color: AppTheme.Buttoncolor,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    SingleChildScrollView(
                                      physics: NeverScrollableScrollPhysics(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Obx(
                                                  () => Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "Schedule Delivery",
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  Switch.adaptive(
                                                    value: controller.isAdditionalInputEnabled.value,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        controller.isAdditionalInputEnabled.value = value;
                                                      });
                                                    },
                                                    activeColor: AppTheme.Buttoncolor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            Obx(
                                                  () => controller.isAdditionalInputEnabled.value ? _buildPickTimeField(context) : Container(),
                                            ),
                                            // Pick Time Field
                                            const SizedBox(height: 15),
                                            Obx(() => _buildDropdownField()),
                                            const SizedBox(height: 15),
                                            _buildMobileNumberField(),
                                            const SizedBox(height: 15),
                                            Text(
                                              "HAVE A COUPON?",
                                              style: GoogleFonts.poppins(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            _buildCouponField(),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    controller.ApplyCouponCode();
                                                  },
                                                  child: Text(
                                                    "APPLY",
                                                    style: GoogleFonts.poppins(
                                                      color: AppTheme.Buttoncolor,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  addNumber() {
    // Safely convert to double with fallback to 0.0
    double a = double.tryParse(controller.getCartInfos.subtotal.toString()) ?? 0.0;
    double b = double.tryParse(controller.getCartInfos.deliveryFee.toString()) ?? 0.0;

    // Perform the calculation
    double result = a + b;

    // Update the total in the controller
    controller.getCartInfos.subtotal = result.toString();

    // Print for debugging
    print("calculation result: $result");
    totalpriceshow = result.toString();
    // Return the result
    return result.toString(); // Optional: Format to 2 decimal places
  }

  Widget _buildPickTimeField(BuildContext context) {
    return Container(
      height: 50,
      child: TextFormField(
        onTap: () {
          showBottomTimePicker(context, controller.pickUptimeController);
        },
        readOnly: true,
        controller: controller.pickUptimeController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.Buttoncolor),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.Buttoncolor),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'Choose a pick time',
          hintStyle: GoogleFonts.poppins(
            color: Colors.black45,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: Icon(
            Icons.access_time,
            color: AppTheme.Buttoncolor,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      value: controller.selectedCategory.value.isEmpty ? null : controller.selectedCategory.value,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.Buttoncolor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.Buttoncolor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      isExpanded: true,
      hint: Text(
        controller.productCategoryDropdown.value,
        style: GoogleFonts.poppins(
          color: Colors.black45,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      items: controller.categories
          .map((category) => DropdownMenuItem<String>(
        value: category,
        child: Text(
          category,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ))
          .toList(),
      onChanged: (value) {
        controller.selectedCategory.value = value ?? '';
        controller.productCategoryController.text = value ?? '';
      },
      dropdownColor: Colors.white,
      icon: Icon(Icons.arrow_drop_down, color: AppTheme.Buttoncolor),
    );
  }

  Widget _buildMobileNumberField() {
    return Container(
      height: 50,
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        keyboardType: TextInputType.phone,
        controller: controller.mobileNumberController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.Buttoncolor, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.Buttoncolor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'Enter Your Mobile Number',
          hintStyle: GoogleFonts.poppins(
            color: Colors.black45,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: Icon(
            Icons.settings_phone,
            color: AppTheme.Buttoncolor,
          ),
        ),
      ),
    );
  }

  Widget _buildCouponField() {
    return Container(
      height: 50,
      child: TextFormField(
        controller: controller.couponCodeController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.Buttoncolor),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.Buttoncolor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'Enter Your Promo Code',
          hintStyle: GoogleFonts.poppins(
            color: Colors.black45,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  controller.couponCodeController.clear();
                },
                child: Icon(Icons.highlight_remove_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showBottomTimePicker(
      BuildContext context,
      TextEditingController controller,
      ) {
    var times;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              height: 280,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(height: 20, width: 20),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text("Select Time",
                                textAlign: TextAlign.center, style: TextStyle(color: AppTheme.appBlack, fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(Icons.clear))
                      ],
                    ),
                  ),
                  Expanded(
                    child: TimePickerSpinner(
                      is24HourMode: false,
                      spacing: 30,
                      itemHeight: 37,
                      itemWidth: 60,
                      isForce2Digits: true,
                      onTimeChange: (time) {
                        times = time;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppButton2(
                        width: width * 0.45,
                        height: 40,
                        title: 'Cancel',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        onPressed: () {
                          Get.back();
                        },
                        color: Colors.white,
                        titleColor: AppTheme.bottomTabsLabelInActiveColor,
                        borderColor: AppTheme.cancelBorder,
                      ),
                      AppButton2(
                        width: width * 0.45,
                        height: 40,
                        title: 'Save ',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        onPressed: () {
                          controller.text = " ${formatDate(times, [
                            hh,
                            ':',
                            nn,
                            ' ',
                            am,
                          ])}";
                          Navigator.of(context).pop();
                        },
                        titleColor: Colors.white,
                        color: AppTheme.Buttoncolor,
                        borderColor: AppTheme.Buttoncolor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }


void showBottomDialog(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Lottie.asset("assets/icons/Animation - 1735975481641.json"),
            SizedBox(height: 16.0), // Add some spacing between the animation and the text
            Text(
              "Your Order Successfuly Placed!",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    },
  );
}


  // String totalAmount (var productPrice,var discount,var deliveryFee,var promoDiscount){

  //   double ?x3 = 0.0;
  //   print("price 1 ===>${productPrice}");
  //   print("price 1 ===>${discount}");
  //   print("price 1 ===>${deliveryFee}");
  //   print("price 1 ===>${promoDiscount}");

  //   if(productPrice.toString() != "null" && discount.toString() != "null" && deliveryFee.toString() != "null" && promoDiscount.toString() != "null"){
  //     double ?x1 = double.parse(productPrice.toString()) + double.parse(deliveryFee.toString());
  //     double ?x2 = double.parse(discount.toString()) + double.parse(promoDiscount.toString());

  //     x3 = x1 - x2;

  //   }
  //   print("price 2 ===>${x3.toString()}");
  //   return x3.toString();




  // }
}

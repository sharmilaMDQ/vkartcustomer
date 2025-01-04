import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/FavouriteStoreScreenController.dart';
import '../../Helper/Helper.dart';
import '../../Pageroutes/App_routes.dart';

class FavouriteStoreScreen extends StatefulWidget {
  FavouriteStoreScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteStoreScreen> createState() => _FavouriteStoreScreenState();
}

class _FavouriteStoreScreenState extends State<FavouriteStoreScreen> with SingleTickerProviderStateMixin {
  late FavouriteStoreScreenController controller;
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = Get.put(FavouriteStoreScreenController());
    
    // Initialize animations
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

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

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FadeTransition(
            opacity: _fadeInAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 70),
                  Image.asset(
                    'assets/images/high-angle-location-symbol-smartphone.png', // Replace with your asset image
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Shop Your Favourite Store",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Find your favorite stores by selecting your \nlocation or using the map.",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => ElevatedButton.icon(
                              onPressed: () {
                               setState(() {
                                controller.getCurrentLocation();
                               });
                                // Your logic for "Use Location"
                              },
                              icon: controller.isLoading.value
                                  ? const SizedBox(
                                      width: 12,
                                      height: 12,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Icon(
                                      Icons.my_location,
                                      size: 18,
                                      color: Colors.black,
                                    ),
                              label: Text(
                                "Use Location",
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade200,
                                minimumSize: Size(120, 40),
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            )),
                        ElevatedButton.icon(
                          onPressed: () async {
                            var result = await Get.toNamed(AppRoutes.getcurrentLocationMap.toName);
                            if (result != null) {
                              controller.PostalCodeController.text =
                                  controller.userDataProvider.getLocation.toString();
                            }
                          },
                          icon: Icon(
                            Icons.maps_home_work,
                            size: 18,
                            color: Colors.black,
                          ),
                          label: Text(
                            "Choose Map",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade200,
                            minimumSize: Size(120, 40),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      maxLines: null,
                      textAlign: TextAlign.start,
                      controller: controller.PostalCodeController,
                      decoration: InputDecoration(
                        labelText: "Enter Address or Postal Code",
                        labelStyle: TextStyle(fontSize: 11),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.location_on_outlined,
                          color: Colors.green,
                        ),
                      ),
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 125),
                  Obx(() => ElevatedButton(
                        onPressed: () {
                          Helper.location = controller.PostalCodeController.text;
                          controller.validation(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: Size(300, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "Start Shopping",
                                style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                              ),
                      )),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

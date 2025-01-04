import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vkartcustomer/Controller/ProductHomeScreenController.dart';
import 'package:vkartcustomer/Models/offerslist_model/offers_click_model.dart';
import '../../Components/AppTheme.dart';
import '../../Controller/offers_list_controller.dart';
import '../../Helper/Helper.dart';
import '../../utility/BottomNavigationBar.dart';

class OfferScreen extends StatefulWidget {
  OfferScreen({Key? key}) : super(key: key);

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen>with SingleTickerProviderStateMixin {
  final offersController = Get.find<OffersListController>();
  final offersController1 = Get.find<ProductHomeScreenController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();
    // Fetch data after the widget has been built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      offersController1.getslideroffers(context);
      offersController.getrowadds(context);
    });

    Future.delayed(Duration(seconds: 1),(){
      setState(() {

      });
    });
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppTheme.Buttoncolor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Text(
          "Offer List",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FadeTransition(
         opacity: _fadeInAnimation,
          child: Container(
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Obx(
                  () =>
              offersController1.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : offersController1.offersdata != null ||
                  offersController.rowoffersdata != null
                  ? Column(
                children: [
                  const SizedBox(height: 15),
                  // Carousel 1
                  CarouselSlider(
                    items: offersController1.offersdata!.gold1.map((offer) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: ScaleTransition(
                             scale: _scaleAnimation,
                          child: GestureDetector(
                            onTap: () {
                              List<
                                  OffersClickData> filteredOffers = offersController1
                                  .offersclikeddata
                                  .where((clickedOffer) =>
                              clickedOffer.sellerId == offer.sellerId)
                                  .toList();
                                    
                              if (filteredOffers.isNotEmpty) {
                                print("Filtered Offers Found: ${filteredOffers
                                    .length}");
                              } else {
                                print("No matching offers found.");
                              }
                                    
                              Helper.offerState = true;
                              offersController1.getoffersclicked(
                                type: offer.actionType,
                                sellerid: offer.sellerId.toString(),
                                contentId: offer.contentId.toString(),
                                coustomerId: Helper.customerID.toString(),
                              ).then((data) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                    callback) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        navigateBar(initialIndex: 1)),
                                  );
                                });
                              });
                            },
                            child: Container(
                              width: size.width * 0.98,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  offer.adImage,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                      size: 50,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.99,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(
                          milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Gradient Container 1 (Row ad data)
                  offersController.rowoffersdata?.gold != null
                      ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1, // Only one item will be displayed
                    itemBuilder: (context, index) {
                      var offer1 = offersController.rowoffersdata!
                          .gold[0]; // Define 'offer1' here
                      var offer2 = offersController.rowoffersdata!
                          .gold[1]; // Define 'offer2' here
          
                      return StatefulBuilder(builder: (ctx,setState){
                        return  ScaleTransition(
                           scale: _scaleAnimation,
                          child: GestureDetector(
                            onTap: () {
                              // Filter offers like in the carousel onTap function
                              List<
                                  OffersClickData> filteredOffers1 = offersController1
                                  .offersclikeddata
                                  .where((clickedOffer) =>
                              clickedOffer.sellerId == offer1.sellerId)
                                  .toList();
                                    
                              List<
                                  OffersClickData> filteredOffers2 = offersController1
                                  .offersclikeddata
                                  .where((clickedOffer) =>
                              clickedOffer.sellerId == offer2.sellerId)
                                  .toList();
                                    
                              if (filteredOffers1.isNotEmpty) {
                                print(
                                    "Filtered Offers Found for Offer 1: ${filteredOffers1
                                        .length}");
                              } else {
                                print("No matching offers found for Offer 1.");
                              }
                                    
                              if (filteredOffers2.isNotEmpty) {
                                print(
                                    "Filtered Offers Found for Offer 2: ${filteredOffers2
                                        .length}");
                              } else {
                                print("No matching offers found for Offer 2.");
                              }
                                    
                              Helper.offerState = true;
                                    
                              // Handle the first offer click
                                    
                              // Handle the second offer click
                              offersController1.getoffersclicked(
                                type: offer1.actionType,
                                sellerid: offer1.sellerId.toString(),
                                contentId: offer1.contentId.toString(),
                                coustomerId: Helper.customerID.toString(),
                              ).then((data) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                    callback) {
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(builder: (ctx) =>
                                  //       navigateBar(initialIndex: 1)),
                                  // );
                                    
                                  Get.to(navigateBar(initialIndex: 1));
                                });
                              });
                            },
                            child: _buildGradientContainer(
                              size,
                             offer1.adImage.isNotEmpty||offer1.adImage!=null? offer1.adImage:'', // First offer image
                             offer2.adImage!=null||offer2.adImage.isNotEmpty? offer2.adImage:"", // Second offer image
                            ),
                          ),
                        );
                      });
                    },
                  )
          
          
                      : const Text("No data available"),
                  const SizedBox(height: 4),
                  // Carousel 2
                  CarouselSlider(
                    items: offersController1.offersdata!.gold2.map((offer) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child:ScaleTransition (
                          scale: _scaleAnimation,
                          child: GestureDetector(
                            onTap: () {
                              List<
                                  OffersClickData> filteredOffers = offersController1
                                  .offersclikeddata
                                  .where((clickedOffer) =>
                              clickedOffer.sellerId == offer.sellerId)
                                  .toList();
                                    
                              if (filteredOffers.isNotEmpty) {
                                print("Filtered Offers Found: ${filteredOffers
                                    .length}");
                              } else {
                                print("No matching offers found.");
                              }
                                    
                              Helper.offerState = true;
                              offersController1.getoffersclicked(
                                type: offer.actionType,
                                sellerid: offer.sellerId.toString(),
                                contentId: offer.contentId.toString(),
                                coustomerId: Helper.customerID.toString(),
                              ).then((data) {
                                 Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        navigateBar(initialIndex: 1)),
                                  );
                                // WidgetsBinding.instance.addPostFrameCallback((
                                //     callback) {
                                 
                                // });
                              });
                            },
                            child: Container(
                              width: size.width * 0.98,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  offer.adImage,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                      size: 50,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.99,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(
                          milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Gradient Container 2 (Static image, you can replace it dynamically too)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return ScaleTransition(
                         scale: _scaleAnimation,
                        child: GestureDetector(
                          child: _buildGradientContainer( 
                              size,
                             offersController.rowoffersdata!.gold!=null||offersController.rowoffersdata!.gold.isNotEmpty? offersController.rowoffersdata!.gold[2].adImage:"",
                             offersController.rowoffersdata!.gold.isEmpty||offersController.rowoffersdata!.gold!=null? offersController.rowoffersdata!.gold[3].adImage :""
                          ),
                        ),
                      );
                    },
                  )
                ],
              )
                  : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/nodata.png", fit: BoxFit.contain),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientContainer(Size size, String leftImage,
      String rightImage) {
    return Padding(
      padding: const EdgeInsets.only(left: 1, right: 1),
      child: Container(
        height: 80,
        width: size.width,
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [
          //     Colors.green,
          //     Colors.yellow.shade400,
          //   ],
          // ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: _buildImageContainer(leftImage)),
            // Flexible(
            //   child: Center(
            //     child: Text(
            //       title,
            //       style: const TextStyle(
            //         fontSize: 9.5,
            //         fontWeight: FontWeight.bold,
            //       ),
            //       overflow: TextOverflow.ellipsis,
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
            // ),
            Flexible(child: _buildImageContainer(rightImage)),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContainer(String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(left: 1, right: 1),
      child: Container(
        height: 80,
        width: 175,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
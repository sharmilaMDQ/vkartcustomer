import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:vkartcustomer/Components/AppTheme.dart';
import 'package:vkartcustomer/Controller/settings/settings_controller.dart';

import '../../Helper/Helper.dart';


class WriteYourFeedbackScreen extends StatefulWidget {
  const WriteYourFeedbackScreen({super.key});

  @override
  State<WriteYourFeedbackScreen> createState() =>
      _WriteYourFeedbackScreenState();
}

class _WriteYourFeedbackScreenState extends State<WriteYourFeedbackScreen>with SingleTickerProviderStateMixin {
  final controller = Get.find<SettingsController>();
    late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;


  @override
  void initState() {
    controller.getFeedBack(customerId: Helper.customerID.toString());
    super.initState();
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

  void showToast(String message, bool isSuccess) {
    MotionToast(
      primaryColor: isSuccess ? Colors.green : Colors.red,
      title: Text(
        isSuccess ? "Success" : "Error",
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      description: Text(
        message,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 70,
      borderRadius: 12,
      displaySideBar: false,
      enableAnimation: true,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppTheme.Buttoncolor,
        automaticallyImplyLeading: false,
        title: Text(
          "Feedback",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ScaleTransition(
        scale: _scaleAnimation,
        child: FadeTransition(
            opacity: _fadeInAnimation,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "We value your feedback!",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Let us know your thoughts to help us improve our service.",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      // Rating Section
                      GetBuilder<SettingsController>(
                        builder: (_) {
                          return Column(
                
                            children: [
                              SizedBox(
                                width:600,
                
                                child: Card(
                                  elevation:10,
                                  child: Column(
                
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Rating",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("How was your experience with us?",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: StarRating(
                                          size: 40,
                                          rating: controller.rating.value,
                                          allowHalfRating: true,
                
                                          onRatingChanged: (rating) => setState(() {
                                            controller.rating.value =
                                                rating.toDouble();
                
                                          }),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 250,
                                          height: 50,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppTheme.green,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                                )
                                              ),
                                              onPressed: () async {
                                                controller.setLoading(true);
                
                                                await controller.addfeedback(
                                                  customerId: Helper.customerID,
                                                  rating:
                                                  controller.rating.value.toString(),
                                                  reviewText: controller
                                                      .reviewTextController.text,
                                                );
                
                                                controller.setLoading(false);
                
                                                if (controller.feedbackSuccess.value) {
                                                  showToast(
                                                      "Feedback shared successfully", true);
                                                } else {
                                                  showToast("Failed to share feedback", false);
                                                }
                
                                                Navigator.pop(context);
                                              }, child: Text("Submit Feedback",style: TextStyle(
                                            color: Colors.white
                                          ),)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // SlideRatingDialog(
                              //
                              //
                              //   buttonTitle: controller.isLoading.value
                              //       ? "Submitting..."
                              //       : "Submit Feedback",
                              //   buttonColor: AppTheme.green,
                              //   buttonOnTap: () async {
                              //     controller.setLoading(true);
                              //
                              //     await controller.addfeedback(
                              //       customerId: Helper.customerID,
                              //       rating:
                              //           controller.rating.value.toString(),
                              //       reviewText: controller
                              //           .reviewTextController.text,
                              //     );
                              //
                              //     controller.setLoading(false);
                              //
                              //     if (controller.feedbackSuccess.value) {
                              //       showToast(
                              //           "Feedback shared successfully", true);
                              //     } else {
                              //       showToast("Failed to share feedback", false);
                              //     }
                              //
                              //     Navigator.pop(context);
                              //   },
                              //   ratingBarBackgroundColor: Colors.grey[300],
                              //   onRatingChanged: (newRating) {
                              //     controller.rating.value =
                              //         newRating.toDouble();
                              //   },
                              //   showCancelButton: false,
                              // ),
                              const SizedBox(height: 20),
                              // Text Field for Review Input
                              TextField(
                                controller: controller.reviewTextController,
                                maxLines: null,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(fontSize: 12),
                                decoration: InputDecoration(
                                  labelText: "Write your review",
                                  labelStyle: GoogleFonts.poppins(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey[400]!,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: AppTheme.Buttoncolor,
                                    ),
                                  ),
                                  hintText: "e.g. Excellent service!",
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ], 
          ),
        ),
      ),
    ); 
  }
}
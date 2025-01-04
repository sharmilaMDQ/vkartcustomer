import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vkartcustomer/UI/SettingsScreen/report_issue_screen.dart';
import 'package:vkartcustomer/UI/SettingsScreen/write_your_feedback_screen.dart';
import '../../Components/AppTheme.dart';
import '../../Controller/SettingScreenController.dart';


class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> with SingleTickerProviderStateMixin {
   late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;
  
 final String phoneNumber = ""; // Replace with the desired phone number

  Future<void> _redirectToPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
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
  @override
  Widget build(BuildContext context) {
        final String gmailAddress = "vkart.help@gmail.com"; // Your Gmail address
    double screenHeight = MediaQuery.of(context).size.height;
     double screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
           appBar: AppBar(
        backgroundColor: AppTheme.Buttoncolor,
        automaticallyImplyLeading: false,
        bottomOpacity: 0.0,
        elevation: 0.0,
        // toolbarHeight: 80,
      
        title: Text(
          "Help Center",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
                onTap: (){
                  Get.back();
                },
                child: Icon(Icons.arrow_back_ios,
                color: Colors.white,
                ),
              ),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: ScaleTransition(
           scale: _scaleAnimation,
          child: FadeTransition(
              opacity: _fadeInAnimation, 
            child: Column(
              children: [
                
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                     Get.to(WriteYourFeedbackScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Card(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.white, spreadRadius: 0, blurRadius: 0)]),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                height: 35,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: AppTheme.IconBackground,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SvgPicture.asset(
                                  'assets/icons/Points.svg',
                                  color: AppTheme.Buttoncolor,
                                  height: 10,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Write Your Feedback',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 15,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Card(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.white, spreadRadius: 0, blurRadius: 0)]),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 35,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppTheme.IconBackground,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.note_add_rounded,
                                color: AppTheme.Buttoncolor,
                                size: 35,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Share Our App',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 15,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22,right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Customer Care",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis, // Handles text overflow
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppTheme.Buttoncolor.withOpacity(0.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           
                            _buildItem(
                              icon: Icons.phone,
                              text: "7358662448",
                              onTap: () {
                               _redirectToPhone(phoneNumber);
                                // Add functionality for phone tap if needed
                              },
                            ),
                            _buildItem(
                              icon: Icons.email,
                              text: "vkart.help@gmail.com",
                              onTap: () {
                               Share.share('You can reach me at my Gmail: $gmailAddress');
                                // Add functionality for email tap if needed
                              },
                            ),
                            _buildItem(
                              icon: Icons.question_answer,
                              text: "FAQ",
                              onTap: () {
                                // Add functionality for email tap if needed
                              },
                            ),
                            _buildItem(
                              icon: Icons.report,
                              text: "Report Issue",
                              onTap: () {
                                Get.to(ReportIssueScreen());
                                // Add functionality for reporting issue
                              },
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
    );
  }
}
Widget _buildItem({
  required IconData icon,
  required String text,
  required Function onTap,
}) {
  return GestureDetector(
    onTap: () => onTap(),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Icon(
                icon,
                size: 24.0,
                color: AppTheme.Buttoncolor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis, // Handles text overflow
              ),
            ),
          ],
        ),
      ),
    ),
  );

}
void shareAppLink() {
  final appLink = "https://yourappurl.com";  // Replace with your actual app link
  Share.share('Check out this app: $appLink');
}


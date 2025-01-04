import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/ScreenTwoController.dart';
import '../../Helper/Helper.dart';
import '../../Pageroutes/App_routes.dart';
import '../LoginScreen/LoginScreen.dart';



class screenTwo extends StatefulWidget {
  const screenTwo({super.key});

  @override
  State<screenTwo> createState() => _screenTwoState();
}

class _screenTwoState extends State<screenTwo> with SingleTickerProviderStateMixin{
   late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;


  @override
  void initState() {
    getValues();

    Future.delayed(Duration(seconds: 3),(){
      autologin();
    });
    super.initState();
      // Initialize animations
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
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
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    //ScreenTwoController controller = Get.put(ScreenTwoController());

    return GetBuilder(
      init: ScreenTwoController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body:   SafeArea(
            child: FadeTransition(
              opacity: _fadeInAnimation,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Stack(
                      clipBehavior: Clip.none, // Allows the container to overflow
                      children: [
                        Container(
                          height: 425,
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(110),
                              bottomRight: Radius.circular(110),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -5,
                          //bottom: -20, // Adjust this value to control how much it overflows
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              height: 500,
                              child: FadeTransition(
                                opacity: _fadeInAnimation,
                                child: Image.asset(
                                  "assets/images/brunette-woman-with-paper-bag-full-healthy-food.png",
                                  // 'assets/images/young-woman-holding-green-leaves.png',
                                  //height: 250, // Adjust height for desired size
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              
              
                  SizedBox(height: 20),
              
                  // Text Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeTransition(
                        opacity: _fadeInAnimation,
                        child: Text(
                          'Buy Groceries',
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      FadeTransition(
                        opacity: _fadeInAnimation,
                        child: Text(
                          'Easilly With Us',
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: FadeTransition(
                           opacity: _fadeInAnimation,
                          child: Text(
                            'Listen podcast and open your \nworld with this application.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              
              
              
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.11,
              
                  ),
                  Obx(()=>
                      ScaleTransition(
                            scale: _scaleAnimation,
                        child: InkWell(
                          onTap:  controller.onPressed,
                          child: Container(
                            height: 45,
                            width: 200,
                            decoration: BoxDecoration(
                                gradient:LinearGradient(colors: [
                                  Colors.green.shade400,
                                  Colors.green.shade700,
                                      
                                ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child:controller.isLoading.value
                                  ? SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  strokeWidth: 3,
                                ),
                              )
                                  :
                              Text("Get Started",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),),
                            ),
                          ),
                        ),
                      ),
                  ),
                
              
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );

      },
    );
  }
  void getValues()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("CUS ID ==? ${Helper.customerID}");
    print("CUS ID ==? ${pref.getInt("CustomerId")}");


    Helper.customerID = pref.getInt("CustomerId") ?? 0;
    print("CUS ID ==? ${Helper.customerID}");



  }

  void autologin(){
    if(Helper.customerID != 0){
      Get.toNamed(AppRoutes.login.toName);
    /*  Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => navigateBar(initialIndex: 0),
        ),
      );*/
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }

}


/*class ScreenTwo extends GetView<ScreenTwoController> {
  const ScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenTwoController controller = Get.put(ScreenTwoController());

    return GetBuilder(
      init: ScreenTwoController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
        body:   SafeArea(
        child: Column(
          children: [
           Expanded(
  flex: 1,
  child: Stack(
    clipBehavior: Clip.none, // Allows the container to overflow
    children: [
      Container(
        height: 425,
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(110),
            bottomRight: Radius.circular(110),
          ),
        ),
      ),
      Positioned(
        top: -5,
        //bottom: -20, // Adjust this value to control how much it overflows
        left: 0,
        right: 0,
        child: Center(
          child: Container(
            height: 500,
            child: Image.asset(
              "assets/images/brunette-woman-with-paper-bag-full-healthy-food.png",
             // 'assets/images/young-woman-holding-green-leaves.png',
              //height: 250, // Adjust height for desired size
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    ],
  ),
),


            SizedBox(height: 20),

            // Text Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Buy Groceries',
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Easilly With Us',
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Listen podcast and open your \nworld with this application.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),

            

           SizedBox(
                height: MediaQuery.of(context).size.height * 0.11,
              
              ),
              Obx(()=>
                 InkWell(
                  onTap:  controller.onPressed,
                  child: Container(
                    height: 45,
                    width: 200,
                    decoration: BoxDecoration(
                      gradient:LinearGradient(colors: [
                         Colors.green.shade400,
                        Colors.green.shade700,
                       
                      ],
                      begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child:controller.isLoading.value
                          ? SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 3,
                              ),
                            )
                :
                     Text("Get Started",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),),
                    ),
                  ),
                ),
              ),
              // Center(
              //   child: Obx(() {
              //     return Button(
              //       widthFactor: 0.9,
              //       heightFactor: 0.06,
              //       onPressed: controller.onPressed,
              //       child: controller.isLoading.value
              //           ? SizedBox(
              //               width: 15,
              //               height: 15,
              //               child: CircularProgressIndicator(
              //                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              //                 strokeWidth: 3,
              //               ),
              //             )
              //           : Text(
              //               "Get Started",
              //               style: GoogleFonts.poppins(
              //                 color: Colors.white,
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //     );
              //   }),
              // ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
//           body: Column(
//             // crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//             SizedBox(
//               height: 100,
//             ),
//     Center(
//   child: Container(
//     height: 250,
//     width: 250,
//     decoration: BoxDecoration(
//       shape: BoxShape.circle,
//       color: Colors.green, // Background color of the circle
//     ),
//     child: Center(
//       child: Image.asset(
//         'assets/images/young-woman-holding-green-leaves.png',
//         height: 350, // Increased the height of the image
//         fit: BoxFit.fitHeight, // Ensures the image scales properly
//       ),
//     ),
//   ),
// ),




//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Center(
//                     child: Text(
//                       'Buy Groceries',
//                       style: GoogleFonts.poppins(
//                         color: AppTheme.Frontcolor,
//                         fontSize: 25,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Center(
//                     child: Text(
//                       'Easily With Us',
//                       style: GoogleFonts.poppins(
//                         color: AppTheme.green,
//                         fontSize: 25,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.03,
//               ),
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Listen Podcast and open your \n       '
//                         ' world this application ',
//                         style: GoogleFonts.poppins(
//                           color: AppTheme.Frontcolor,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.11,
//               ),
//               Center(
//                 child: Obx(() {
//                   return Button(
//                     widthFactor: 0.9,
//                     heightFactor: 0.06,
//                     onPressed: controller.onPressed,
//                     child: controller.isLoading.value
//                         ? SizedBox(
//                             width: 15,
//                             height: 15,
//                             child: CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                               strokeWidth: 3,
//                             ),
//                           )
//                         : Text(
//                             "Get Started",
//                             style: GoogleFonts.poppins(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         );
      },
    );
  }

}*/

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 40); // Adjust the height of the curve
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }



}
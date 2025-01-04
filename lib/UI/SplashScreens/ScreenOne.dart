// import 'dart:async';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:grosshop/Helper/Helper.dart';
// import 'package:grosshop/UI/LoginScreen/LoginScreen.dart';
// import 'package:grosshop/UI/SplashScreens/ScreenTwo.dart';
// import 'package:grosshop/utility/BottomNavigationBar.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../Components/AppTheme.dart';

// class ScreenOne extends StatefulWidget {
//   const ScreenOne({Key? key}) : super(key: key);

//   @override
//   State<ScreenOne> createState() => _ScreenOneState();
// }

// class _ScreenOneState extends State<ScreenOne> {
//   @override
//   void initState() {
//     //  checkForAuth(context);
//     getValues();


//     Future.delayed(Duration(seconds: 3),(){
//       autologin();
//     });
//     super.initState();




//   }

//   void startTimer() {
//     const duration = Duration(seconds: 3);
//     Timer(duration, () {

//       if(Helper.customerID != 0){
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => navigateBar(initialIndex: 0),
//           ),
//         );
//       }else{
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ScreenTwo(),
//           ),
//         );
//       }


//     });
//   }


//   void autologin(){
//     if(Helper.customerID != 0){
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => navigateBar(initialIndex: 0),
//         ),
//       );
//     }else{
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ScreenTwo(),
//         ),
//       );
//     }
//   }

//   void getValues()async{
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     print("CUS ID ==? ${Helper.customerID}");
//     print("CUS ID ==? ${pref.getInt("CustomerId")}");


//       Helper.customerID = pref.getInt("CustomerId") ?? 0;
//       print("CUS ID ==? ${Helper.customerID}");
    


//   }


   
//    Future<void> checkForAuth(BuildContext context) async {
//   final prefs = await SharedPreferences.getInstance();
//   String? authtoken = prefs.getString('bearerToken');
//   print('Fetched token: $authtoken');

//   if (authtoken == null || authtoken=="null") {
//     print('Token is missing or empty, navigating to LoginScreen...');
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => ScreenTwo())
//     );
//   } else {
//     print('Token is present, navigating to navigateBar...');
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => navigateBar(initialIndex: 0)),
//     );
//   }
// }

// //  checkForAuth() async {
    
// //     final prefs = await SharedPreferences.getInstance();
// //     String? authtoken = prefs.getString("MemberID");
// //     Helper.name=prefs.getString("Username");
// //     Helper.role = prefs.getString("RoleId");
// //     Helper.loginclubId = prefs.getString("clubId") ?? "";

// //     print("INITIAL M ID ==>${Helper.userid}");
// //     if(prefs.getString("memId").toString()!="null"){
// //          Helper.userid = int.parse(prefs.getString("memId").toString());
// //          print("final M ID ==>${Helper.userid}");
// //     }
  
// //     print("TOKEN -->$authtoken");

   
// //     print("Token is here");
// //     print(authtoken);
// //     if (authtoken == "null" || authtoken == null) {
// //       Navigator.pushAndRemoveUntil(
// //           context,
// //           MaterialPageRoute(builder: ((context) => LoginScreen())),
// //           (route) => false);
// //     } else {
// //       Get.offAll(Bottombar());
// //     }
// //   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Image.asset(
//                 'assets/images/Grosshop G.png',
//                 height: 80,
//               ),
//             ),
//             Text(
//               'express',
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.04,
//             ),
//             Center(
//               child: CupertinoActivityIndicator(
//                 color: AppTheme.Buttoncolor,
//                 radius: 20,
//                 animating: true,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
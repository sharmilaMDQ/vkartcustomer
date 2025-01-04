import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vkartcustomer/Components/AppTheme.dart';
import 'package:vkartcustomer/Controller/LoginScreenController.dart';
import 'package:vkartcustomer/Controller/ProductHomeScreenController.dart';
import 'package:vkartcustomer/Controller/cartItem/cartItem_controller.dart';
import 'package:vkartcustomer/Controller/order/order_controller.dart';
import 'package:vkartcustomer/Controller/settings/settings_controller.dart';
import 'package:vkartcustomer/UI/SplashScreens/ScreenTwo.dart';
import 'package:vkartcustomer/utility/AppPreference.dart';
import 'Controller/offers_list_controller.dart';
import 'Pageroutes/App_pages.dart';
import 'Pageroutes/App_routes.dart';
import 'Provider/ProductProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(OffersListController());
  Get.put(CartitemController());
  Get.put(LoginScreenController());
  Get.put(SettingsController());
  Get.put(OrderController());
  Get.put(ProductHomeScreenController());
  // Get.put(CheckOutScreenController());
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  AppPreference().init();
  runApp(
    ChangeNotifierProvider<ProductProvider>(
      create: (_) => ProductProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppTheme.Buttoncolor,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // Portrait mode only
    ]);

    final ThemeData appTheme = ThemeData(
      appBarTheme: AppBarTheme(
        elevation: 4,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: AppTheme.Buttoncolor,
      ),
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home:  screenTwo() /*LoginScreen()*/,
      initialRoute: AppRoutes.root.toName,
      getPages: AppPages.list,
    );
  }
}

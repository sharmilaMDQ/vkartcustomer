import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:vkartcustomer/Binding/EditProfileBinding.dart';
import 'package:vkartcustomer/Binding/GetCurrentLocationBinding.dart';
import 'package:vkartcustomer/Binding/ProductHomeScreenBinding.dart';
import 'package:vkartcustomer/UI/HomeScreen/ProductHomeScreen.dart';
import '../Binding/DisplaySelectedScreenBinding.dart';
import '../Binding/FavouriteStoreScreenBinding.dart';
import '../Binding/LoginScreenBinding.dart';
import '../Binding/ParticularHomeScreenProductBindings.dart';
import '../Binding/VerifyNumberScreenBinding.dart';
import '../UI/HomeScreen/DisplaySelectedProduct.dart';
import '../UI/HomeScreen/particularHomeScreenProduct.dart';
import '../UI/Location/GetCurrentLocation.dart';
import '../UI/LoginScreen/LoginScreen.dart';
import '../UI/LoginScreen/VerifyNumberScreen.dart';
import '../UI/SettingsScreen/EditProfile.dart';
import '../UI/SplashScreens/FavouriteStoreScreen.dart';
import 'App_routes.dart';

class AppPages {
  static var list = [
    GetPage(name: AppRoutes.root.toName, page: () => LoginScreen(), binding: LoginScreenBinding()),
    GetPage(name: AppRoutes.home.toName, page: () => ProductHomeScreen(), binding: ProductHomeScreenBinding()),
    GetPage(name: AppRoutes.register.toName, page: () => VerifyNumberScreen(), binding: VerifyNumberScreenBinding()),
    GetPage(name: AppRoutes.login.toName, page: () => FavouriteStoreScreen(), binding: FavouriteStoreScreenBinding()),
    GetPage(name: AppRoutes.producthomescreen.toName, page: () => DisplaySelectedProduct(), binding: DisplaySelectedScreenBinding()),
    GetPage(name: AppRoutes.editProfile.toName, page: () => EditProfileScreen(), binding: EditProfileScreenBinding()),
    GetPage(name: AppRoutes.getcurrentLocationMap.toName, page: () => MapScreen(), binding: GetCurrentLocationScreenBinding()),

    ///
    GetPage(
        name: AppRoutes.ParticularHomeScreenProduct.toName,
        page: () => particularHomeScreenProduct(),
        binding: ParticularHomeScreenProductBindings()), 
  ];
}

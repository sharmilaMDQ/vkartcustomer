import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vkartcustomer/Controller/AddNewAddressController.dart';
import 'package:vkartcustomer/Controller/LoginScreenController.dart';
import 'package:vkartcustomer/Controller/settings/settings_controller.dart';
import 'package:vkartcustomer/UI/Addresses/addNewAddressScreen.dart';
import 'package:vkartcustomer/UI/SettingsScreen/EditProfile.dart';
import '../../Components/AppTheme.dart';
import '../../Controller/SettingScreenController.dart';
import '../../Helper/Helper.dart';
import '../HelpCenter/helpCenter.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> with SingleTickerProviderStateMixin {
     late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;
  

  @override
  void initState() {
    settingsController.getprofile(customerId: Helper.customerID.toString());
    Future.delayed(Duration(milliseconds: 3000),(){
setState(() {

});
    });
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
final SettingScreenController homeController = Get.put(SettingScreenController());
     final settingsController = Get.find<SettingsController>();
 final  LoginScreenController loginController = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingScreenController>(
      init: SettingScreenController(),
      builder: (controller) {
        return Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(
              color: Colors.transparent,
            ),
          ),
          child: Scaffold(
            backgroundColor: AppTheme.Buttoncolor,
            appBar: AppBar(
              backgroundColor: AppTheme.Buttoncolor,
              automaticallyImplyLeading: false,
              bottomOpacity: 0.0,
              elevation: 0.0,
              toolbarHeight: 60,
              title: Text(
                "Settings",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              actions: const [],
            ),
            body:ScaleTransition(
                scale: _scaleAnimation,
              child: FadeTransition(
                  opacity: _fadeInAnimation,
                child: RefreshIndicator(
                  onRefresh: ()async{
                    settingsController.refreshData();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height - 100,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0.0, 0.75),
                                    blurRadius: 1,
                                    color: Colors.grey,
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(75),
                                child: settingsController.profiledata != null &&settingsController.profiledata!.customerImage.isNotEmpty&&settingsController.profiledata!=null
                                    ? Image.network(
                                       settingsController.profiledata!.customerImage ,
                                        fit: BoxFit.cover,
                                        height: 150,
                                        width: 150,
                                      )
                                    : Center(
                                        child: Image.network(
                                          "https://autorevog.blob.core.windows.net/autorevog/uploads/images/18942381.jpg",
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Obx(() => Text(
                                  controller.customerName.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                )),
                            const SizedBox(height: 15),
                            _buildSettingOption(
                              icon: Icons.person_outline,
                              label: 'Edit Profile',
                              onTap: () => Get.to(EditProfileScreen()),
                            ),
                            const SizedBox(height: 10),
                            _buildSettingOption(
                              icon: Icons.help_outline,
                              label: 'Help Center',
                              onTap: () => Get.to(() => HelpCenterScreen()),
                            ),
                               const SizedBox(height: 10),
                            _buildSettingOption(
                              icon: Icons.location_city_sharp,
                              label: 'Add Adresss',
                              onTap: (){
                                 AddNewAddressController().getCustomerAddress().then((onValue){
                                          Get.to(() => AddNewAddressScreen());
                                        });
                              }
                              // onTap: () => Get.to(() => HelpCenterScreen()),
                            ),
                            const SizedBox(height: 10),
                            _buildSettingOption(
                              icon: Icons.logout,
                              label: 'Log Out',
                              onTap: (){
                                showLogoutDialog(context);
                              }
                              // onTap: () => loginController.logout(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  Widget _buildSettingOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Card(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1,
                  offset: Offset(0.0, 0.75),
                ),
              ],
            ),
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
                      icon,
                      color: AppTheme.Buttoncolor,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 15,
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
  void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents dismissing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.exit_to_app, color: Colors.redAccent, size: 20),
            SizedBox(width: 10),
            Text('You are logged out ', style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 18)),
          ],
        ),
        content: Column(
           mainAxisSize: MainAxisSize.min,
          children: [
            Text('You are logged out. Too see your account please log in. Don"t have an account? Sign in to create one.' ,
            style: TextStyle(
              fontSize: 11.5
            ),),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                     loginController.logout(context); // Close the dialog
                    // Navigate to login screen or perform any other action
                  },
                  child: Text('OK', style: TextStyle(fontSize: 12,
                  color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(60, 38),
                    backgroundColor: Colors.red.shade500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                    //  loginController.logout(context); // Close the dialog
                    // Navigate to login screen or perform any other action
                  },
                  child: Text('Cancel', style: TextStyle(fontSize: 12,
                  color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                     minimumSize: Size(60, 38),
                    backgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
 
}

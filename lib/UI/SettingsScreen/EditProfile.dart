import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vkartcustomer/Controller/settings/settings_controller.dart';
import 'package:vkartcustomer/Helper/Helper.dart';
import 'package:vkartcustomer/Models/settings/profile_update_model.dart';
import '../../Components/AppTheme.dart';
import '../../Components/Forms.dart';
import '../../Components/image_pickers.dart';
import '../../Controller/EditProfileController.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with SingleTickerProviderStateMixin{
  final _formKey = GlobalKey<FormState>();
  final EditProfileScreenController controller =
      Get.put(EditProfileScreenController());
  final settingsController = Get.find<SettingsController>();


  var imageData = "";
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    settingsController.getprofile(   
        customerId: Helper.customerID.toString());

      Future.delayed(Duration(milliseconds: 1000), () {
        // Fetch profile data
        setdefault();
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

  setdefault() {
    final profile = settingsController.profiledata;
    settingsController.getprofile(customerId: Helper.customerID.toString());
    if (profile != null) {
      controller.namecontroller.text = profile.fullName ?? '';
      controller.mobilenumcontroller.text = profile.customerMobile ?? '';
      controller.addresscontroller.text = profile.customerAddress ?? '';
      controller.citycontroller.text = profile.customerCity ?? '';
      controller.statecontroller.text = profile.customerState ?? '';
      controller.pincodecontroller.text = profile.customerPincode?.toString() ?? '';
      controller.countrycontroller.text = profile.customerCountry ?? '';
      controller.emailcontroller.text = profile.customerEmail ?? '';
      controller.imageString.value = profile.customerImage ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: (){
           
              Future.delayed(Duration(milliseconds: 500));
              setState(() {
                settingsController.getprofile(customerId: Helper.customerID.toString());
              });
             Get.back();
          },
          child: Icon(Icons.arrow_back,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: ScaleTransition(
                 scale: _scaleAnimation,
            child: FadeTransition(
              opacity: _fadeInAnimation, 
              child: Column(
               children: [
               
                 // const SizedBox(height: 15),
                 Text(
                   'Edit Your Profile',
                   style: GoogleFonts.poppins(
                     color: Colors.black,
                     fontSize: 20,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                 const SizedBox(height: 15),
                 Text(
                   'Update Your Account Details!',
                   style: GoogleFonts.poppins(
                     color: Colors.black,
                     fontSize: 14,
                     fontWeight: FontWeight.w400,
                   ),
                 ),
                 const SizedBox(height: 40),
                 // Profile Picture
                 Center(
                   child: Stack(
                     children: [
                       Obx(() => Container(
                             width: 120,
                             height: 120,
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               image: DecorationImage(
                                 image: controller.item_image.value != null
                                     ? Image.file(
                                             controller.item_image.value!
                                                 .imagePath)
                                         .image
                                     : controller.imageString.value.isNotEmpty
                                         ? NetworkImage(
                                             controller.imageString.value)
                                         : const NetworkImage(
                                             'https://autorevog.blob.core.windows.net/autorevog/uploads/images/18942381.jpg',
                                           ),
                                 fit: BoxFit.cover,
                               ),
                             ),
                           )),
                       Positioned(
                         right: -25,
                         bottom: 5,
                         child: MaterialButton(
                           color: AppTheme.primaryColor,
                           shape: const CircleBorder(),
                           onPressed: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (context) => ImagePicks(
                                   previewImageList: [],
                                   isMultiple: true,
                                   title: "Select Image",
                                   onClose: () => Get.back(),
                                   onSave: (images) {
                                     if (images.isNotEmpty) {
                                       controller.item_image.value = images.first;
                                       imageData = images.first.file!.path;
                                     }
                                     Get.back();
                                   },
                                 ),
                               ),
                             );
                           },
                           child: const Icon(
                             Icons.camera_alt_rounded,
                             color: Colors.white,
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
                 const SizedBox(height: 20),
                 // Form Fields
                 ..._buildFormFields(),
                 const SizedBox(height: 20),
                 // Update Button
                 Center(
                   child: Obx(() => ElevatedButton(
                         style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // Add border radius here
                        ),
                           minimumSize: Size(
                               MediaQuery.of(context).size.width * 0.5,
                               height * 0.055),
                           backgroundColor: AppTheme.Buttoncolor,
                         ),
                         
                         onPressed: controller.isLoading.value
                             ? null
                             : () {
                                 if (_formKey.currentState!.validate()) {
                                 ProfileUpdateModel  profileupdatemodel = ProfileUpdateModel(
                                   address: controller.addresscontroller.text, 
                                   country: controller.countrycontroller.text, 
                                   customerId: Helper.customerID, 
                                   emailId: controller.emailcontroller.text, 
                                   mobileNumber: controller.mobilenumcontroller.text,
                                    name: controller.namecontroller.text, 
                                    pincode: controller.pincodecontroller.text, 
                                    city: controller.citycontroller.text, 
                                    image:imageData != ""? imageData:controller.imageString.value,
                                    state: controller.statecontroller.text);
                                    settingsController.getupdateprofile(profileupdatemodel: profileupdatemodel, context: context);
                                    settingsController.update();
                                 }
                               },
                         child: controller.isLoading.value
                             ? const CircularProgressIndicator(
                                 color: Colors.white,
                               )
                             : Text(
                                 "Update Account",
                                 style: GoogleFonts.poppins(
                                   color: Colors.white,
                                   fontSize: 15,
                                   fontWeight: FontWeight.w600,
                                 ),
                               ),
                       )),
                 ),
                 const SizedBox(height: 15),
               ],
              
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      _buildTextField(controller.namecontroller, "Enter Your Name", "Name"),
      // _buildTextField(controller.mobilenumcontroller, "Enter Your Mobile Number", "Mobile Number"),
      Padding(
  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
  child: TextField(
    controller: controller.mobilenumcontroller,
    readOnly: true,
    decoration: InputDecoration(
      label: Text(
        "Mobile Number",
        style: TextStyle(
          fontSize: 11,
          color: Colors.black
        ),
      ),
      hintText: "Enter Your Mobile Number",
      border: OutlineInputBorder(), // Default border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppTheme.Buttoncolor, width: 1), // Customize the color and width
      ),
    ),
  ),
),

      // _buildTextField(controller.emailcontroller, "Enter Your Email", "Email"),
       Padding(
  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
  child: TextField(
    controller: controller.emailcontroller,
    decoration: InputDecoration(
      label: Text(
        "Email",
        style: TextStyle(
          fontSize: 11,
          color: Colors.black
        ),
      ),
      hintText: "Enter Your Email",
      border: OutlineInputBorder(), // Default border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppTheme.Buttoncolor, width: 1), // Customize the color and width
      ),
    ),
  ),
),
      _buildTextField(controller.addresscontroller, "Enter Your Address", "Address", maxLines:2),
      _buildTextField(controller.citycontroller, "Enter Your City", "City"),
      _buildTextField(controller.statecontroller, "Enter Your State", "State"),
      _buildTextField(controller.countrycontroller, "Enter Your Country", "Country"),
      // _buildTextField(controller.pincodecontroller, "Enter Your PinCode", "PinCode"),
          Padding(
  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
  child: TextField(
    controller: controller.pincodecontroller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      label: Text(
        "PinCode",
        style: TextStyle(
          fontSize: 11,
          color: Colors.black
        ),
      ),
      hintText: "Enter Your PinCode",
      hintStyle: TextStyle(
       
          fontSize: 11,
          color: Colors.black
        
      ),
      border: OutlineInputBorder(), // Default border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppTheme.Buttoncolor, width: 1), // Customize the color and width
      ),
    ),
  ),
),
    ];
  }

  Widget _buildTextField(
      TextEditingController textController, String hintText, String label, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextInput1( 
        label: label,
        onPressed: () {},
        contentPaddingV: 15,
        controller: textController,
        textInputType: maxLines > 1 ? TextInputType.multiline : TextInputType.text,
        textColor: const Color(0xCC252525),
        hintText: hintText,
        maxLines: maxLines, // Allow multiple lines for address field
        onTextChange: (_) {},
      ),
    );
  }
  
} 

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vkartcustomer/Components/AppTheme.dart';
import 'package:vkartcustomer/Controller/settings/settings_controller.dart';
import 'package:vkartcustomer/Helper/Helper.dart';
import 'package:vkartcustomer/Models/settings/add_querys_model.dart';

import '../../Models/settings/get_querys_option_model.dart';


class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({super.key});

  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> with SingleTickerProviderStateMixin{
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var commentsController = TextEditingController();
  String? selectedItem;
  int selectedIndex = 0; 

  final settingsController = Get.find<SettingsController>();
    late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    settingsController.getquerysoption(); // Ensure to fetch options on screen load
        
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.Buttoncolor,
        automaticallyImplyLeading: false,
        title: Text(
          "Raise Your Query",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[],
      ), 
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: SingleChildScrollView(
          child: ScaleTransition(
             scale: _scaleAnimation,
            child:FadeTransition(
               opacity: _fadeInAnimation, 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "We have answers right now!",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // SizedBox(height: 30),
                  // // Name TextField
                  // // _buildTextField(nameController, "Enter Name", TextInputType.text),
                  // SizedBox(height: 20),
                  // // Email TextField
                  // _buildTextField(emailController, "Enter EmailId", TextInputType.emailAddress),
                  // SizedBox(height: 20),
                  // // Mobile Number TextField
                  // _buildTextField(mobileController, "Enter Mobile Number", TextInputType.phone),
                  SizedBox(height: 20),
                  // Dropdown Button
                  GetBuilder<SettingsController>(
                    builder: (_) {
                      return settingsController.queryoptiondata.isEmpty
                          ? Center(child: CircularProgressIndicator())
                          : Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: DropdownButtonFormField<String>(
                                value: selectedItem,
                                items: settingsController.queryoptiondata
                                    .map((QuerysoptionData item) {
                                  return DropdownMenuItem<String>(
                                    value: item.queryTitle,
                                    child: Text(item.queryTitle,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedItem = newValue;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Select Your Query',
                                  labelStyle: TextStyle(fontSize: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                  SizedBox(height: 20),
                  // Comments TextField
                  _buildTextField(commentsController, "Enter Your Comments", TextInputType.text),
                  SizedBox(height: 50),
                  // Submit Button
                  Center(
                child: Obx(() => settingsController.isLoading.isFalse
                    ? GestureDetector(
              onTap: () async {
                // Set loading state to true
                settingsController.isLoading(true);
              
                AddQuerysModel addquerymodel = AddQuerysModel(
                  coustomerId: Helper.customerID,
                  queryId: settingsController.queryoptiondata[selectedIndex].queryOptionId.toString(),
                  querys: commentsController.text,
                );
              
                // Call the API
                await settingsController.getaddQerys(addquerysmodel: addquerymodel, context: context);
              
                // Reset loading state to false after API call completes
                settingsController.isLoading(false);
              
                // Optionally update the state
                settingsController.update();
                Get.back();
              },
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: AppTheme.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
                      )
                    : CircularProgressIndicator(
              color: AppTheme.green,
                      )),
              ),
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // A helper method to build text fields
  Widget _buildTextField(
    TextEditingController controller, 
    String label, 
    TextInputType inputType) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

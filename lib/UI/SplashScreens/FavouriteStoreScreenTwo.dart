import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Binding/FavouriteStoreScreenTwoBinding.dart';
import '../../Components/AppTheme.dart';
import '../../Components/Forms.dart';
import '../../Controller/FavouriteStoreScreenTwoController.dart';
import '../../utility/BottomNavigationBar.dart';

//
//This page is used to show the selected details in the favoritestoreScreen
//
class FavouriteStoreScreenTwo extends GetView<FavouriteStoreScreenTwoBinding> {
   FavouriteStoreScreenTwo({Key? key}) : super(key: key);
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouriteStoreScreenTwoController>(
      init: FavouriteStoreScreenTwoController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/Grosshop G.png',
                            height: 50,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'express',
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Shop Your \n'
                            'Favourite Store ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w800, 
                              fontSize: 40, 
                              color: AppTheme.Frontcolor),
                          ),
                          // )
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Column(
                      children: [
                        TextField(

                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                              hintText: 'Selected location',
                              hintStyle: TextStyle(
                                color: Colors.lightGreen,
                                fontSize: 17, // Choose the desired alignment
                              ),
                              prefixIcon: Icon(
                                Icons.location_on_outlined,
                                color: Colors.lightGreen,
                              )),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            hintText: 'Selected',
                            hintStyle: TextStyle(
                              fontSize: 14, // Choose the desired alignment
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        TextField(

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            hintText: 'Selected',
                            hintStyle: TextStyle(
                              fontSize: 14, // Choose the desired alignment
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.16,
                    ),
                    Center(
                      child: Button(
                        widthFactor: 0.9,
                        heightFactor: 0.06,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const navigateBar(
                                        initialIndex: 0,
                                      )));
                        },
                        child: Text('Start Shopping',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

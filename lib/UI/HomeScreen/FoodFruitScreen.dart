import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Components/AppTheme.dart';
import '../../Controller/FoodFruitScreenController.dart';

class FoodFruitScreen extends GetView<FoodFruitScreenController> {
  FoodFruitScreen({super.key});
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodFruitScreenController>(
      init: FoodFruitScreenController(),
      builder: (controller) {
        return Scaffold(
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 50),
                    child: Text(
                      ' Welcome ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black26),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 10),
                    child: Text(
                      'Allison Franci ',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Image.asset(
                    'assets/images/profile.png',
                    height: 50,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 20),
                    child: Container(
                      height: 40,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppTheme.IconBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.sort_outlined,
                          color: AppTheme.Buttoncolor,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.06,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: 'Search Golosdvscery',
                          hintStyle: TextStyle(
                            fontSize: 14, // Choose the desired alignment
                          ),
                          prefixIcon: Icon(Icons.search)),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => MyOrderScreen(),
                      //   ),
                      // );
                    },
                    child: Text(
                      '',
                      style: TextStyle(
                        color: isSelected
                            ? AppTheme.Buttoncolor
                            : AppTheme.Frontcolor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                      color: AppTheme.Buttoncolor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {},
                  //   child: Obx(
                  //     () => Text(
                  //       'Fruits',
                  //       style: TextStyle(
                  //         color: isSelected
                  //             ? AppTheme.Buttoncolor
                  //             : AppTheme.Frontcolor,
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              FruitProductsList(context),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget FruitProductsList(BuildContext context) {
    FoodFruitScreenController FruitsController =
        Get.put(FoodFruitScreenController());

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 8,
                mainAxisSpacing: 5,
                shrinkWrap: true,
                children: List.generate(
                  FruitsController.FruitsProducts.length,
                  (index) {
                    final product = FruitsController.FruitsProducts[index];
                    return InkWell(
                      onTap: () {
                        //
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => OrangeFruitsScreen(),
                        //     ));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(right: 10, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                child: Image.asset(
                                  product.image,
                                  width: width * 0.5,
                                  height: height * 0.2,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    product.ProductName,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      product.ProductType,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color(0xFF475269).withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Center(
                                      child: Text(
                                        product.Price,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: AppTheme.Buttoncolor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/shoppingBag.svg',
                                      height: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

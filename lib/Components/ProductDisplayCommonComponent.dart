import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controller/ProductHomeScreenController.dart';
import '../Controller/cartItem/cartItem_controller.dart';
import '../Helper/Helper.dart';
import 'AppTheme.dart';

class ProductDisplayCommonComponent extends StatefulWidget {
  final String productname;
  final int productID;
  final String shopName;
  final String productQty;
  final String productCategory;
  final dynamic productprice;
  final String productDiscountPrice;
  final String productimage;
  final dynamic? productDuplicatePrice;
  final bool? isFavaurite;
  final dynamic? discountAvailable;
  final String? soldOut;
  final dynamic  offerPercentage;
  final VoidCallback? onTap;
  final int counter;
  final dynamic ?actualprice;
  final int index;
  final VoidCallback? incrementCounter;
  final VoidCallback? decrementCounter;
  final BuildContext? outerContext;

  ProductDisplayCommonComponent({
    Key? key,
    required this.productimage,
    required this.productID,
    required this.productQty,
    required this.productprice,
    required this.shopName,
    required this.productname,
    required this.productCategory,
    required this.onTap,
    this.isFavaurite,
    required this.productDiscountPrice,
    this.productDuplicatePrice,
    this.discountAvailable,
    this.decrementCounter,
    this.incrementCounter,
    this.soldOut,
    required this.index,
    this.offerPercentage,
    this.counter = 0,
    this.outerContext,
     this.actualprice,
  }) : super(key: key);

  @override
  _ProductDisplayCommonComponentState createState() => _ProductDisplayCommonComponentState();
}

class _ProductDisplayCommonComponentState extends State<ProductDisplayCommonComponent> {
  final cartitemController = Get.find<CartitemController>();


  @override
  Widget build(BuildContext context) {
    ProductHomeScreenController controller = Get.put(ProductHomeScreenController());
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    print("PRODUCT PRICE ==?  ${widget.productprice}");

    return Padding(
      padding: const EdgeInsets.only(left: 1,right: 1),
      child: RefreshIndicator(
      
                                        onRefresh: ()async{
                                          controller.refreshData();
                                        },
        child: Column(
          children: [
            Container(
              width: screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ensures space between columns
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.32,
                    child: Column(
                      children: [
                        Container(
                          child: Stack(
                            children: <Widget>[
                              widget.productimage == null || widget.productimage.isEmpty
                                  ? Container(
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      height: MediaQuery.of(context).size.height * 0.06,
                                      color: Colors.white,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.30,
                                        height: MediaQuery.of(context).size.height * 0.1,
                                        
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: '${widget.productimage}',
                                                width: 100,
                                                  height:100,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) => SizedBox(
                                                  height: MediaQuery.of(context).size.height * 0.01,
                                                  width: MediaQuery.of(context).size.width * 0.02,
                                                  child: Image(
                                                    height: 30,
                                                    width: 30,
                                                    image: AssetImage("assets/images/vkart_10.png"),
                                                  ),
                                                ),
                                                errorWidget: (context, url, error) => const Image(
                                                  height: 30,
                                                  width: 30,
                                                  image: AssetImage("assets/images/vkart_10.png"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    // Ensures second column takes equal space
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ 
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                textAlign: TextAlign.start,
                                '${widget.productname}',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  textAlign: TextAlign.start,
                                  '${widget.productCategory}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                   
                                        //  Flexible(
                                        //     child: Text(
                                        //       '₹ ${widget.productDiscountPrice}',
                                        //       style: GoogleFonts.poppins(
                                        //         color: AppTheme.Buttoncolor,
                                        //         fontSize: screenWidth * 0.045,
                                        //         fontWeight: FontWeight.w600,
                                        //       ),
                                        //     ),
                                        //   ),
                                       Flexible(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '(${widget.productQty})',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: screenWidth * 0.03,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                //SizedBox(width: screenWidth * 0.02),
                                               widget.discountAvailable==1? Text(
                                                  '₹ ${widget.productprice}',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.red,
                                                    fontSize: screenWidth * 0.032,
                                                    fontWeight: FontWeight.w600,
                                                    decoration: TextDecoration.lineThrough,
                                                  ),
                                                ):Text(
                                                  '₹ ${widget.productprice}',
                                                  style: GoogleFonts.poppins(
                                                      color: AppTheme.Buttoncolor,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                ),
                                                widget.discountAvailable==1?
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 5),
                                                  child: Text(
                                                    '₹${widget.productDiscountPrice}',
                                                    style: GoogleFonts.poppins(
                                                      color: AppTheme.Buttoncolor,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ):Text(''),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.soldOut == "yes"
                      ? Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: const SizedBox(
                            child: Image(height: 90, width: 90, image: AssetImage("assets/images/SoldOut.PNG")),
                          ),
                        )
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // First Column: Offer Percentage and Price
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: screenHeight * 0.04,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      widget.soldOut == "yes"
                                          ? const SizedBox()
                                          : Padding(
                                              padding: const EdgeInsets.only(left: 0),
                                              child:widget.discountAvailable==1? Text(
                                                '${widget.offerPercentage} % Off',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400
                                                ),
                                              ):Text(''),
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.03,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      widget.counter > 0
                                          ? Padding(
                                              padding: const EdgeInsets.only(left: 0),
                                              child: Helper.offerState ==true ? Text(
                                                '₹ ${widget.actualprice}',
                                                /* widget.discountAvailable == 0 ? '₹ ${widget.productDuplicatePrice}' : '₹${widget.productDiscountPrice}',*/
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ):Text(
                                                '₹ ${widget.actualprice.toString()}',
                                                /* widget.discountAvailable == 0 ? '₹ ${widget.productDuplicatePrice}' : '₹${widget.productDiscountPrice}',*/
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(left: 0),
                                              child: Text(
                                                ' ${''}',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.06,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    widget.counter > 0
                                        ? Row(
                                            children: [
                                              InkWell(
                                                onTap: widget.counter > 1
                                                    ? () {
                                                  Helper.productID = widget.productID;
                                                         widget.decrementCounter!();
                                                        if(Helper.customerID != 0){
                                                          cartitemController.getCartCount(customerId: Helper.customerID);
                                                        }
                                                      }
                                                    : () {
                                                  Helper.productID = widget.productID;
                                                        widget.decrementCounter!();
                                                        if(Helper.customerID != 0){
                                                          cartitemController.getCartCount(customerId: Helper.customerID);
                                                        }
                                                      },
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(100),
                                                    color: widget.counter > 1 ? Colors.red : AppTheme.IconBackground,
                                                  ),
                                                  child: Icon(
                                                    CupertinoIcons.minus,
                                                    color: widget.counter > 1 ? Colors.white : AppTheme.Buttoncolor,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                widget.counter.toString(),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              InkWell(
                                                onTap: (){
                                                  Helper.productID = widget.productID;
                                                  widget.incrementCounter!();
                                                  if(Helper.customerID != 0){
                                                    cartitemController.getCartCount(customerId: Helper.customerID);
                                                    
                                                  }
                                                  Future.delayed(Duration(seconds: 1),(){
                                                    setState(() {
        
                                                    });
                                                  });
        
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(100),
                                                    color: AppTheme.Buttoncolor,
                                                  ),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : InkWell(
                                            onTap: widget.soldOut == "yes"
                                                ? null // Disable the button if soldOut is "yes"
                                                : () {
                                              Helper.productID = widget.productID!;
                                              print("ADD BUTTON PROid ===>${Helper.productID}");
                                                    widget.incrementCounter?.call();
        
                                                    if (Helper.customerID != 0) {
        
                                                      cartitemController.getCartCount(customerId:Helper.customerID );
                                                    }
                                                  },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: widget.soldOut == "yes" ? Colors.grey : AppTheme.Buttoncolor,
                                              ),
                                              child: Text(
                                                widget.soldOut == "yes" ? 'Sold Out' : 'Add',
                                                style: GoogleFonts.poppins(
                                                  color: widget.soldOut == "yes" ? Colors.black : Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                ],
              ),
            ),
            Container(
              height: 2,
              child: Obx(() {
                return controller.getLoading(widget.index)
                    ? const LinearProgressIndicator(
                        minHeight: 2,
                        color: AppTheme.Buttoncolor,
                        backgroundColor: Colors.white,
                      )
                    : SizedBox.shrink();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
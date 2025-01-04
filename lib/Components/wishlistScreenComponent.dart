import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AppTheme.dart';

class WishlistScreenCommonComponent extends StatefulWidget {
  final String productname;
  final String? shopName;
  final String productQty;
  final String productCategory;
  final String productprice;
  final String productDiscountPrice;
  final String productimage;
  final String? productDuplicatePrice;
  final bool? isFavaurite;
  final int? discountAvailable;
  final VoidCallback? onTap;
  final int counter;
  final VoidCallback? incrementCounter;
  final VoidCallback? decrementCounter;

  WishlistScreenCommonComponent({
    Key? key,
    required this.productimage,
    required this.productQty,
    required this.productprice,
    this.shopName,
    required this.productname,
    required this.productCategory,
    required this.onTap,
    this.isFavaurite,
    required this.productDiscountPrice,
    this.productDuplicatePrice,
    this.discountAvailable,
    this.decrementCounter,
    this.incrementCounter,
    this.counter = 1,
  }) : super(key: key);

  @override
  _WishlistScreenCommonComponentState createState() => _WishlistScreenCommonComponentState();
}

class _WishlistScreenCommonComponentState extends State<WishlistScreenCommonComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.13,
        child: Row(
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
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.06,
                          color: Colors.white,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                '${widget.productimage}',
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: MediaQuery.of(context).size.height * 0.1,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.image); // Placeholder icon for error
                                },
                              )),
                        ),
                      ),
                // Positioned(
                //   left: 80,
                //   bottom: 50,
                //   child: InkWell(
                //     onTap: widget.onTap,
                //     child: widget.isFavaurite == true
                //         ? Icon(
                //             Icons.favorite,
                //             size: 20,
                //             color: Colors.redAccent,
                //           )
                //         : Icon(
                //             Icons.favorite_border,
                //             size: 20,
                //             color: Colors.redAccent,
                //             //               ],
                //           ),
                //   ),
                // )
              ],
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.50,
                      //height: MediaQuery.of(context).size.height * 0.01,
                      child: Text('${widget.productname}',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {} /*widget.OnPressed*/,
                      icon: Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.orange,
                      ),
                    )
                  ],
                ),
                Container(
                  width: 200,
                  child: Text(
                    '${widget.productCategory}',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        widget.discountAvailable == null || widget.discountAvailable == 0
                            ? Text('₹ ${widget.productprice}',
                                style: GoogleFonts.poppins(
                                  color: AppTheme.Buttoncolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ))
                            : Column(
                                children: [
                                  Text('₹ ${widget.productprice}',
                                      style: GoogleFonts.poppins(
                                        color: Colors.red,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.lineThrough,
                                      )),
                                  Text('₹${widget.productDiscountPrice}',
                                      style: GoogleFonts.poppins(
                                        color: AppTheme.Buttoncolor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              )
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Text('(${widget.productQty})',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                              )),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 40),
                          //   child: Text('₹ ${widget.productDuplicatePrice}',
                          //       style: GoogleFonts.poppins(
                          //         color: Colors.black,
                          //         fontSize: 13,
                          //         fontWeight: FontWeight.w600,
                          //       )),
                          // ),
                        ],
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     InkWell(
                    //       onTap: widget.decrementCounter,
                    //       child: Container(
                    //         padding: EdgeInsets.all(5),
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(100), color: widget.counter == 1 ? AppTheme.IconBackground : Colors.red),
                    //         child: Icon(
                    //           CupertinoIcons.minus,
                    //           color: widget.counter == 1 ? AppTheme.Buttoncolor : Colors.white,
                    //           size: 15,
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: MediaQuery.of(context).size.width * 0.02,
                    //     ),
                    //     Text(
                    //       widget.counter.toString(),
                    //       style: TextStyle(
                    //         fontSize: 12,
                    //         fontWeight: FontWeight.w400,
                    //         color: widget.counter > 1 ? Colors.black : Colors.red,
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: MediaQuery.of(context).size.width * 0.02,
                    //     ),
                    //     InkWell(
                    //       onTap: widget.incrementCounter,
                    //       child: Container(
                    //         padding: EdgeInsets.all(5),
                    //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppTheme.Buttoncolor),
                    //         child: Icon(
                    //           Icons.add,
                    //           color: Colors.white,
                    //           size: 15,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}

import 'dart:convert';

OffersClickModel offersClickModelFromJson(String str) =>
    OffersClickModel.fromJson(json.decode(str));

String offersClickModelToJson(OffersClickModel data) => json.encode(data.toJson());

class OffersClickModel {
  String message;
  bool error;
  List<OffersClickData> data;

  OffersClickModel({
    required this.message,
    required this.error,
    required this.data,
  });

  factory OffersClickModel.fromJson(Map<String, dynamic> json) => OffersClickModel(
        message: json["message"],
        error: json["error"],
        data: List<OffersClickData>.from(
          json["data"].map((x) => OffersClickData.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OffersClickData {
  int productId;
  int sellerId;
  String shopName;
  String productName;
  String productQty;
  dynamic productPrice;
  dynamic actualPrice;
  int cartQuantity;
  dynamic productDescription;
  String productImage;
  String folderName;
  String productMainCategoryName;
  String productSubCategoryName;
  dynamic productMainCategoryId;
  int productSubCategoryId;
  dynamic soldOut;
  dynamic discountAvailable;
  dynamic discountPercentage;
  dynamic productDiscountPrice;
  dynamic productDiscountNote;

  OffersClickData({
    required this.productId,
    required this.sellerId,
    required this.shopName,
    required this.productName,
    required this.productQty,
    required this.productPrice,
    required this.actualPrice,
    required this.cartQuantity,
    required this.productDescription,
    required this.productImage,
    required this.folderName,
    required this.productMainCategoryName,
    required this.productSubCategoryName,
    required this.productMainCategoryId,
    required this.productSubCategoryId,
    required this.soldOut,
    required this.discountAvailable,
    required this.discountPercentage,
    required this.productDiscountPrice,
    required this.productDiscountNote,
  });

  factory OffersClickData.fromJson(Map<String, dynamic> json) => OffersClickData(
        productId: json["productId"] ?? 0,
        sellerId: json["sellerId"] ?? 0,
        shopName: json["shopName"] ?? '',
        productName: json["productName"] ?? '',
        productQty: json["productQty"]?.toString() ?? '',
        productPrice: json["productPrice"]?.toString() ?? '',
        actualPrice: json["actualPrice"]?.toString() ?? '',
        cartQuantity: json["cartQuantity"] ?? 0,
        productDescription: json["productDescription"] ?? '',
        productImage: json["productImage"] ?? '',
        folderName: json["folderName"] ?? '',
        productMainCategoryName: json["productMainCategoryName"] ?? '',
        productSubCategoryName: json["productSubCategoryName"] ?? '',
        productMainCategoryId: json["productMainCategoryId"] ?? 0,
        productSubCategoryId: json["productSubCategoryId"] ?? 0,
        soldOut: json["SoldOut"] ?? '',
        discountAvailable: json["discountAvailable"] ?? 0,
        discountPercentage: json["discountPercentage"]?.toString() ?? '',
        productDiscountPrice: json["productDiscountPrice"]?.toString() ?? '',
        productDiscountNote: json["productDiscountNote"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "sellerId": sellerId,
        "shopName": shopName,
        "productName": productName,
        "productQty": productQty,
        "productPrice": productPrice,
        "actualPrice": actualPrice,
        "cartQuantity": cartQuantity,
        "productDescription": productDescription,
        "productImage": productImage,
        "folderName": folderName,
        "productMainCategoryName": productMainCategoryName,
        "productSubCategoryName": productSubCategoryName,
        "productMainCategoryId": productMainCategoryId,
        "productSubCategoryId": productSubCategoryId,
        "SoldOut": soldOut,
        "discountAvailable": discountAvailable,
        "discountPercentage": discountPercentage,
        "productDiscountPrice": productDiscountPrice,
        "productDiscountNote": productDiscountNote,
      };
}

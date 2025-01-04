class wishListApiResponseModel {
  String? message;
  bool? error;
  List<WishlistData>? data;

  wishListApiResponseModel({this.message, this.error, this.data});

  wishListApiResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <WishlistData>[];
      json['data'].forEach((v) {
        data!.add(new WishlistData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishlistData {
  String? customerId;
  int? productId;
  int? sellerId;
  String? productName;
  String? productQty;
  String? productPrice;
  String? productDescription;
  String? productImage;
  String? productCategory;
  int? discountAvailable;
  String? discountPercentage;
  String? productDiscountPrice;
  String? productDiscountNote;
  int? rating;

  WishlistData(
      {this.customerId,
      this.productId,
      this.sellerId,
      this.productName,
      this.productQty,
      this.productPrice,
      this.productDescription,
      this.productImage,
      this.productCategory,
      this.discountAvailable,
      this.discountPercentage,
      this.productDiscountPrice,
      this.productDiscountNote,
      this.rating});

  WishlistData.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    productId = json['productId'];
    sellerId = json['sellerId'];
    productName = json['productName'];
    productQty = json['productQty'];
    productPrice = json['productPrice'];
    productDescription = json['productDescription'];
    productImage = json['productImage'];
    productCategory = json['productCategory'];
    discountAvailable = json['discountAvailable'];
    discountPercentage = json['discountPercentage'];
    productDiscountPrice = json['productDiscountPrice'];
    productDiscountNote = json['productDiscountNote'];
    rating = json['Rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['productId'] = this.productId;
    data['sellerId'] = this.sellerId;
    data['productName'] = this.productName;
    data['productQty'] = this.productQty;
    data['productPrice'] = this.productPrice;
    data['productDescription'] = this.productDescription;
    data['productImage'] = this.productImage;
    data['productCategory'] = this.productCategory;
    data['discountAvailable'] = this.discountAvailable;
    data['discountPercentage'] = this.discountPercentage;
    data['productDiscountPrice'] = this.productDiscountPrice;
    data['productDiscountNote'] = this.productDiscountNote;
    data['Rating'] = this.rating;
    return data;
  }
}

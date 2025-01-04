class ProductHomeResponse {
  String? message;
  bool? error;
  List<Data>? data;

  ProductHomeResponse({this.message, this.error, this.data});

  ProductHomeResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? productId;
  int? sellerId;
  String? shopName;
  String? productName;
  String? productQty;
  dynamic productPrice;
  dynamic productPriceDuplicate;
  dynamic actualPrice;
  dynamic? cartQuantity;
  String? productDescription;
  String? productImage;
  String? productCategory;
  String? soldOut;
  dynamic? discountAvailable;
  dynamic? discountPercentage;
  String? productDiscountPrice;
  String? productDiscountNote;

  Data(
      {this.productId,
      this.sellerId,
      this.shopName,
      this.productName,
      this.productQty,
      this.productPrice,
      this.productPriceDuplicate,
      this.actualPrice,
      this.cartQuantity,
      this.productDescription,
      this.productImage,
      this.productCategory,
      this.soldOut,
      this.discountAvailable,
      this.discountPercentage,
      this.productDiscountPrice,
      this.productDiscountNote});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['productId']??0;
    sellerId = json['sellerId']??0;
    shopName = json['shopName']??'';
    productName = json['productName']??'';
    productQty = json['productQty']??'';
    productPrice = json['productPrice']??'';
    productPriceDuplicate = json['productPrice']??'';
    actualPrice = json['actualPrice']??'';
    cartQuantity = json['cartQuantity']??'';
    productDescription = json['productDescription']??'';
    productImage = json['productImage']??'';
    productCategory = json['productCategory']??'';
    soldOut = json['SoldOut']??'';
    discountAvailable = json['discountAvailable']??'';
    discountPercentage = json['discountPercentage']??'';
    productDiscountPrice = json['productDiscountPrice']??'';
    productDiscountNote = json['productDiscountNote']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['sellerId'] = this.sellerId;
    data['shopName'] = this.shopName;
    data['productName'] = this.productName;
    data['productQty'] = this.productQty;
    data['productPrice'] = this.productPrice;
    data['productPrice'] = this.productPriceDuplicate;
    data['actualPrice'] = this.actualPrice;
    data['cartQuantity'] = this.cartQuantity;
    data['productDescription'] = this.productDescription;
    data['productImage'] = this.productImage;
    data['productCategory'] = this.productCategory;
    data['SoldOut'] = this.soldOut;
    data['discountAvailable'] = this.discountAvailable;
    data['discountPercentage'] = this.discountPercentage;
    data['productDiscountPrice'] = this.productDiscountPrice;
    data['productDiscountNote'] = this.productDiscountNote;
    return data;
  }
}

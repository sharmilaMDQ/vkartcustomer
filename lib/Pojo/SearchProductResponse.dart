class SearchResponse {
  String? message;
  bool? error;
  List<Data>? data;

  SearchResponse({this.message, this.error, this.data});

  SearchResponse.fromJson(Map<String, dynamic> json) {
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
  String? productName;
  String? productQty;
  String? productPrice;
  String? productDescription;
  String? productImage;
  int? productCategory;
  String? soldOut;
  String? discountAvailable;
  String? productDiscountPrice;
  String? productDiscountNote;

  Data(
      {this.productId,
      this.sellerId,
      this.productName,
      this.productQty,
      this.productPrice,
      this.productDescription,
      this.productImage,
      this.productCategory,
      this.soldOut,
      this.discountAvailable,
      this.productDiscountPrice,
      this.productDiscountNote});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    sellerId = json['sellerId'];
    productName = json['productName'];
    productQty = json['productQty'];
    productPrice = json['productPrice'];
    productDescription = json['productDescription'];
    productImage = json['productImage'];
    productCategory = json['productCategory'];
    soldOut = json['SoldOut'];
    discountAvailable = json['discountAvailable'];
    productDiscountPrice = json['productDiscountPrice'];
    productDiscountNote = json['productDiscountNote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['sellerId'] = this.sellerId;
    data['productName'] = this.productName;
    data['productQty'] = this.productQty;
    data['productPrice'] = this.productPrice;
    data['productDescription'] = this.productDescription;
    data['productImage'] = this.productImage;
    data['productCategory'] = this.productCategory;
    data['SoldOut'] = this.soldOut;
    data['discountAvailable'] = this.discountAvailable;
    data['productDiscountPrice'] = this.productDiscountPrice;
    data['productDiscountNote'] = this.productDiscountNote;
    return data;
  }
}

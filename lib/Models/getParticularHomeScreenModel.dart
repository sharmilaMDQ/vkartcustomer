class getParticularHomeScreenProducts {
  String? message;
  bool? error;
  particularProductData? data;

  getParticularHomeScreenProducts({this.message, this.error, this.data});

  getParticularHomeScreenProducts.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new particularProductData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class particularProductData {
  int? productId;
  int? sellerId;
  String? productName;
  String? productQty;
  String? productPrice;
  String? productDescription;
  String? productImage;
  String? productCategory;
  dynamic? discountAvailable;
  String? discountPercentage;
  String? productDiscountPrice;
  String? productDiscountNote;
  dynamic? rating;

  particularProductData(
      {this.productId,
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

  particularProductData.fromJson(Map<String, dynamic> json) {
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

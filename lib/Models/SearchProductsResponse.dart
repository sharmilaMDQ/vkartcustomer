class SearchProductsResponse {
  String? message;
  bool? error;
  List<SearchProductsResponseData>? data;

  SearchProductsResponse({this.message, this.error, this.data});

  SearchProductsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';
    error = json['error'] ?? false;
    if (json['data'] != null) {
      data = <SearchProductsResponseData>[];
      json['data'].forEach((v) {
        data!.add(SearchProductsResponseData.fromJson(v));
      });
    } else {
      data = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = this.message ?? '';
    data['error'] = this.error ?? false;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    } else {
      data['data'] = [];
    }
    return data;
  }
}

class SearchProductsResponseData {
  int? productId;
  int? sellerId;
  int? cartQuantity;
  String? productName;
  String? productQty;
  dynamic productPrice;
  String? productDescription;
  String? productImage;
  String? productCategory;
  String? soldOut;
  dynamic discountAvailable;
  String? productDiscountPrice;
  String? actualPrice;
  String? productDiscountNote;
  String? discountPercentage;
  String? subCategory;
  String? searchKey;

  SearchProductsResponseData({
    this.productId,
    this.sellerId,
    this.cartQuantity,
    this.actualPrice,
    this.productName,
    this.productQty,
    this.productPrice,
    this.productDescription,
    this.productImage,
    this.productCategory,
    this.soldOut,
    this.discountAvailable,
    this.productDiscountPrice,
    this.discountPercentage,
    this.productDiscountNote,
    this.subCategory,
    this.searchKey,
  });

  SearchProductsResponseData.fromJson(Map<String, dynamic> json) {
    productId = _parseInt(json['productId'])??0;
    sellerId = _parseInt(json['sellerId'])??0;
    cartQuantity = _parseInt(json['cartQuantity'])??0;
    productName = json['productName'] ?? '';
    productQty = json['productQty'] ?? '';
    productPrice = json['productPrice'] ?? 0.0;
    productDescription = json['productDescription'] ?? '';
    productImage = json['productImage'] ?? '';
    productCategory = json['productCategory'] ?? '';
    soldOut = json['SoldOut'] ?? '';
    discountAvailable = json['discountAvailable'] ?? "";
    productDiscountPrice = json['productDiscountPrice'] ?? '';
    actualPrice = json['actualPrice'] ?? '';
    productDiscountNote = json['productDiscountNote'] ?? '';
    discountPercentage = json['discountPercentage'] ?? '';
    subCategory = json['sub_category'] ?? '';
    searchKey = json['searchKey'] ?? '';
  }

  int? _parseInt(dynamic value) {
    if (value is String) {
      return int.tryParse(value);
    }
    return value as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = this.productId;
    data['sellerId'] = this.sellerId;
    data['cartQuantity'] = this.cartQuantity;
    data['productName'] = this.productName;
    data['productQty'] = this.productQty;
    data['productPrice'] = this.productPrice;
    data['productDescription'] = this.productDescription;
    data['productImage'] = this.productImage;
    data['productCategory'] = this.productCategory;
    data['SoldOut'] = this.soldOut;
    data['discountAvailable'] = this.discountAvailable;
    data['productDiscountPrice'] = this.productDiscountPrice;
    data['actualPrice'] = this.actualPrice;
    data['productDiscountNote'] = this.productDiscountNote;
    data['discountPercentage'] = this.discountPercentage;
    data['sub_category'] = this.subCategory;
    data['searchKey'] = this.searchKey;
    return data;
  }
}

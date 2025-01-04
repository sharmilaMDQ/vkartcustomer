class GetCartResponse {
  String? message;
  bool? error;
  List<CartData>? data;
  String? subtotal;
  dynamic discount;
  dynamic total;

  GetCartResponse({
    this.message,
    this.error,
    this.data,
    this.subtotal,
    this.discount,
    this.total,
  });

  GetCartResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <CartData>[];
      json['data'].forEach((v) {
        data!.add(CartData.fromJson(v));
      });
    }
    subtotal = json['subtotal']?.toString(); // Handle type mismatch
    discount = json['discount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['subtotal'] = subtotal;
    data['discount'] = discount;
    data['total'] = total;
    return data;
  }
}

class CartData {
  int? cartId;
  int? productId;
  dynamic? cartQty;
  dynamic? sellerId;
  String? productName;
  String? productQty;
  double? productPrice;
  double? productPriceDuplicate;
  String? productImage;
  String? productDescription;
  int? discountAvailable;
  double? discountPercentage;
  String? productDiscountPrice;
  String? productDiscountNote;
  double? actualPrice;
  String? category;

  CartData({
    this.cartId,
    this.productId,
    this.cartQty,
    this.sellerId,
    this.productName,
    this.productQty,
    this.productPrice,
    this.productPriceDuplicate,
    this.productImage,
    this.productDescription,
    this.discountAvailable,
    this.discountPercentage,
    this.productDiscountPrice,
    this.productDiscountNote,
    this.actualPrice,
    this.category,
  });

  CartData.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'] is int ? json['cartId'] : int.tryParse(json['cartId']?.toString() ?? '0');
    productId = json['productId'] is int ? json['productId'] : int.tryParse(json['productId']?.toString() ?? '0');
    cartQty = json['cartQty'] is int ? json['cartQty'] : int.tryParse(json['cartQty']?.toString() ?? '0');
    sellerId = json['sellerId'] is int ? json['sellerId'] : int.tryParse(json['sellerId']?.toString() ?? '0');
    productName = json['productName']?.toString() ?? '';
    productQty = json['productQty']?.toString() ?? '';
    productPrice = json['productPrice'] is double ? json['productPrice'] : double.tryParse(json['productPrice']?.toString() ?? '0.0');
    productPriceDuplicate = json['productPriceDuplicate'] is double ? json['productPriceDuplicate'] : double.tryParse(json['productPriceDuplicate']?.toString() ?? '0.0');
    productImage = json['productImage']?.toString() ?? '';
    productDescription = json['productDescription']?.toString() ?? '';
    discountAvailable = json['discountAvailable']??0;
    discountPercentage = json['discountPercentage'] is double ? json['discountPercentage'] : double.tryParse(json['discountPercentage']?.toString() ?? '0.0');
    productDiscountPrice = json['productDiscountPrice']?.toString() ?? '';
    productDiscountNote = json['productDiscountNote']?.toString() ?? '';
    category = json['productMainCategoryName']?.toString() ?? '';
    actualPrice = json['actualPrice'] is double ? json['actualPrice'] : double.tryParse(json['actualPrice']?.toString() ?? '0.0');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cartId'] = cartId;
    data['productId'] = productId;
    data['cartQty'] = cartQty;
    data['sellerId'] = sellerId;
    data['productName'] = productName;
    data['productQty'] = productQty;
    data['productPrice'] = productPrice;
    data['productPriceDuplicate'] = productPriceDuplicate;
    data['productImage'] = productImage;
    data['productDescription'] = productDescription;
    data['discountAvailable'] = discountAvailable;
    data['discountPercentage'] = discountPercentage;
    data['productDiscountPrice'] = productDiscountPrice;
    data['productDiscountNote'] = productDiscountNote;
    data['actualPrice'] = actualPrice;
    data['productMainCategoryName'] = category;
    return data;
  }
}

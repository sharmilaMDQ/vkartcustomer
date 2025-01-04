class DisplaySelectedProductResponse {
  String? message;
  bool? error;
  List<SelectedProductData>? data;

  DisplaySelectedProductResponse({this.message, this.error, this.data});
  DisplaySelectedProductResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <SelectedProductData>[];
      json['data'].forEach((v) {
        data!.add(new SelectedProductData.fromJson(v));
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

class SelectedProductData {
  String? productName;
  String? productQty;
  String? productPrice;
  String? productImage;
  String? mainCategory;

  SelectedProductData(
      {this.productName,
      this.productQty,
      this.productPrice,
      this.productImage,
      this.mainCategory});

  SelectedProductData.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productQty = json['product_qty'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
    mainCategory = json['main_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_qty'] = this.productQty;
    data['product_price'] = this.productPrice;
    data['product_image'] = this.productImage;
    data['main_category'] = this.mainCategory;
    return data;
  }
}

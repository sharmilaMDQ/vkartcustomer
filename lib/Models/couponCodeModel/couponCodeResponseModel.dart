class CouponCodeApplyModel {
  String? message;
  bool? error;
  CouponData? data;

  CouponCodeApplyModel({this.message, this.error, this.data});

  CouponCodeApplyModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new CouponData.fromJson(json['data']) : null;
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

class CouponData {
  String? subtotal;
  String? discount;
  dynamic? total;
  String? deliveryFee;
  dynamic? promoCodeDiscount;

  CouponData({this.subtotal, this.discount, this.total, this.deliveryFee, this.promoCodeDiscount});

  CouponData.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    discount = json['discount'];
    total = json['total'];
    deliveryFee = json['deliveryFee'];
    promoCodeDiscount = json['promoCodeDiscount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['discount'] = this.discount;
    data['total'] = this.total;
    data['deliveryFee'] = this.deliveryFee;
    data['promoCodeDiscount'] = this.promoCodeDiscount;
    return data;
  }
}

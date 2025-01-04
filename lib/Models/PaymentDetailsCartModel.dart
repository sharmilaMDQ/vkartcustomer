class PaymentDetailsCart {
  String? message;
  bool? error;
  PaymentCart? data;

  PaymentDetailsCart({this.message, this.error, this.data});

  PaymentDetailsCart.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new PaymentCart.fromJson(json['data']) : null;
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

class PaymentCart {
  int? subtotal;
  int? discountPrice;
  int? total;

  PaymentCart({this.subtotal, this.discountPrice, this.total});

  PaymentCart.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    discountPrice = json['discountPrice'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['discountPrice'] = this.discountPrice;
    data['total'] = this.total;
    return data;
  }
}

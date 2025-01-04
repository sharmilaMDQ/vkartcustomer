class AddCartProductResponse {
  String? message;
  bool? error;
  bool? missmatch;
  String? subtotal;
  dynamic? discount;
  dynamic? total;
  dynamic? actualPrice;

  AddCartProductResponse({this.message, this.error, this.missmatch, this.subtotal, this.discount, this.total, this.actualPrice});

  AddCartProductResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    missmatch = json['missmatch'];
    subtotal = json['subtotal'];
    discount = json['discount'];
    total = json['total'];
    actualPrice = json['actualPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    data['missmatch'] = this.missmatch;
    data['subtotal'] = this.subtotal;
    data['discount'] = this.discount;
    data['total'] = this.total;
    data['actualPrice'] = this.actualPrice;
    return data;
  }
}

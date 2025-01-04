class GetParticularOrderListModel {
  String? message;
  bool? error;
  GetParticularData? data;

  GetParticularOrderListModel({this.message, this.error, this.data});

  GetParticularOrderListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new GetParticularData.fromJson(json['data']) : null;
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

class GetParticularData {
  dynamic? orderId;
  dynamic? sellerId;
  dynamic? customerId;
  String? orderStatus;
  dynamic? totalAmount;
  String? paymentGateway;
  String? paymentStatus;
  String? orderedProducts;
  String? billingDetails;
  String? deliveryDetails;
  dynamic? contactNumber;
  String? createdAt;

  GetParticularData(
      {this.orderId,
      this.sellerId,
      this.customerId,
      this.orderStatus,
      this.totalAmount,
      this.paymentGateway,
      this.paymentStatus,
      this.orderedProducts,
      this.billingDetails,
      this.deliveryDetails,
      this.contactNumber,
      this.createdAt});

  GetParticularData.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    sellerId = json['sellerId'];
    customerId = json['customerId'];
    orderStatus = json['orderStatus'];
    totalAmount = json['totalAmount'];
    paymentGateway = json['paymentGateway'];
    paymentStatus = json['paymentStatus'];
    orderedProducts = json['orderedProducts'];
    billingDetails = json['billingDetails'];
    deliveryDetails = json['deliveryDetails'];
    contactNumber = json['contactNumber'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['sellerId'] = this.sellerId;
    data['customerId'] = this.customerId;
    data['orderStatus'] = this.orderStatus;
    data['totalAmount'] = this.totalAmount;
    data['paymentGateway'] = this.paymentGateway;
    data['paymentStatus'] = this.paymentStatus;
    data['orderedProducts'] = this.orderedProducts;
    data['billingDetails'] = this.billingDetails;
    data['deliveryDetails'] = this.deliveryDetails;
    data['contactNumber'] = this.contactNumber;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

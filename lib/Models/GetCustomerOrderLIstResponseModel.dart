class GetCustomerResponseModel {
  String? message;
  bool? error;
  List<GetCustomerResponseModelData>? data;

  GetCustomerResponseModel({this.message, this.error, this.data});

  GetCustomerResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetCustomerResponseModelData>[];
      json['data'].forEach((v) {
        data!.add(new GetCustomerResponseModelData.fromJson(v));
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

class GetCustomerResponseModelData {
  dynamic orderId;
  dynamic sellerId;
  dynamic customerId;
  String? orderStatus;
  dynamic totalAmount;
  String? paymentGateway;
  String? paymentStatus;
  dynamic contactNumber;
  String? createdAt;

  GetCustomerResponseModelData(
      {this.orderId,
      this.sellerId,
      this.customerId,
      this.orderStatus,
      this.totalAmount,
      this.paymentGateway,
      this.paymentStatus,
      this.contactNumber,
      this.createdAt});

  GetCustomerResponseModelData.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    sellerId = json['sellerId'];
    customerId = json['customerId'];
    orderStatus = json['orderStatus'];
    totalAmount = json['totalAmount'];
    paymentGateway = json['paymentGateway'];
    paymentStatus = json['paymentStatus'];
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
    data['contactNumber'] = this.contactNumber;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class RegisterCustomerIdResponse {
  String? message;
  bool? error;
  String? customerId;

  RegisterCustomerIdResponse({this.message, this.error, this.customerId});

  RegisterCustomerIdResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    customerId = json['customerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    data['customerId'] = this.customerId;
    return data;
  }
}
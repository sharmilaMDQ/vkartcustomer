class ParticularCustomerResponse {
  String? message;
  bool? error;
  ParticularCustomerResponseData? data;

  ParticularCustomerResponse({this.message, this.error, this.data});

  ParticularCustomerResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new ParticularCustomerResponseData.fromJson(json['data']) : null;
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

class ParticularCustomerResponseData {
  int? customerId;
  String? customerName;
  String? customerMobile;
  String? customerEmail;
  String? customerAddress;
  String? customerCity;
  String? customerState;
  int? customerPincode;
  String? customerCountry;
  String? delivery;
  String? customerProfile;
  String? otherAddress;
  String? otherCity;
  String? otherState;
  int? otherPincode;
  String? otherCountry;
  int? otp;

  ParticularCustomerResponseData(
      {this.customerId,
        this.customerName,
        this.customerMobile,
        this.customerEmail,
        this.customerAddress,
        this.customerCity,
        this.customerState,
        this.customerPincode,
        this.customerCountry,
        this.delivery,
        this.customerProfile,
        this.otherAddress,
        this.otherCity,
        this.otherState,
        this.otherPincode,
        this.otherCountry,
        this.otp});

  ParticularCustomerResponseData.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    customerName = json['customerName'];
    customerMobile = json['customerMobile'];
    customerEmail = json['customerEmail'];
    customerAddress = json['customerAddress'];
    customerCity = json['customerCity'];
    customerState = json['customerState'];
    customerPincode = json['customerPincode'];
    customerCountry = json['customerCountry'];
    delivery = json['delivery'];
    customerProfile = json['customerProfile'];
    otherAddress = json['otherAddress'];
    otherCity = json['otherCity'];
    otherState = json['otherState'];
    otherPincode = json['otherPincode'];
    otherCountry = json['otherCountry'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['customerMobile'] = this.customerMobile;
    data['customerEmail'] = this.customerEmail;
    data['customerAddress'] = this.customerAddress;
    data['customerCity'] = this.customerCity;
    data['customerState'] = this.customerState;
    data['customerPincode'] = this.customerPincode;
    data['customerCountry'] = this.customerCountry;
    data['delivery'] = this.delivery;
    data['customerProfile'] = this.customerProfile;
    data['otherAddress'] = this.otherAddress;
    data['otherCity'] = this.otherCity;
    data['otherState'] = this.otherState;
    data['otherPincode'] = this.otherPincode;
    data['otherCountry'] = this.otherCountry;
    data['otp'] = this.otp;
    return data;
  }
}
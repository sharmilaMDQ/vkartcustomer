class GetCustomerAddressModel {
  String? message;
  bool? error;
  List<GetCustomerAddresses>? data;

  GetCustomerAddressModel({this.message, this.error, this.data});

  GetCustomerAddressModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetCustomerAddresses>[];
      json['data'].forEach((v) {
        data!.add(new GetCustomerAddresses.fromJson(v));
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

class GetCustomerAddresses {
  int? customerAddressId;
  int? customerId;
  String? customerAddress;
  String? customerCity;
  String? customerState;
  String? customerPincode;
  String? customerCountry;
  String? isDefault;
  String? addressType;
  int? mobileNumber;
  String? appartmentName;
  String? landmark;

  GetCustomerAddresses(
      {this.customerAddressId,
      this.customerId,
      this.customerAddress,
      this.customerCity,
      this.customerState,
      this.customerPincode,
      this.customerCountry,
      this.isDefault,
      this.addressType,
      this.mobileNumber,
      this.appartmentName,
      this.landmark});

  GetCustomerAddresses.fromJson(Map<String, dynamic> json) {
    customerAddressId = json['customerAddressId']??0;
    customerId = json['customerId']??0;
    customerAddress = json['customerAddress']??'';
    customerCity = json['customerCity']??'';
    customerState = json['customerState']??'';
    customerPincode = json['customerPincode']??'';
    customerCountry = json['customerCountry']??'';
    isDefault = json['isDefault']??'';
    addressType = json['addressType']??'';
    mobileNumber = json['mobileNumber']??'';
    appartmentName = json['appartmentName']??'';
    landmark = json['landmark']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerAddressId'] = this.customerAddressId;
    data['customerId'] = this.customerId;
    data['customerAddress'] = this.customerAddress;
    data['customerCity'] = this.customerCity;
    data['customerState'] = this.customerState;
    data['customerPincode'] = this.customerPincode;
    data['customerCountry'] = this.customerCountry;
    data['isDefault'] = this.isDefault;
    data['addressType'] = this.addressType;
    data['mobileNumber'] = this.mobileNumber;
    data['appartmentName'] = this.appartmentName;
    data['landmark'] = this.landmark;
    return data;
  }
}

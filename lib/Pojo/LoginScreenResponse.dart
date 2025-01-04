class LoginResponse {
  String? message;
  bool? error;
  Data? data;

  LoginResponse({this.message, this.error, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int? customerId;
  String? firstName;
  String? lastName;
  String? fullName;
  String? customerMobile;
  String? customerprofile;
  String? authtoken;

  Data({this.customerId, 
  this.firstName, 
  this.lastName, 
  this.fullName, 
  this.customerMobile,
  this.customerprofile,this.authtoken});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    customerMobile = json['customerMobile'];
    customerprofile = json["customerImage"];
    authtoken = json["bearerToken"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['fullName'] = this.fullName;
    data['customerMobile'] = this.customerMobile;
    data["customerImage"] = this.customerprofile;
    data["bearerToken"]= this.authtoken;
    return data;
  }
}

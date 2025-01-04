// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    String message;
    bool error;
    ProfileData data;

    ProfileModel({
        required this.message,
        required this.error,
        required this.data,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        message: json["message"],
        error: json["error"],
        data: ProfileData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "data": data.toJson(),
    };
}

class ProfileData {
    int customerId;
    String firstName;
    String lastName;
    String fullName;
    String customerMobile;
    String customerEmail;
    String customerAddress;
    String customerCity;
    String customerState;
    int customerPincode;
    String customerCountry;
    String customerImage;

    ProfileData({
        required this.customerId,
        required this.firstName,
        required this.lastName,
        required this.fullName,
        required this.customerMobile,
        required this.customerEmail,
        required this.customerAddress,
        required this.customerCity,
        required this.customerState,
        required this.customerPincode,
        required this.customerCountry,
        required this.customerImage,
    });

    factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        customerId: json["customerId"]??0,
        firstName: json["firstName"]??'',
        lastName: json["lastName"]??'',
        fullName: json["fullName"]??'',
        customerMobile: json["customerMobile"]??'',
        customerEmail: json["customerEmail"]??'',
        customerAddress: json["customerAddress"]??'',
        customerCity: json["customerCity"]??'',
        customerState: json["customerState"]??'',
        customerPincode: json["customerPincode"]??'',
        customerCountry: json["customerCountry"]??'',
        customerImage: json["customerImage"]??'',
    );

    Map<String, dynamic> toJson() => {
        "customerId": customerId,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": fullName,
        "customerMobile": customerMobile,
        "customerEmail": customerEmail,
        "customerAddress": customerAddress,
        "customerCity": customerCity,
        "customerState": customerState,
        "customerPincode": customerPincode,
        "customerCountry": customerCountry,
        "customerImage": customerImage,
    };
}

class ProfileUpdateModel {
  int customerId;
  dynamic emailId;
  dynamic mobileNumber;
  dynamic address;
  dynamic country;
  dynamic city;
  dynamic state;
  String pincode;
  dynamic name;
  dynamic image;

  ProfileUpdateModel({
    required this.address,
    required this.country,
    required this.customerId,
    required this.emailId,
    required this.mobileNumber,
    required this.name,
    required this.pincode,
    required this.city,
    required this.image,
    required this.state}); 
}
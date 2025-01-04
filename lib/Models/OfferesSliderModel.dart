// // To parse this JSON data, do
// //
// //     final offeresSlider = offeresSliderFromJson(jsonString);
//
// import 'dart:convert';
//
// OfferesSliderModel offeresSliderFromJson(String str) => OfferesSliderModel.fromJson(json.decode(str));
//
// String offeresSliderToJson(OfferesSliderModel data) => json.encode(data.toJson());
//
// class OfferesSliderModel {
//   String message;
//   bool error;
//   OffersData data;
//
//   OfferesSliderModel({
//     required this.message,
//     required this.error,
//     required this.data,
//   });
//
//   factory OfferesSliderModel.fromJson(Map<String, dynamic> json) => OfferesSliderModel(
//     message: json["message"],
//     error: json["error"],
//     data: OffersData.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "error": error,
//     "data": data.toJson(),
//   };
// }
//
// class OffersData {
//   List<Gold> gold1;
//   List<Gold> gold2;
//   List<dynamic> silver1;
//   List<dynamic> silver2;
//   List<dynamic> bronze1;
//   List<dynamic> bronze2;
//
//   OffersData({
//     required this.gold1,
//     required this.gold2,
//     required this.silver1,
//     required this.silver2,
//     required this.bronze1,
//     required this.bronze2,
//   });
//
//   factory OffersData.fromJson(Map<String, dynamic> json) => OffersData(
//     gold1: List<Gold>.from(json["gold-1"].map((x) => Gold.fromJson(x))),
//     gold2: List<Gold>.from(json["gold-2"].map((x) => Gold.fromJson(x))),
//     silver1: List<dynamic>.from(json["silver-1"].map((x) => x)),
//     silver2: List<dynamic>.from(json["silver-2"].map((x) => x)),
//     bronze1: List<dynamic>.from(json["bronze-1"].map((x) => x)),
//     bronze2: List<dynamic>.from(json["bronze-2"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "gold-1": List<dynamic>.from(gold1.map((x) => x.toJson())),
//     "gold-2": List<dynamic>.from(gold2.map((x) => x.toJson())),
//     "silver-1": List<dynamic>.from(silver1.map((x) => x)),
//     "silver-2": List<dynamic>.from(silver2.map((x) => x)),
//     "bronze-1": List<dynamic>.from(bronze1.map((x) => x)),
//     "bronze-2": List<dynamic>.from(bronze2.map((x) => x)),
//   };
// }
//
// class Gold {
//   int carouselAdId;
//   int sellerId;
//   int productId;
//   String adImage;
//   String subscriptionType;
//
//   Gold({
//     required this.carouselAdId,
//     required this.sellerId,
//     required this.productId,
//     required this.adImage,
//     required this.subscriptionType,
//   });
//
//   factory Gold.fromJson(Map<String, dynamic> json) => Gold(
//     carouselAdId: json["carouselAdId"],
//     sellerId: json["sellerId"],
//     productId: json["productId"],
//     adImage: json["adImage"],
//     subscriptionType: json["subscriptionType"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "carouselAdId": carouselAdId,
//     "sellerId": sellerId,
//     "productId": productId,
//     "adImage": adImage,
//     "subscriptionType": subscriptionType,
//   };
// }

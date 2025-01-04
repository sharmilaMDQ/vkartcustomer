// To parse this JSON data, do
//
//     final offeresSliderModel = offeresSliderModelFromJson(jsonString);

import 'dart:convert';

OfferesSliderModel offeresSliderModelFromJson(String str) => OfferesSliderModel.fromJson(json.decode(str));

String offeresSliderModelToJson(OfferesSliderModel data) => json.encode(data.toJson());

class OfferesSliderModel {
    String message;
    bool error;
    OffersData data;

    OfferesSliderModel({
        required this.message,
        required this.error,
        required this.data,
    });

    factory OfferesSliderModel.fromJson(Map<String, dynamic> json) => OfferesSliderModel(
        message: json["message"],
        error: json["error"],
        data: OffersData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "data": data.toJson(),
    };
}

class OffersData {
    List<Gold> gold1;
    List<Gold> gold2;

    OffersData({
        required this.gold1,
        required this.gold2,
    });

    factory OffersData.fromJson(Map<String, dynamic> json) => OffersData(
        gold1: List<Gold>.from(json["gold-1"].map((x) => Gold.fromJson(x))),
        gold2: List<Gold>.from(json["gold-2"].map((x) => Gold.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "gold-1": List<dynamic>.from(gold1.map((x) => x.toJson())),
        "gold-2": List<dynamic>.from(gold2.map((x) => x.toJson())),
    };
}

class Gold {
    int carouselAdId;
    int sellerId;
    String actionType;
    int contentId;
    String adImage;
    String subscriptionType;

    Gold({
        required this.carouselAdId,
        required this.sellerId,
        required this.actionType,
        required this.contentId,
        required this.adImage,
        required this.subscriptionType,
    });

    factory Gold.fromJson(Map<String, dynamic> json) => Gold(
        carouselAdId: json["carouselAdId"],
        sellerId: json["sellerId"],
        actionType: json["actionType"],
        contentId: json["contentId"],
        adImage: json["adImage"],
        subscriptionType: json["subscriptionType"],
    );

    Map<String, dynamic> toJson() => {
        "carouselAdId": carouselAdId,
        "sellerId": sellerId,
        "actionType": actionType,
        "contentId": contentId,
        "adImage": adImage,
        "subscriptionType": subscriptionType,
    };
}

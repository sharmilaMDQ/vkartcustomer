// To parse this JSON data, do
//
//     final offerRowAddsModel = offerRowAddsModelFromJson(jsonString);

import 'dart:convert';

OfferRowAddsModel offerRowAddsModelFromJson(String str) => OfferRowAddsModel.fromJson(json.decode(str));

String offerRowAddsModelToJson(OfferRowAddsModel data) => json.encode(data.toJson());

class OfferRowAddsModel {
    String message;
    bool error;
    RowoffersData? data;

    OfferRowAddsModel({
        required this.message,
        required this.error,
        this.data,
    });

    factory OfferRowAddsModel.fromJson(Map<String, dynamic> json) => OfferRowAddsModel(
        message: json["message"],
        error: json["error"],
        data: json["data"] != null ? RowoffersData.fromJson(json["data"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "data": data != null ? data!.toJson() : null,
    };
}


class RowoffersData {
    List<Gold> gold;

    RowoffersData({
        required this.gold,
    });

    factory RowoffersData.fromJson(Map<String, dynamic> json) => RowoffersData(
        gold: List<Gold>.from(json["gold"].map((x) => Gold.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "gold": List<dynamic>.from(gold.map((x) => x.toJson())),
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
        carouselAdId: json["carouselAdId"]??0,
        sellerId: json["sellerId"]??0,
        actionType: json["actionType"]??'',
        contentId: json["contentId"]??0,
        adImage: json["adImage"]??'',
        subscriptionType: json["subscriptionType"]??'',
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

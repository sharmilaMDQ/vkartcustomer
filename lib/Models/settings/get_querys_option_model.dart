// To parse this JSON data, do
//
//     final getqureyoptionModel = getqureyoptionModelFromJson(jsonString);

import 'dart:convert';

GetqureyoptionModel getqureyoptionModelFromJson(String str) => GetqureyoptionModel.fromJson(json.decode(str));

String getqureyoptionModelToJson(GetqureyoptionModel data) => json.encode(data.toJson());

class GetqureyoptionModel {
    String message;
    bool error;
    List<QuerysoptionData> data;

    GetqureyoptionModel({
        required this.message,
        required this.error,
        required this.data,
    });

    factory GetqureyoptionModel.fromJson(Map<String, dynamic> json) => GetqureyoptionModel(
        message: json["message"],
        error: json["error"],
        data: List<QuerysoptionData>.from(json["data"].map((x) => QuerysoptionData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class QuerysoptionData {
    int queryOptionId;
    String queryTitle;

    QuerysoptionData({
        required this.queryOptionId,
        required this.queryTitle,
    });

    factory QuerysoptionData.fromJson(Map<String, dynamic> json) => QuerysoptionData(
        queryOptionId: json["queryOptionId"],
        queryTitle: json["queryTitle"],
    );

    Map<String, dynamic> toJson() => {
        "queryOptionId": queryOptionId,
        "queryTitle": queryTitle,
    };
}

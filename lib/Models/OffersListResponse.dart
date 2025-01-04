class OffersListResponse {
  String? message;
  bool? error;
  List<OffersListResponseData>? data;

  OffersListResponse({this.message, this.error, this.data});

  OffersListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <OffersListResponseData>[];
      json['data'].forEach((v) {
        data!.add(new OffersListResponseData.fromJson(v));
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

class OffersListResponseData {
  int? offerId;
  String? offerDescription;
  String? offerImage;

  OffersListResponseData({this.offerId, this.offerDescription, this.offerImage});

  OffersListResponseData.fromJson(Map<String, dynamic> json) {
    offerId = json['offerId'];
    offerDescription = json['offerDescription'];
    offerImage = json['offerImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offerId'] = this.offerId;
    data['offerDescription'] = this.offerDescription;
    data['offerImage'] = this.offerImage;
    return data;
  }
}
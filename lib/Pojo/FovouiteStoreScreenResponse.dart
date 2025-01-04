class FavoriteScreenRes {
  String? message;
  bool? error;
  List<Data>? data;

  FavoriteScreenRes({this.message, this.error, this.data});

  FavoriteScreenRes.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? shopName;
  int? id;

  Data({this.shopName, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    shopName = json['shop_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_name'] = this.shopName;
    data['id'] = this.id;
    return data;
  }
}
